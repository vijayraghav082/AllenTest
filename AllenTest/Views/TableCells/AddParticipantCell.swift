//
//  AddParticipantCell.swift
//  AllenTest
//
//  Created by Vijay Singh Raghav on 19/03/24.
//

import UIKit

protocol AddParticipantProtocol: AnyObject {
    func addParticipant()
}

class AddParticipantCell: UITableViewCell {

    weak var delegate: AddParticipantProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        delegate?.addParticipant()
    }
    
}
