//
//  WinnersTableViewCell.swift
//  Race
//
//  Created by Никита Суровцев on 10.07.23.
//

import UIKit

class WinnersTableViewCell: UITableViewCell {

    @IBOutlet weak var medal: UIImageView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var gamerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
