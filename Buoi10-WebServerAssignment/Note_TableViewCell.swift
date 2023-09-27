//
//  Note_TableViewCell.swift
//  Buoi10-WebServerAssignment
//
//  Created by lynnguyen on 26/09/2023.
//

import UIKit

class Note_TableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_Note_Name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
