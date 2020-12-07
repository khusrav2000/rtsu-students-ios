//
//  models.swift
//  TNU.STUDENTS
//
//  Created by mac on 1/30/20.
//  Copyright © 2020 Istiqlol Soft. All rights reserved.
//

import Foundation
import UIKit

struct Message: Codable {
    var message: String?
}

struct StudentsInfo: Codable {
    var RecordBookNumber: String?
    var FullName: Language?
    var Faculty: Language?
    var Specialty: Language?
    var CodeSpecialty: String?
    var TrainingForm: String?
    var TrainingLevel: String?
    var Course: Int8?
    var Group: String?
    var YearUniversityEntrance: String?
    var TrainingPeriod: Int8?
    var IsUchNew: Bool?
}

struct Language: Codable {
    var TJ: String?
    var RU: String?
}

struct Semester: Codable{
    var AcademicYear: String?
    var ID: Int?
    var isActive: Bool?
    
}

struct Course: Codable {
    var SubjectID: Int?
    var SubjectName: Language?
    var TeacherName: Language?
    var FirstRatingWeeks: [WeekPoints]?
    var FirstRatingPoint: Double?
    var SecondRatingWeeks: [WeekPoints]?
    var SecondRatingPoint: Double?
    var ExamPoint: Double?
    var TotalPoint: Double?
    var Mark: String?
    var AdminPoint: Double?
}

struct WeekPoints: Codable {
    var WeekNumber: Int?
    var Point: Double?
    var MaxPoint: Double?
    var IsCurrentWeek: Bool?
}

