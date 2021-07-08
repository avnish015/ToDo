//
//  HomeTableViewCell.swift
//  ToDo
//
//  Created by Avnish Kumar on 06/07/21.
//

import UIKit

protocol HomeTableViewCellDelegate:class {
    func editButtonTappedOn(row:Int)
    func deleteButtonTappedOn(row:Int)
}

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate:HomeTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.container.cornerRadius = 8

    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        delegate?.editButtonTappedOn(row: self.tag)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.deleteButtonTappedOn(row: self.tag)
    }
    
}
