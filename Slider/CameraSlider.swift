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
        maximumTrackTintColor = .gray
        
        // 
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 20, y: 0)
        
        
        var i = 0
        
        for subview in subviews {
            debugPrint("subview", subview)
            if i == 0 {
            
                gradient.frame = subview.bounds
              subview.layer.addSublayer(gradient)
            }
            i += 1
        }
        
    }
    
}
