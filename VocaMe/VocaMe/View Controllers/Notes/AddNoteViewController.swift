//
//  AddNoteViewController.swift
//  VocaMe
//
//  Created by Oanh tran on 9/10/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Note"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Show Keyboard
        titleTextField.becomeFirstResponder()
    }
    
    @IBAction func save(_ sender: Any) {
        guard let managedObjectContext = managedObjectContext else { return }
        guard let title = titleTextField.text, !title.isEmpty else {
            showAlert(with: "Title Missing", and: "Your note doesn't have a title.")
            return
        }
        
        // Create Note
        let note = Note(context: managedObjectContext)
        
        // Configure Note
        note.createdAt = Date()
        note.updatedAt = Date()
        note.title = titleTextField.text
        note.contents = contentsTextView.text
        
        // Pop View Controller
        _ = navigationController?.popViewController(animated: true)
    }
}

extension UIViewController {
    
    // MARK: - Alerts
    
    func showAlert(with title: String, and message: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Configure Alert Controller
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present Alert Controller
        present(alertController, animated: true, completion: nil)
    }
    
}
