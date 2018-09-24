//
//  CategoryViewController.swift
//  VocaMe
//
//  Created by Oanh tran on 9/24/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoryTextField: UITextField!
    
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Category"
        
        setupNameTextField()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Update Category
        if let name = categoryTextField.text, !name.isEmpty {
            category?.name = name
        }
    }

    private func setupNameTextField() {
        // Configure Name Text Field
        categoryTextField.text = category?.name
    }
}
