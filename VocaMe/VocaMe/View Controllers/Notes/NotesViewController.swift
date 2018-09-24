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
        static let note = "note"
    }
    var dataManager = DataManager(modelName: "VocaMe")
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Note> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Note.updatedAt), ascending: false)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: self.dataManager.managedObjectContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    private var hasNotes: Bool {
        guard let fetchedObjects = fetchedResultsController.fetchedObjects else { return false }
        return fetchedObjects.count > 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        setupView()
        fetchNotes()
        updateView()
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
        case Segue.note:
            guard let destination = segue.destination as? NoteViewController else { return }
            
            guard let indextPath =  notesTableView.indexPathForSelectedRow  else { return }
            let note = fetchedResultsController.object(at: indextPath)
            destination.note = note
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
        setupMessageLabel()
        setupTableView()
    }
    
    // MARK: -
    
    private func setupMessageLabel() {
        noNotesLabel.text = "You don't have any notes yet."
    }
    
    // MARK: -
    
    private func setupTableView() {
        notesTableView.isHidden = true
    }
    
    private func fetchNotes() {
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            print("Unable to Perform Fetch Request")
            print("\(error), \(error.localizedDescription)")
        }
    }
}

extension NotesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue Reusable Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        // Fetch Note
        let note = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.setup(with: note)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        // Fetch Note
        let note = fetchedResultsController.object(at: indexPath)
        
        // Delete Note
        dataManager.managedObjectContext.delete(note)
    }
    
    func configure(_ cell: NoteTableViewCell, at indexPath: IndexPath) {
        // Fetch Note
        let note = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.setup(with: note)
    }
}
extension NotesViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        notesTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        notesTableView.endUpdates()
        
        updateView()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                notesTableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                notesTableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath, let cell = notesTableView.cellForRow(at: indexPath) as? NoteTableViewCell {
                configure(cell, at: indexPath)
            }
        case .move:
            if let indexPath = indexPath {
                notesTableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let newIndexPath = newIndexPath {
                notesTableView.insertRows(at: [newIndexPath], with: .fade)
            }
        }
    }
}
extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
