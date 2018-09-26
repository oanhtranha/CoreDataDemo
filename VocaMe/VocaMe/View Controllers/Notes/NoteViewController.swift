//
//  NoteViewController.swift
//  VocaMe
//
//  Created by Oanh tran on 9/24/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit

private enum Segue {
    static let Categoies = "CategoriesViewController"
}

class NoteViewController: UIViewController {

    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var titleTextField: UITextField!
    
    @IBOutlet weak var categoryLabel: UILabel!
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Note"
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let title =  titleTextField.text, !title.isEmpty {
            note?.title =  title
        }
        
        note?.updatedAt = Date()
        note?.contents = textView.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indetifier = segue.identifier else {
            return
        }
        
        switch indetifier {
        case Segue.Categoies:
            guard let destionation  = segue.destination as? CategoriesViewController else { return }
            destionation.note =  note
        default:
            break
        }
    }
    
    private func setupView() {
        setupTitle()
        setupContent()
    }
    
    private func setupTitle() {
        titleTextField.text = note?.title
    }
    
    private func setupContent() {
        textView.text =  note?.contents
    }
    
    
    @IBAction func editCategory(_ sender: Any) {
    }
}
