//
//  Note.swift
//  VocaMe
//
//  Created by Oanh Tran on 9/28/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import Foundation


extension Note {
    
    var updatedAtAsDate: Date {
        guard let updatedAt = updatedAt else { return Date() }
        return Date(timeIntervalSince1970: updatedAt.timeIntervalSince1970)
    }
    
    var createAtAsDate : Date {
        guard let createdAt = createdAt else { return Date() }
        return Date(timeIntervalSince1970: createdAt.timeIntervalSince1970)
    }
    
}
