//
//  AddCategoryViewController.swift
//  VocaMe
//
//  Created by Oanh tran on 9/24/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit
import CoreData

class AddCategoryViewController: UIViewController {

    var managedObjectContext: NSManagedObjectContext?
    @IBOutlet weak var categoryTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Category"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Show Keyboard
        categoryTextField.becomeFirstResponder()
    }
    
    @IBAction func save(_ sender: Any) {
        guard let managedObjectContext = managedObjectContext else { return }
        guard let name = categoryTextField.text, !name.isEmpty else {
            showAlert(with: "Name Missing", and: "Your category doesn't have a name.")
            return
        }
        
        // Create Category
        let category = Category(context: managedObjectContext)
        
        // Configure Category
        category.name = categoryTextField.text
        
        // Pop View Controller
        _ = navigationController?.popViewController(animated: true)
    }
}
