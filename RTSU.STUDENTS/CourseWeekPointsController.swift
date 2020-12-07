//
//  CourseWeekPointsController.swift
//  TNU.STUDENTS
//
//  Created by mac on 2/18/20.
//  Copyright © 2020 Istiqlol Soft. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CourseWeekPointsController: UITableViewController, GADInterstitialDelegate {
    
    var position: Int? = nil

    var course: Course? = nil
    var isUchNew: Bool = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        course = StudentData.selectedCourse
        print("is Uhc New? ", StudentData.studentInfo?.IsUchNew)
        isUchNew = StudentData.studentInfo?.IsUchNew ?? true
        print("Secon new uch = ", isUchNew)
        /*if lang == "ru"{
            navigationController?.navigationBar.topItem?.title = course?.SubjectName?.RU
        } else {
            navigationController?.navigationBar.topItem?.title = course?.SubjectName?.TJ
        }*/
        
        navigationController?.navigationBar.barTintColor = Colors.weekPointsNavigationBar
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        tableView.backgroundColor = Colors.weekPointsBackground
        
        
        GAd.interstitial!.delegate = self
        if GAd.interstitial!.isReady {
            GAd.interstitial!.present(fromRootViewController: self)
        } else {
            GAd.interstitial = createAndLoadInterstitial()
        }
    
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        //let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712") //TEST
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-5583392303902725/6812928315")
        interstitial.delegate = self
        print("qwe1")
        let request = GADRequest()
        interstitial.load(request)
        return interstitial
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        GAd.interstitial = createAndLoadInterstitial()
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("error")
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("REcc!")
        ad.present(fromRootViewController: self)
    }
    
    /*func createAndLoadInterstitial() -> GADInterstitial {
        //let interstitial: GADInterstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712") //TEST
        //let interstitial: GADInterstitial = GADInterstitial(adUnitID: "ca-app-pub-5583392303902725/6812928315")
        //let request = GADRequest()
        //GAd.interstitial!.
        //return GAd.interstitial!
    }*/
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isUchNew {
            return 4
        } else {
            return 5
        }
    }
       
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let plus: Int = isUchNew ? 0 : 1
        print("plus = ", plus)
        if section == 0 {
            return (course?.FirstRatingWeeks?.count ?? 0) + plus
        } else if section == 1 {
            return (course?.SecondRatingWeeks?.count ?? 0) + plus
        } else {
            return 0
        }
    }
       
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 110
        } else {
            return 50.0
        }
    }
       
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50.0))
        headerView.backgroundColor = .clear
        let width = UIScreen.main.bounds.width
        let name = UILabel(frame: CGRect(x: 10, y: 10, width: 200, height: 30))
        let point = UILabel(frame: CGRect(x: width - 100, y: 10, width: 90, height: 30))
        point.textAlignment = NSTextAlignment.right
           
        name.textColor = Colors.specialGrey
        point.textColor = .lightGray
        
        let lineView = UIView(frame: CGRect(x: 0, y: 49, width: width, height: 1))
        lineView.backgroundColor = .gray
           
        let lang = UserDefaults.standard.string(forKey: "AppLanguage")
        let plus: Int = isUchNew ? 0 : 1
        
        
        if section == 0 {
            
            headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 110.0)
            
            let lang: String? = UserDefaults.standard.string(forKey: "AppLanguage")
            let label: UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.bounds.width - 20, height: 50))
            
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 18.0)
            label.numberOfLines = 2
            label.textColor = .white
             if lang == "ru"{
                label.text = course?.SubjectName?.RU
            } else {
                label.text = course?.SubjectName?.TJ
            }
            headerView.addSubview(label)
            name.text = "РЕЙТИНГ 1"
            point.text = String(course?.FirstRatingPoint ?? 0.0)
            
            name.frame = CGRect(x: 10, y: 70, width: 200, height: 30)
            point.frame = CGRect(x: width - 100, y: 70, width: 90, height: 30)
            
            lineView.frame = CGRect(x: 0, y: 109, width: width, height: 1)
            if !isUchNew {
                point.isHidden = true
            }
            
        } else if section == 1 {
            name.text = "РЕЙТИНГ 2"
            point.text = String(course?.SecondRatingPoint ?? 0.0)
            if !isUchNew {
                point.isHidden = true
            }
        } else if section == 2 + plus {
            if lang == "ru" {
                name.text = "ЭКЗАМЕН"
            } else {
                name.text = "ИМТИҲОН"
            }
            point.text = String(course?.ExamPoint ?? 0.0)
        } else if section == 3 + plus {
            if lang == "ru" {
                name.text = "БАЛЛ / ОЦЕНКА"
            } else {
                name.text = "ХОЛИ / БАҲОИ НИҲОИ"
            }
            point.text = "\(String(course?.TotalPoint ?? 0.0)) / \(course?.Mark ?? "")"
        } else if !isUchNew && section == 2 {
            name.text = "Административный балл"
            point.text = "\(String(course?.AdminPoint ?? 0.0))"
        }
        
        headerView.addSubview(name)
        headerView.addSubview(point)
        
        
        headerView.backgroundColor = Colors.weekPointsBackground
        headerView.addSubview(lineView)
        
        return headerView
    }
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekPointCell", for: indexPath) as! WeekPointCell
           
        cell.backgroundColor = .clear
        let row = indexPath.row
        let section = indexPath.section
        
        var weekName = "Ҳафтаи"
        let lang = UserDefaults.standard.string(forKey: "AppLanguage")
        if lang == "ru"{
            weekName = "Неделя"
        }
        
        let firsRatingWeekCount: Int = course?.FirstRatingWeeks?.count ?? 0
        let secondRatingWeekCount: Int = course?.SecondRatingWeeks?.count ?? 0
        if !isUchNew && section == 0 && firsRatingWeekCount < row + 1 {
            cell.setValues(name: "Рейтинговый контроль", point: course?.FirstRatingPoint ?? 0.0)
        } else if !isUchNew && section == 1 && secondRatingWeekCount < row + 1 {
            cell.setValues(name: "Рейтинговый контроль", point: course?.SecondRatingPoint ?? 0.0)
        }
        else if section == 0 {
            var adminPoint = ""
            if course?.FirstRatingWeeks?[row].WeekNumber ?? 0 == 9 {
                adminPoint = " (А/Б) "
            }
            cell.setValues(name: "\(weekName) \(String(course?.FirstRatingWeeks?[row].WeekNumber ?? 0)) \(adminPoint)", point: course?.FirstRatingWeeks?[row].Point)
        } else {
            var adminPoint = ""
            if course?.SecondRatingWeeks?[row].WeekNumber ?? 0 == 9 {
                adminPoint = " (А/Б) "
            }
            cell.setValues(name: "\(weekName) \(String(course?.SecondRatingWeeks?[row].WeekNumber ?? 0)) \(adminPoint)", point: course?.SecondRatingWeeks?[row].Point)
        }
           
        return cell
    }
}
