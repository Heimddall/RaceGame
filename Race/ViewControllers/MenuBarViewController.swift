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
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var textViewName: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAnimationLottie()
        setupLabelFont()
        setupTextFieldsAttributes()
    }
    
    func setupAnimationLottie() {
        animationView = .init(name: "animation_lkfxb0f9")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView!.play()
    }
    
    func setupTextFieldsAttributes() {
        
        let myAttribute1 = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 20.0)! ]
        let mySubstring = NSMutableAttributedString(string: "Lorem", attributes: myAttribute1 )
        
        let myString = NSAttributedString(string:" ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
        mySubstring.append(myString)
        
        let myRange = NSRange(location: 0, length: 5)
        let anotherAttribute = [ NSAttributedString.Key.backgroundColor: UIColor.yellow ]
        mySubstring.addAttributes(anotherAttribute, range: myRange)
        
        textViewName.attributedText = mySubstring
    }
    
    func setupLabelFont() {
        
        guard let customFont = UIFont(name: "orangejuice", size: 55) else {
            fatalError("""
            Failed to load the "CustomFont-Light" font.
            Make sure the font file is included in the project and the font name is spelled correctly.
            """
            )
        }
        labelName.font = UIFontMetrics.default.scaledFont(for: customFont)
        labelName.adjustsFontForContentSizeCategory = true
    }
}
