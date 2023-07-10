//
//  SettingsTableViewCell.swift
//  Race
//
//  Created by Никита Суровцев on 9.07.23.
//

import UIKit

class OpenSettingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var openSettingName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
