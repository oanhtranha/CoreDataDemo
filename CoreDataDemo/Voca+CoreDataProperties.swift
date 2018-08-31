//
//  Voca+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Oanh tran on 8/31/18.
//  Copyright © 2018 activecog. All rights reserved.
//
//

import Foundation
import CoreData


extension Voca {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Voca> {
        return NSFetchRequest<Voca>(entityName: "Voca")
    }

    @NSManaged public var word: String?
    @NSManaged public var meaning: String?

}
