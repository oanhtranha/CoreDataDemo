//
//  NoteTableViewCell.swift
//  VocaMe
//
//  Created by Oanh Tran on 9/20/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var updatedAtLabel: UILabel!
    
    private lazy var updatedAtDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, HH:mm"
        return dateFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(with note: Note) {
        titleLabel.text =  note.title
        contentLabel.text =  note.contents
        updatedAtLabel.text =  updatedAtDateFormatter.string(from:note.updatedAtAsDate)
    }
}
