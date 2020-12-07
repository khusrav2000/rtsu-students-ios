//
//  ProfileController.swift
//  TNU.STUDENTS
//
//  Created by mac on 2/4/20.
//  Copyright © 2020 Istiqlol Soft. All rights reserved.
//

import Foundation
import UIKit

class ProfileController: UIViewController {
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBOutlet weak var generalInfomation: UIView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var studentID: UILabel!
    @IBOutlet weak var otherInformation: UIScrollView!
    
    @IBOutlet weak var facultyName: UILabel!
    @IBOutlet weak var specialty: UILabel!
    @IBOutlet weak var studyForm: UILabel!
    @IBOutlet weak var educationalLevel: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var group: UILabel!
    @IBOutlet weak var entranceYear: UILabel!
    
    @IBOutlet weak var specialityText: UILabel!
    @IBOutlet weak var studyFormText: UILabel!
    @IBOutlet weak var educationLevelText: UILabel!
    @IBOutlet weak var courseText: UILabel!
    @IBOutlet weak var groupText: UILabel!
    @IBOutlet weak var entranceText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Prifile")
        view.setGradientBakcground(colorStart: Colors.gradStart, colorCenter: Colors.gradCenter, colorEnd: Colors.gradEnd)
        
        print(view.bounds.height)
        let oB = otherInformation.frame
        //let vB = view.bounds
        print(oB.origin.x, oB.origin.y, oB.width)
        print(otherInformation.bounds.height, otherInformation.frame.height)
        otherInformation.frame = CGRect(x: oB.origin.x, y: oB.origin.y, width: oB.width, height: oB.height + 49 - (tabBarController?.tabBar.bounds.height ?? 49.0))
        
        print(otherInformation.bounds.height, otherInformation.frame.height)
        generalInfomation.layer.cornerRadius = 10
        otherInformation.layer.cornerRadius = 10
        
        let lang: String? = UserDefaults.standard.string(forKey: "AppLanguage")
        let name: String
        
        print(tabBarController?.tabBar.bounds.height ?? 0.0)
        if lang == "ru"{
            fullName.text = StudentData.studentInfo?.FullName?.RU!
            facultyName.text = StudentData.studentInfo?.Faculty?.RU
            name = StudentData.studentInfo?.Specialty?.RU ?? ""
        } else {
            fullName.text = StudentData.studentInfo?.FullName?.TJ!
            facultyName.text = StudentData.studentInfo?.Faculty?.TJ
            name = StudentData.studentInfo?.Specialty?.TJ ?? ""
        }
        
        studentID.text = StudentData.studentInfo?.RecordBookNumber!
        var raz: CGFloat = 0.0
        raz = raz - facultyName.bounds.height
        facultyName.sizeToFit()
        raz = raz + facultyName.bounds.height
        reYPositionLabel(lab: specialityText, razHeight: raz)
        reYPositionLabel(lab: specialty, razHeight: raz)
        print(raz)
        let code: String = StudentData.studentInfo?.CodeSpecialty ?? ""
        specialty.text = "\(name) (\(code))"
        raz = raz - specialty.bounds.height
        specialty.sizeToFit()
        raz = raz + specialty.bounds.height
        print(raz)
        
        // reYPOSS
        reYPositionLabel(lab: studyFormText, razHeight: raz)
        reYPositionLabel(lab: studyForm, razHeight: raz)
        reYPositionLabel(lab: educationLevelText, razHeight: raz)
        reYPositionLabel(lab: educationalLevel, razHeight: raz)
        reYPositionLabel(lab: courseText, razHeight: raz)
        reYPositionLabel(lab: course, razHeight: raz)
        reYPositionLabel(lab: groupText, razHeight: raz)
        reYPositionLabel(lab: group, razHeight: raz)
        reYPositionLabel(lab: entranceText, razHeight: raz)
        reYPositionLabel(lab: entranceYear, razHeight: raz)
        
        //specialty.preferredMaxLayoutWidth = 70
        studyForm.text = StudentData.studentInfo?.TrainingForm
        educationalLevel.text = StudentData.studentInfo?.TrainingLevel
        
        let now: String = String(StudentData.studentInfo?.Course ?? 0)
        let period: String = String(StudentData.studentInfo?.TrainingPeriod ?? 0)
        
        course.text = "\(now) / \(period)"
        
        group.text = StudentData.studentInfo?.Group
        entranceYear.text = StudentData.studentInfo?.YearUniversityEntrance
        
    }
    
    func reYPositionLabel(lab: UILabel, razHeight: CGFloat) {
        let bounds = lab.frame
        lab.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y + razHeight, width: bounds.width, height: bounds.height)
    }
    
    @IBAction func logout(_ sender: UIButton) {
        
        UserDefaults.standard.set("", forKey: "token")
        
        dismiss(animated: false, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name("RefreshController"), object: nil)
        
        
        //dismiss(animated: true, completion: nil)
        //performSegue(withIdentifier: "logout", sender: self)
    }
    
    
    
}
