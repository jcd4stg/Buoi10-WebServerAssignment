//
//  Student_TableViewCell.swift
//  Buoi10-WebServerAssignment
//
//  Created by lynnguyen on 25/09/2023.
//

import UIKit

class Student_TableViewCell: UITableViewCell {

    @IBOutlet weak var idLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var ageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
