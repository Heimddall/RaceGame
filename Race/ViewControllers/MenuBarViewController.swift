//
//  MenuBarViewController.swift
//  Race
//
//  Created by Никита Суровцев on 17.07.23.
//

import UIKit
import Lottie

class MenuBarViewController: UIViewController {

    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animationView = .init(name: "animation_lkfxb0f9")
        
        animationView!.frame = view.bounds
        
        animationView!.contentMode = .scaleAspectFit
        
        animationView!.loopMode = .loop
        
        animationView!.animationSpeed = 0.5
        
        view.addSubview(animationView!)
        
        animationView!.play()
    }
}
