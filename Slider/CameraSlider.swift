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
    }
    
    private func setupTrackSettings() {
        minimumTrackTintColor = .gray
        maximumTrackTintColor = .green
    }
    
    
    // MARK: - override functions 
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        
        
        
        return true
    }
    
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        
    }
    
    
}
