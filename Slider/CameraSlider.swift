//
//  CameraSlider.swift
//  Slider
//
//  Created by Alexsander Khitev on 2/18/17.
//  Copyright © 2017 Alexsander Khitev. All rights reserved.
//

import UIKit

class CameraSlider: UIControl {
    
    // 35 height
    
    // MARK: - Position's values
    fileprivate let thumbSizeValue: CGFloat = 20
    fileprivate let thumbY: CGFloat = 7.5
    fileprivate let minumTrackView = TrackView(frame: .zero)
    fileprivate let maximumTrackView = TrackView(frame: .zero)
    fileprivate let trackY: CGFloat = 7.5 + 5

    
    // MARK: - UI Elements
    
    fileprivate let thumb = ThumbView(frame: .zero)//UIView(frame: .zero)
    
    // MARK: - lifecycle 
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        addUIElements()
        setupViewsSettings()
    }
    
    // MARK: - UI 
    
    private func addUIElements() {
        let mainScreenBounds = UIScreen.main.bounds
        
        let thumbX = mainScreenBounds.width / 2 - thumbSizeValue / 2
        thumb.frame = CGRect(x: thumbX, y: thumbY, width: thumbSizeValue, height: thumbSizeValue)
        addSubview(thumb)
        
        
        minumTrackView.frame = CGRect(x: 0, y: trackY, width: thumbX, height: 10)
        minumTrackView.backgroundColor = .gray
        
        addSubview(minumTrackView)
    }
    
    private func setupViewsSettings() {
        thumb.backgroundColor = .clear
        thumb.isUserInteractionEnabled = true
        thumb.layer.cornerRadius = thumbSizeValue / 2
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
            if point.x > 0 && point.x < self!.frame.width - self!.thumbSizeValue {
                self!.thumb.frame.origin = CGPoint(x: point.x, y: self!.thumbY)
            }
        }) { (completion) in
            
        }
    }
    
}

fileprivate class ThumbView: UIView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }
    
}

fileprivate class TrackView: UIView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }
    
}
