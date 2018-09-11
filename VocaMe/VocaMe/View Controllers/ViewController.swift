//
//  ViewController.swift
//  VocaMe
//
//  Created by Oanh tran on 9/10/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var dataManager = DataManager(modelName: "VocaMe")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let entityDescription = NSEntityDescription.entity(forEntityName: "Note", in: dataManager.managedObjectContext) {
            
            // Initialize Managed Object
//            let note = NSManagedObject(entity: entityDescription, insertInto: dataManager.managedObjectContext)
//            // Configure Managed Object
//            note.setValue("My First Note", forKey: "title")
//            note.setValue(NSDate(), forKey: "createdAt")
//            note.setValue(NSDate(), forKey: "updatedAt")
//            print(note)
            
            let note = Note(context: dataManager.managedObjectContext)
            // Configure Note
            note.title = "My Second Note 1"
            note.createdAt = Date()
            note.updatedAt = Date()
            
            print(note.title ?? "No Title")
            
            do {
                try dataManager.managedObjectContext.save()
            } catch {
                print("Unable to Save Managed Object Context")
                print("\(error), \(error.localizedDescription)")
            }
        }
    }
}
