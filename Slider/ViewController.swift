//
//  ViewController.swift
//  Slider
//
//  Created by Alexsander Khitev on 2/18/17.
//  Copyright © 2017 Alexsander Khitev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let cameraSlider = CameraSlider(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        addUISlider()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUIElementsPositions()
    }
    
    private func addUISlider() {
        cameraSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cameraSlider)

    }


    private func setupUIElementsPositions() {
        cameraSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cameraSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cameraSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -30).isActive = true
        cameraSlider.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        
//        cameraSlider.backgroundColor = .red
        cameraSlider.isUserInteractionEnabled = true
    }
    
}

