//
//  CameraSlider.swift
//  Slider
//
//  Created by Alexsander Khitev on 2/18/17.
//  Copyright © 2017 Alexsander Khitev. All rights reserved.
//

import UIKit

class CameraSlider: UISlider {
    
    // MARK: - Flags
    
    private var isSettingsSetup = false

    override func draw(_ rect: CGRect) {
        super.draw(rect)
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isSettingsSetup {
            getThumbView()
            setupTrackSettings()
            isSettingsSetup = true
        }
    }
  
    // MARK: - Property
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        super.trackRect(forBounds: bounds)
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: 5))
    }
    

    
    // MARK: - UI 
    
    private func getThumbView() {
        setThumbImage(UIImage(named: "Circle"), for: .normal)
        guard let thumbImageView = subviews.last as? UIImageView else { return }
        thumbImageView.tintColor = .yellow
        debugPrint(thumbImageView.frame)
    }
    
    private func setupTrackSettings() {
        minimumTrackTintColor = .gray
        maximumTrackTintColor = .green
        
        
        let minumumGradient = CAGradientLayer()
        let frame = CGRect(x: 0, y: 0, width: bounds.width / 2, height: 5.0 )
        minumumGradient.frame = frame
        minumumGradient.colors = [UIColor.yellow.cgColor, UIColor.yellow.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        minumumGradient.startPoint = CGPoint(x: 0, y:  1)
        minumumGradient.endPoint = CGPoint(x: 1.79, y:  1)
        minumumGradient.locations =  [0, 0.5, 0.5, 1.0]
        
        UIGraphicsBeginImageContextWithOptions(minumumGradient.frame.size, false, 0)
        minumumGradient.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setMinimumTrackImage(image?.resizableImage(withCapInsets:.zero),  for: .normal)
        
        
        
        let maximumGradient = CAGradientLayer()
        let maximumFrame = CGRect(x: 0, y: 0, width: bounds.width / 2, height: 5.0)
        maximumGradient.frame = maximumFrame
        maximumGradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.yellow.cgColor, UIColor.yellow.cgColor]
        maximumGradient.startPoint = CGPoint(x: 1.79, y:  1)
        maximumGradient.endPoint = CGPoint(x: 0, y:  1)
        maximumGradient.locations =  [0, 0.5, 0.5, 1.0]
        
        UIGraphicsBeginImageContextWithOptions(maximumGradient.frame.size, false, 0)
        maximumGradient.render(in: UIGraphicsGetCurrentContext()!)
        let maximumImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setMaximumTrackImage(maximumImage?.resizableImage(withCapInsets:.zero),  for: .normal)
    }
    
    
    // MARK: - override functions 
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        guard let thumbImageView = subviews.last as? UIImageView else { return true }
        debugPrint(thumbImageView.frame)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        guard let thumbImageView = subviews.last as? UIImageView else { return true }
        debugPrint(thumbImageView.frame)
        
        
        return true
    }
    
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        
    }
    
    
}
