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
    fileprivate let thumbSizeValue: CGFloat = 25
    fileprivate let thumbY: CGFloat = 7.5
    fileprivate let trackY: CGFloat = 7.5 + 5

    fileprivate let trackHeight: CGFloat = 10
    
    fileprivate let underThumbValue: CGFloat = 2
    
    // MARK: - UI Elements
    
    fileprivate let thumb = ThumbView(frame: .zero)
    fileprivate let trackView = TrackView(frame: .zero)
    
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
        thumb.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thumb)
        thumb.layer.zPosition = 1
  
        trackView.translatesAutoresizingMaskIntoConstraints = false
        thumb.addSubview(trackView)
        trackView.layer.zPosition = 0
        
        thumb.widthAnchor.constraint(equalToConstant: thumbSizeValue).isActive = true
        thumb.heightAnchor.constraint(equalToConstant: thumbSizeValue).isActive = true
        thumb.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        thumbXConstraint = thumb.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
        thumbXConstraint.isActive = true
        
        
        trackView.heightAnchor.constraint(equalToConstant: trackHeight).isActive = true
        trackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        maximumTrackRightConstraint = trackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        maximumTrackRightConstraint.isActive = true
        trackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
    }
    
    private func setupViewsSettings() {
        thumb.backgroundColor = .clear
        thumb.isUserInteractionEnabled = true
        thumb.layer.cornerRadius = thumbSizeValue / 2
        thumb.layer.masksToBounds = false
        thumb.layer.borderColor = UIColor.yellow.cgColor
        thumb.layer.borderWidth = 2
        
        // tracks 
        
        trackView.backgroundColor = .clear

        
        trackView.maxX = thumbSizeValue
        trackView.maxWidth = UIScreen.main.bounds.width - 30 - thumbSizeValue
        trackView.minWidth = 0
        trackView.setNeedsDisplay()
        trackView.layer.cornerRadius = 5
        trackView.layer.masksToBounds = true
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
                self!.trackView.maxX = point.x + self!.thumbSizeValue
                self!.trackView.maxWidth =  UIScreen.main.bounds.width - 30 - self!.thumbSizeValue - point.x - 2
                self!.trackView.minWidth = point.x + 2 - self!.thumbSizeValue / 2
                self!.trackView.setNeedsDisplay()
                self!.thumbXConstraint.constant = point.x
                
                return
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
    
    // MARK: - Flags
    
    private var isFirstCall = true
    
    // MARK: - values
    
    var minWidth: CGFloat = 0
    var maxX: CGFloat = 0
    var maxWidth: CGFloat = 0
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if !isFirstCall {
            minWidth += 2
        }
        isFirstCall = false 
        let color = UIColor.gray.withAlphaComponent(0.3).cgColor
        guard let  minContext = UIGraphicsGetCurrentContext() else { return }
        minContext.setFillColor(color)
        minContext.fill(CGRect(x: 0, y: 0, width: minWidth, height: 10))
        
        guard let  maxContext = UIGraphicsGetCurrentContext() else { return }
        maxContext.setFillColor(color)
        maxX = maxX - 10 - 2
        maxContext.fill(CGRect(x: maxX, y: 0, width: maxWidth, height: 10))
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
