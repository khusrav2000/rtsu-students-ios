//
//  WeekPointCell.swift
//  TNU.STUDENTS
//
//  Created by mac on 2/13/20.
//  Copyright © 2020 Istiqlol Soft. All rights reserved.
//

import Foundation
import UIKit

class WeekPointCell: UITableViewCell {
    
    @IBOutlet weak var numberWeek: UILabel!
    @IBOutlet weak var weekPoint: UILabel!
    
    func setValues(name: String?, point: Double?){
        numberWeek.text = name ?? ""
        weekPoint.text = "\(String(point ?? 0.0))"
    }
    
}
