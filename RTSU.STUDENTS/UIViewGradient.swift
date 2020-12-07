//
//  UIViewGradient.swift
//  TNU.STUDENTS
//
//  Created by mac on 1/26/20.
//  Copyright © 2020 Istiqlol Soft. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func setGradientBakcground(colorStart : UIColor, colorCenter: UIColor, colorEnd: UIColor){
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [colorStart.cgColor, colorCenter.cgColor, colorEnd.cgColor]
       
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        layer.insertSublayer(gradient, at: 0)
    }
}
