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
    fileprivate let trackY: CGFloat = 7.5 + 5

    fileprivate let trackHeight: CGFloat = 10
    
    fileprivate let underThumbValue: CGFloat = 2
    
    // MARK: - UI Elements
    
    fileprivate let thumb = ThumbView(frame: .zero)//UIView(frame: .zero)
    fileprivate let minumTrackView = TrackView(frame: .zero)
    fileprivate let maximumTrackView = TrackView(frame: .zero)
    
    // MARK: - Constraints 
    
    fileprivate var thumbXConstraint: NSLayoutConstraint!
    fileprivate var maximumTrackRightConstraint: NSLayoutConstraint!
    
    // MARK: - lifecycle 
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        addUIElements()
        setupViewsSettings()
    }
    
    // MARK: - UI 
    
    private func addUIElements() {
        let mainScreenBounds = UIScreen.main.bounds
        
        // MARK: - warning minus value from main screen width
        
        thumb.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thumb)
        thumb.layer.zPosition = 1
        
        minumTrackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(minumTrackView)
        minumTrackView.layer.zPosition = 0
        
        maximumTrackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(maximumTrackView)
        maximumTrackView.layer.zPosition = 0
        
        
        thumb.widthAnchor.constraint(equalToConstant: thumbSizeValue).isActive = true
        thumb.heightAnchor.constraint(equalToConstant: thumbSizeValue).isActive = true
        thumb.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        thumbXConstraint = thumb.leftAnchor.constraint(equalTo: leftAnchor, constant: (mainScreenBounds.width - 30) / 2 - thumbSizeValue / 2)
        thumbXConstraint.isActive = true
        
        maximumTrackView.heightAnchor.constraint(equalToConstant: trackHeight).isActive = true
        maximumTrackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        maximumTrackRightConstraint = maximumTrackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        maximumTrackRightConstraint.isActive = true
        
        maximumTrackView.leftAnchor.constraint(equalTo: thumb.rightAnchor, constant: -2).isActive = true
    }
    
    private func setupViewsSettings() {
        thumb.backgroundColor = .clear
        thumb.isUserInteractionEnabled = true
        thumb.layer.cornerRadius = thumbSizeValue / 2
        thumb.layer.masksToBounds = true
        thumb.layer.borderColor = UIColor.yellow.cgColor
        thumb.layer.borderWidth = 2
        
        
        // tracks 
        
        maximumTrackView.backgroundColor = .gray
        
        backgroundColor = .red
    }
    
    // MARK: - Delegates
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        animation(touch)

        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        
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
                
                self!.maximumTrackRightConstraint.constant = -10

                
                self!.thumbXConstraint.constant = point.x
                
                return
            }
            
            if point.x > 0 {
              
                self!.maximumTrackRightConstraint.constant = -10
                self!.thumbXConstraint.constant = point.x
                
                return
            }
            
            
            
            if point.x < 0 {
              
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

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
