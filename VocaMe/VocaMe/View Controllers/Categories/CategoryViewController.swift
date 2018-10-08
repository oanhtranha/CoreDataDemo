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
    
    @IBOutlet weak var colorView: UIView!
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Segue.Color:
            guard let destination = segue.destination as? ColorViewController else {
                return
            }
            
            // Configure Destination
            destination.delegate = self
            destination.color = category?.color ?? .white
        default:
            break
        }
    }
    
    private func updateColorView() {
        colorView.layer.cornerRadius = CGFloat(colorView.frame.width / 2.0)
        // Configure Color View
        colorView.backgroundColor = category?.color
    }

    private func setupNameTextField() {
        // Configure Name Text Field
        categoryTextField.text = category?.name
    }
}

extension CategoryViewController : ColorViewControllerDelegate {
    func controller(_ controller: ColorViewController, didPick color: UIColor) {
        category.color  = color
        updateColorView()
    }
  
}
