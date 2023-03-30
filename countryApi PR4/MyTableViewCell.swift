//
//  MyTableViewCell.swift
//  countryApi PR4
//
//  Created by HARSHID PATEL on 24/03/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var lb2: UILabel!
    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
