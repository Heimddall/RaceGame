//
//  MainViewController.swift
//  Race
//
//  Created by Никита Суровцев on 15.07.23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var greetingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "race")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImageView)
        self.view.sendSubviewToBack(backgroundImageView)
        
        let blur = UIBlurEffect(style: .systemThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blur)
        blurEffectView.frame = backgroundImageView.bounds
        blurEffectView.alpha = 0.4
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImageView.addSubview(blurEffectView)
        
        startButton.layer.cornerRadius = startButton.frame.size.width / 2
        startButton.clipsToBounds = true
        
        let container = UIView(frame: startButton.frame)
        container.addSubview(startButton)
        view.addSubview(container)
        
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 20)
        container.layer.shadowOpacity = 0.5
        container.layer.shadowRadius = 20
        container.clipsToBounds = false
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(updateUserName(_:)),
            name: NSNotification.Name("updateUserName"),
            object: nil
    )
        
    }
    
            deinit {
                NotificationCenter.default.removeObserver(self)
            }
            
            @objc
            func updateUserName(_ notification: Notification) {
                var username = "User"
                if let newName = notification.userInfo?["username"] as? String {
                    username = newName
                }
                
                greetingLabel.text = "Hello, \(username)!"
            }
            
    @IBAction func startGame(_ sender: Any) {
        let destination = RaceViewController()
        navigationController?.pushViewController(destination, animated: true)
    }

}