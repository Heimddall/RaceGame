//
//  ViewController.swift
//  Race
//
//  Created by Никита Суровцев on 9.07.23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var previousSettings = SettingsManager.shared.settings
    lazy var settings: [Setting] = previousSettings
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupBackgroundSetting()
    }
    
    private func setupBackgroundSetting() {
        let vcGradientLayer = CAGradientLayer()
        vcGradientLayer.frame = view.bounds
        vcGradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.clear.cgColor]
        vcGradientLayer.locations = [0.0, 1.0]
        
        view.layer.insertSublayer(vcGradientLayer, at: 0)
        
        let tableGradientLayer = CAGradientLayer()
        tableGradientLayer.frame = tableView.bounds
        tableGradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.clear.cgColor]
        tableGradientLayer.locations = [0.0, 1.0]
        
        tableView.backgroundView = UIView(frame: tableView.bounds)
        tableView.backgroundView?.layer.insertSublayer(tableGradientLayer, at: 0)
    }

    private func setupTable() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCells() {
        let switchSettingsNib = UINib(nibName: "SwitchTableViewCell", bundle: Bundle.main)
        tableView.register(switchSettingsNib, forCellReuseIdentifier: "switchSettingCell")
        
        let openSettingsNib = UINib(nibName: "OpenSettingTableViewCell", bundle: Bundle.main)
        tableView.register(openSettingsNib, forCellReuseIdentifier: "openSettingCell")
    }
    

    @IBAction func cancelChanges(_ sender: Any) {
        settings = previousSettings
        tableView.reloadData()
    }

    @IBAction func saveChanges(_ sender: Any) {
        previousSettings = settings
        SettingsManager.shared.settings = settings
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { settings.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        if settings[index].type == .switchSetting {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "switchSettingCell", for: indexPath) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.switchSettingName.text = settings[index].settingName
            cell.switcher.isOn = (settings[index].settingValue as? Bool) ?? false
            cell.delegate = self
            
            return cell
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "openSettingCell", for: indexPath) as? OpenSettingTableViewCell else {
                return UITableViewCell()
            }
            cell.openSettingName.text = settings[index].settingName
            
            return cell
            
        }
    }
    
    
}

extension SettingsViewController: SwitchSettingDelegate{
    func cell(_ cell: SwitchTableViewCell, changeValueTo isOn: Bool) {
        guard let index = tableView.indexPath(for: cell)?.row else {return}
        settings[index].settingValue = isOn
    }
    
    
}
