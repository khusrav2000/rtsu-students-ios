//
//  CoursePointsController.swift
//  TNU.STUDENTS
//
//  Created by mac on 2/12/20.
//  Copyright © 2020 Istiqlol Soft. All rights reserved.
//

import Foundation
import UIKit

class CoursePointsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var position: Int? = nil
    
    @IBOutlet weak var weekPoints: UITableView!
    var course: Course? = nil
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        view.setGradientBakcground(colorStart: Colors.gradStart, colorCenter: Colors.gradCenter, colorEnd: Colors.gradEnd)
        
        weekPoints.delegate = self
        weekPoints.dataSource = self
        
        course = StudentData.courses?[position ?? 0]
        weekPoints.backgroundColor = Colors.weekPointsBackground
        //weekPoints.backgroundColor = .clear
        
        let path = UIBezierPath(roundedRect: weekPoints.bounds, byRoundingCorners: [.topLeft, .topRight] , cornerRadii: CGSize(width: 20, height: 20))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        weekPoints.layer.mask = maskLayer
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return course?.FirstRatingWeeks?.count ?? 0
        } else if section == 1 {
            return course?.SecondRatingWeeks?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30.0))
        headerView.backgroundColor = .clear
        
        let name = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        let point = UILabel(frame: CGRect(x: 200, y: 0, width: 100, height: 30))
        
        name.textColor = .white
        point.textColor = .white
        
        if section == 0 {
            name.text = "РЕЙТИНГ 1"
            point.text = String(course?.FirstRatingPoint ?? 0.0)
        } else if section == 1 {
            name.text = "РЕЙТИНГ 2"
            point.text = String(course?.SecondRatingPoint ?? 0.0)
        } else if section == 2 {
            name.text = "ИМТИҲОН"
            point.text = String(course?.ExamPoint ?? 0.0)
        } else if section == 3 {
            name.text = "ХОЛИ / БАҲОИ НИҲОИ"
            point.text = String(course?.TotalPoint ?? 0.0)
        }
        headerView.addSubview(name)
        headerView.addSubview(point)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekPointCell", for: indexPath) as! WeekPointCell
        
        cell.backgroundColor = .clear
        let row = indexPath.row
        let section = indexPath.section
        if section == 0 {
            cell.setValues(name: "Ҳафтаи \(String(course?.FirstRatingWeeks?[row].WeekNumber ?? 0))", point: course?.FirstRatingWeeks?[row].Point)
        } else {
            cell.setValues(name: "Ҳафтаи \(String(course?.SecondRatingWeeks?[row].WeekNumber ?? 0))", point: course?.SecondRatingWeeks?[row].Point)
        }
        
        return cell
    }
    
    
    
    
    
}
