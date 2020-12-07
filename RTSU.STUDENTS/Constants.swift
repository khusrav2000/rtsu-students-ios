//
//  Constants.swift
//  TNU.STUDENTS
//
//  Created by mac on 1/31/20.
//  Copyright © 2020 Istiqlol Soft. All rights reserved.
//

import Foundation
import Firebase

struct StudentData {
    
    static var studentInfo: StudentsInfo? = nil
    static var semesters: [Semester]? = nil
    static var courses: [Course]? = nil
    static var selectedCourse: Course? = nil

}

struct IncLoadData {
    static var inCorrectLogOrPass = false
    static var serverNotResponse = false
    static var errorOnLoadData = false
}

struct GAd {
    static var interstitial: GADInterstitial? = nil
}
