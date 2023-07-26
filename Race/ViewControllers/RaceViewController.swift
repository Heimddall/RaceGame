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
    
    var carPosition = ElementPosition.center
    
    let obstaclesSpeed: Double = 200
    
    var elementSize: CGFloat = 0
    var defaultPadding: CGFloat = 20
    
    let pyramidTopSpacing: CGFloat = 200
    let barrierTopSpacing: CGFloat = 50
    let pyramidBottomSpacing: CGFloat = 700
    let barrierBottomSpacing: CGFloat = 200
    
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        animateObstacles()
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
        
    }
    
    func setupFrames() {
        carImage.contentMode = .scaleAspectFit
        pyramidImage.contentMode = .scaleAspectFit
        barrierImage.contentMode = .scaleAspectFit
        
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
        let yCoordinateOfPyramid = -elementSize - pyramidTopSpacing
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
        let yCoordinateOfBarrier = -elementSize - barrierTopSpacing
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
        
        let destinationPosition: ElementPosition
        if sender.direction == .left {
            switch carPosition {
            case .left, .center:
                destinationPosition = .left
            case .right:
                destinationPosition = .center
            }
        } else {
            switch carPosition {
            case .right, .center:
                destinationPosition = .right
            case .left:
                destinationPosition = .center
            }
        }
        
        moveCarTo(destinationPosition)
    }
    
    
    func moveCarTo(_ position: ElementPosition){
        
        let destinationCoordinate: CGFloat
        
        switch position {
        case .left:
            destinationCoordinate = leftOriginCoordinate
        case .center:
            destinationCoordinate = centerOriginCoordinate
        case .right:
            destinationCoordinate = rightOriginCoordinate
        }
        carPosition = position
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.curveEaseIn],
                       animations: { [weak self] in
            self?.carImage.frame.origin.x = destinationCoordinate
        }
        )
        
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
    
    func animateObstacles() {
        
        let pyramidS = screenHeight + pyramidTopSpacing + pyramidBottomSpacing
        let barrierS = screenHeight + barrierTopSpacing + barrierBottomSpacing
        
        let pyramidT = Double(pyramidS) / obstaclesSpeed
        let barrierT = Double(barrierS) / obstaclesSpeed
        
        UIView.animate(withDuration: pyramidT, delay: 0, options: [.curveLinear, .repeat]){ [weak self] in
            self?.pyramidImage.frame.origin.y = (self?.screenHeight ?? 1000) + (self?.pyramidBottomSpacing ?? 0)
        }
        UIView.animate(withDuration: barrierT, delay: 0, options: [.curveLinear, .repeat]){[weak self] in
            self?.barrierImage.frame.origin.y = (self?.screenHeight ?? 1000) + (self?.barrierBottomSpacing ?? 0)
        }
    }
}
