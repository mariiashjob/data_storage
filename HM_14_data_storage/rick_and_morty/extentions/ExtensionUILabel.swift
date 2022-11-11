//
//  ExtentionUILabel.swift
//  HM_12_carthage_and_alamofire
//
//  Created by m.shirokova on 02.11.2022.
//

import UIKit

extension UILabel {
    
    func updateTextColor(_ color: UIColor) {
        textColor = color
    }
    
    func changeBulletColor(status: String) {
        
        let status = status.lowercased()
        
        switch status {
        case "alive":
            updateTextColor(.green)
        case "dead":
            updateTextColor(.red)
        case "unknown":
            updateTextColor(.gray)
        default:
            updateTextColor(.gray)
        }
    }
}
