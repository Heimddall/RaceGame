//
//  NotWinnersTableViewCell.swift
//  Race
//
//  Created by Никита Суровцев on 10.07.23.
//

import UIKit

class NotWinnersTableViewCell: UITableViewCell {

    @IBOutlet weak var positionStats: UILabel!
    @IBOutlet weak var gamerName: UILabel!
    @IBOutlet weak var score: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
