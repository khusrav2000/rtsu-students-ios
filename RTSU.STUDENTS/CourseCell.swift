//
//  CourseCell.swift
//  TNU.STUDENTS
//
//  Created by mac on 2/12/20.
//  Copyright © 2020 Istiqlol Soft. All rights reserved.
//

import Foundation
import UIKit

class CourseCell: UITableViewCell {
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var progressPoint: CircularProgressView!
    @IBOutlet weak var totalPoint: UILabel!
    
    
    
    func setCourse(course: Course?){
        
        let lang: String? = UserDefaults.standard.string(forKey: "AppLanguage")
        
        if lang == "ru" {
            courseName.text = course?.SubjectName?.RU!
            teacherName.text = course?.TeacherName?.RU!
        } else {
            courseName.text = course?.SubjectName?.TJ!
            teacherName.text = course?.TeacherName?.TJ!
        }
        
        progressPoint.trackColor = Colors.trackProgress
        progressPoint.progressColor = Colors.progressPoint
        progressPoint.createCircularPath(point: course?.TotalPoint ?? 0.0)
        totalPoint.text = "\(course?.TotalPoint ?? 0.0)"
        
    }
    
}
