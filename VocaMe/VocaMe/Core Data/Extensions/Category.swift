//
//  Category.swift
//  VocaMe
//
//  Created by Oanh Tran on 9/28/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import Foundation

extension Category {
    
    var color: UIColor? {
        get {
            guard let hex = colorAsHex else { return nil }
            return UIColor(hex: hex)
        }
        
        set(newColor) {
            if let newColor = newColor {
                colorAsHex = newColor.toHex
            }
        }
    }
    
}
