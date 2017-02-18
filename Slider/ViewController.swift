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
        view.backgroundColor = .black
    }
    
    private func addUISlider() {
        cameraSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cameraSlider)
        cameraSlider.minimumValue = 1
        cameraSlider.maximumValue = 5
        cameraSlider.value = 3
        cameraSlider.isContinuous = true
    }


    private func setupUIElementsPositions() {
        cameraSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cameraSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cameraSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -16).isActive = true
    }
    
}

