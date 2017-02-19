//
//  CameraSlider.swift
//  Slider
//
//  Created by Alexsander Khitev on 2/18/17.
//  Copyright © 2017 Alexsander Khitev. All rights reserved.
//

import UIKit

class CameraSlider: UIControl {
    
    fileprivate let thumb = UIView(frame: .zero)
    
    // MARK: - lifecycle 
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        addUIElements()
        setupViewsSettings()
    }
    
    // MARK: - UI 
    
    private func addUIElements() {
        let mainScreenBounds = UIScreen.main.bounds
        thumb.frame = CGRect(x: mainScreenBounds.width / 2 - 18, y: -15.5, width: 36, height: 36)
        addSubview(thumb)
    }
    
    private func setupViewsSettings() {
        thumb.backgroundColor = .clear
        thumb.isUserInteractionEnabled = true
        thumb.layer.cornerRadius = 36 / 2
        thumb.layer.masksToBounds = true
        thumb.layer.borderColor = UIColor.black.cgColor
        thumb.layer.borderWidth = 2
    }
    
    // MARK: - Delegates
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        animation(touch)

        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        
        let point = touch.location(in: self)
        debugPrint("touch", point)
        animation(touch)
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        
        guard touch != nil else { return }
        animation(touch!)
    }
    
    // MARK: - Animation
    
    private func animation(_ touch: UITouch) {
        let point = touch.location(in: self)
        
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            guard self != nil else { return }
            if point.x > 0 && point.x < self!.frame.width {
                self!.thumb.frame.origin = CGPoint(x: point.x, y: -15.5)
            }
        }) { (completion) in
            
        }
    }
    
}
