//
//  OpenTableViewCell.swift
//  Race
//
//  Created by Никита Суровцев on 9.07.23.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var switcher: UISwitch!
    
    @IBOutlet weak var switchSettingName: UILabel!
    
    weak var delegate: SwitchSettingDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        delegate?.cell(self, changeValueTo: switcher.isOn)
    }
}

protocol SwitchSettingDelegate: AnyObject {
    func cell(_ cell: SwitchTableViewCell, changeValueTo isOn: Bool)
}
