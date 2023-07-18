//
//  RaceViewController.swift
//  Race
//
//  Created by Никита Суровцев on 16.07.23.
//

import UIKit

class RaceViewController: UIViewController {
    
    
    // MARK: - Additional Types
    enum ElementPosition {
        case left, center, right
    }
    
    //MARK: - UI-Elements
    @IBOutlet weak var carPositionSegmentControl: UISegmentedControl!
    
    var carImage = UIImageView(image: UIImage(named: "car"))
    var pyramidImage = UIImageView(image: UIImage(named: "warning_pyramid"))
    var barrierImage = UIImageView(image: UIImage(named: "traffic_barrier"))
    
    //MARK: - UI-Coordinates
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    var bottomSafeAreaPadding: CGFloat = 0
    var topSafeAreaPadding: CGFloat = 0
    var navigationBarHeight: CGFloat = 0
    
    var leftOriginCoordinate: CGFloat = 0
    var centerOriginCoordinate: CGFloat = 0
    var rightOriginCoordinate: CGFloat = 0
    
    var elementSize: CGFloat = 0
    var defaultPadding: CGFloat = 20
    
    var ySidesOrigin: CGFloat = 0
    var sideWidth: CGFloat = 0
    var sideHeight: CGFloat = 0
    var xRightSideOrigin: CGFloat = 0
    
    
    //MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lSwipe = UISwipeGestureRecognizer()
        lSwipe.direction = .left
        lSwipe.addTarget(self, action: #selector(swipe))
        
        let rSwipe = UISwipeGestureRecognizer()
        rSwipe.direction = .right
        rSwipe.addTarget(self, action: #selector(swipe))
        
        view.addGestureRecognizer(lSwipe)
        view.addGestureRecognizer(rSwipe)
        
        setupBackground()
    }
    
    override func viewWillAppear (_ animated: Bool) {
        setupCoordinates()
        setupFrames()
    }
    
    //MARK: - Setup Views
    
    func setupBackground() {
        let backgroundImage = UIImageView(image: UIImage(named: "road"))
        backgroundImage.contentMode = .scaleToFill
        backgroundImage.frame = view.bounds
        backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
    
    func setupCoordinates() {
        screenWidth = view.frame.size.width
        screenHeight = view.frame.size.height
        bottomSafeAreaPadding = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        topSafeAreaPadding = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        navigationBarHeight = navigationController?.navigationBar.frame.size.height ?? 0
        
        elementSize = screenWidth * 7 / 25
        leftOriginCoordinate = elementSize / 14
        centerOriginCoordinate = elementSize + 7/2 * leftOriginCoordinate
        rightOriginCoordinate = 2 * elementSize + 7 * leftOriginCoordinate
        
        ySidesOrigin = topSafeAreaPadding + navigationBarHeight
        sideWidth = screenWidth/2
        sideHeight = screenHeight - topSafeAreaPadding - navigationBarHeight - bottomSafeAreaPadding
        xRightSideOrigin = screenWidth/2
    }
    
    func setupFrames() {
        carImage.contentMode = .scaleAspectFit
        pyramidImage.contentMode = .scaleAspectFit
        barrierImage.contentMode = .scaleAspectFit
        
        carPositionSegmentControl.selectedSegmentIndex = 1
        
        setupCar()
        setupPyramid()
        setupBarrier()
    }
    
    func setupCar() {
        let yCoordinateOfCar = screenHeight - bottomSafeAreaPadding - defaultPadding - elementSize
        carImage.frame = CGRect(x: centerOriginCoordinate,
                                y: yCoordinateOfCar,
                                width: elementSize,
                                height: elementSize)
        
        carImage.layer.shadowColor = UIColor.gray.cgColor
        carImage.layer.shadowOpacity = 0
        carImage.layer.shadowOffset = CGSize(width: 0, height: -90)
        carImage.layer.shadowRadius = 0
        
        UIView.animate(withDuration: 1) { [weak self] in
            self?.carImage.layer.shadowColor = UIColor.yellow.cgColor
            self?.carImage.layer.shadowOpacity = 1
            self?.carImage.layer.shadowOffset = CGSize(width: 0, height: -90)
            self?.carImage.layer.shadowRadius = 30
            
        }
        
        view.addSubview(carImage)
    }
    
    func setupPyramid() {
        let yCoordinateOfPyramid = (screenHeight - elementSize) / 2
        pyramidImage.frame = CGRect(x: rightOriginCoordinate,
                                    y: yCoordinateOfPyramid,
                                    width: elementSize,
                                    height: elementSize)
        
        pyramidImage.layer.shadowColor = UIColor.black.cgColor
        pyramidImage.layer.shadowOpacity = 1
        pyramidImage.layer.shadowOffset = .zero
        pyramidImage.layer.shadowRadius = 25
        
        view.addSubview(pyramidImage)
    }
    
    func setupBarrier() {
        let yCoordinateOfBarrier = topSafeAreaPadding + navigationBarHeight + defaultPadding
        barrierImage.frame = CGRect(x: leftOriginCoordinate,
                                    y: yCoordinateOfBarrier,
                                    width: elementSize,
                                    height: elementSize)
        
        barrierImage.layer.shadowColor = UIColor.black.cgColor
        barrierImage.layer.shadowOpacity = 1
        barrierImage.layer.shadowOffset = .zero
        barrierImage.layer.shadowRadius = 20
        
        view.addSubview(barrierImage)
    }
    
    
    //MARK: - Moves
    @objc
    func swipe(sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
        case .left where carImage.frame.origin.x == centerOriginCoordinate :
                moveCarTo(.left)
        case .left where carImage.frame.origin.x == rightOriginCoordinate:
                moveCarTo(.center)
        case .right where carImage.frame.origin.x == centerOriginCoordinate:
                moveCarTo(.right)
//        case .right where carImage.frame.origin.x == leftOriginCoordinate:
//                moveCarTo(.center)
        case .right where abs(carImage.frame.origin.x - leftOriginCoordinate) < 0.01:
            moveCarTo(.center)
        default:
            break
        }
    }
    
    @IBAction func changeCarPosition(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            movePyramidTo(.center)
            moveBarrierTo(.right)
        case 2:
            movePyramidTo(.left)
            moveBarrierTo(.center)
        default:
            movePyramidTo(.right)
            moveBarrierTo(.left)
        }
    }
    
    func moveCarTo(_ position: ElementPosition){
        switch position {
        case .left:
            carImage.frame.origin.x = leftOriginCoordinate
        case .center:
            carImage.frame.origin.x = centerOriginCoordinate
        case .right:
            carImage.frame.origin.x = rightOriginCoordinate
        }
    }
    
    func movePyramidTo(_ position: ElementPosition){
        switch position {
        case .left:
            pyramidImage.frame.origin.x = leftOriginCoordinate
        case .center:
            pyramidImage.frame.origin.x = centerOriginCoordinate
        case .right:
            pyramidImage.frame.origin.x = rightOriginCoordinate
        }
    }
    
    func moveBarrierTo(_ position: ElementPosition){
        switch position {
        case .left:
            barrierImage.frame.origin.x = leftOriginCoordinate
        case .center:
            barrierImage.frame.origin.x = centerOriginCoordinate
        case .right:
            barrierImage.frame.origin.x = rightOriginCoordinate
        }
    }
}
