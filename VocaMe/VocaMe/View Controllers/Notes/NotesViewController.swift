//
//  NotesViewController.swift
//  VocaMe
//
//  Created by Oanh tran on 9/10/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit
import CoreData


class NotesViewController: UIViewController {
    
    @IBOutlet private weak var noNotesLabel: UILabel!
    @IBOutlet private weak var notesTableView: UITableView!
    private enum Segue {
        static let AddNote = "AddNote"
    }
    var dataManager = DataManager(modelName: "VocaMe")
    private var notes: [Note]? {
        didSet {
            updateView()
        }
    }
    
    private var hasNotes: Bool {
        guard let notes = notes else { return false}
        return notes.count > 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        setupView()
        fetchNotes()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Segue.AddNote:
            guard let destination = segue.destination as? AddNoteViewController else {
                return
            }
            // Configure Destination
            destination.managedObjectContext = dataManager.managedObjectContext
        default:
            break
        }
    }
    
    // MARK: _
    
    func updateView() {
        notesTableView.isHidden = !hasNotes
        noNotesLabel.isHidden = hasNotes
    }
    
    func setupView() {
        
    }
    
    private func fetchNotes() {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Note.updatedAt), ascending: false)]
        
        // Perform Fetch Request
        dataManager.managedObjectContext.performAndWait {
            do {
                // Execute Fetch Request
                let notes = try fetchRequest.execute()
                
                // Update Notes
                self.notes = notes
                
                // Reload Table View
                self.notesTableView.reloadData()
                
            } catch {
                let fetchError = error as NSError
                print("Unable to Execute Fetch Request")
                print("\(fetchError), \(fetchError.localizedDescription)")
            }
        }
    }
}

extension NotesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return notes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let note = notes?[indexPath.row] else {
            fatalError("Unexpected Index Path")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteTableViewCell else {
                fatalError("Unexpected Index path")
        }
        cell.setup(with: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

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
