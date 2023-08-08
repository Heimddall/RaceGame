//
//  ViewController.swift
//  Race
//
//  Created by Никита Суровцев on 9.07.23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let settingsList = ["Music", "Sound", "Obstacles", "Car Color", "User Name"]
    let isSwitchSetting = [true, true, false, false, false]
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var settings: SettingsManager = SettingsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupBackgroundSetting()
    }
    
    private func setupBackgroundSetting() {
        let vcGradientLayer = CAGradientLayer()
        vcGradientLayer.frame = view.bounds
        vcGradientLayer.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor]
        vcGradientLayer.locations = [0.1, 3.0]
        
        view.layer.insertSublayer(vcGradientLayer, at: 0)
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
        tableView.reloadData()
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        tableView.reloadData()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { settingsList.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        if isSwitchSetting[index] {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "switchSettingCell", for: indexPath) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.switchSettingName.text = settingsList[index]
            cell.switcher.isOn = isOnSetting(withName: settingsList[index])
            cell.delegate = self
            
            return cell
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "openSettingCell", for: indexPath) as? OpenSettingTableViewCell else {
                return UITableViewCell()
            }
            cell.openSettingName.text = settingsList[index]
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.row
        
        if isSwitchSetting[index] {
            guard let cell = tableView.cellForRow(at: indexPath) as? SwitchTableViewCell else { return }
            cell.switcher.isOn.toggle()
            toggleSetting(withName: settingsList[index])
        } else if settingsList[index] == "User Name" {
            var placeholder = "User Name"
            if settings.userName.count > 0 {
                placeholder = settings.userName
            }
            presentAlert(
                title: "Hello",
                message: "Input User Name",
                placeholder: placeholder
            ) { [weak self] input in
                guard input.count > 0 else { return }
                self?.settings.userName = input
                NotificationCenter.default.post(
                    name: NSNotification.Name("updateUserName"),
                    object: nil,
                    userInfo: ["username": input]
                )
            }
        } else {
            self.present(UIViewController(), animated: true)
        }
    }
    
    private func presentAlert(
        title: String,
        message: String,
        placeholder: String = "",
        handler: ((String) -> ())? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { textfield in
            textfield.placeholder = placeholder
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  text.count > 0 else { return }
            
            let filteredText = text // "text   text"
                .components(separatedBy: CharacterSet.whitespacesAndNewlines) // ["text", "", "", "text"]
                .filter { string in
                    string.count > 0
                } // ["text", "text"]
                .joined(separator: " ") // "text text"
            
            handler?(filteredText)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func isOnSetting(withName name: String) -> Bool {
        switch name {
        case "Music":
            return settings.isMusicOn
        case "Sound":
            return settings.isSoundOn
        default:
            return false
        }
    }
    
    private func toggleSetting(withName name: String) {
        switch name {
        case "Music":
            settings.isMusicOn.toggle()
        case "Sound":
            settings.isSoundOn.toggle()
        default:
            return
        }
    }
    
    private func SetSetting(withName name: String, to value: Bool) {
        switch name {
        case "Music":
            settings.isMusicOn = value
        case "Sound":
            settings.isSoundOn = value
        default:
            return
        }
    }
}


extension SettingsViewController: SwitchSettingDelegate{
    func cell(_ cell: SwitchTableViewCell, changeValueTo isOn: Bool) {
        guard let index = tableView.indexPath(for: cell)?.row else {return}
        SetSetting(withName: settingsList[index], to: isOn)
    }
    
}


