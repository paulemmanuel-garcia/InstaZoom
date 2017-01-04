//
//  InstaZoom.swift
//  InstaZoom
//
//  Created by Paul-Emmanuel on 04/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import UIKit

// MARK: - UIImageView extension to easily replicate Instagram zooming feature
extension UIImageView {
    /// Key for associated object
    private struct AssociatedKeys {
        static var ImagePinchKey: Int8 = 0
        static var ImageGestureKey: Int8 = 0
    }
    
    /// The image should zoom on Pinch
    @IBInspectable public var isPinched: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ImagePinchKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ImagePinchKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            
            if pinchGesture == nil {
                inititialize()
            }
        }
    }
    
    /// Associated pinch gesture to the image
    private var pinchGesture: UIPinchGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ImageGestureKey) as? UIPinchGestureRecognizer
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ImageGestureKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// Initialize the pinch gesture
    private func inititialize() {
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(imagePinched(_:)))
        guard  let pinchGesture = pinchGesture else {
            preconditionFailure("Unable to set Pinch Gesture to image")
        }
        addGestureRecognizer(pinchGesture)
    }
    
    /// Perform the pinch to zoom if needed.
    ///
    /// - Parameter sender: UIPinvhGestureRecognizer
    @objc private func imagePinched(_ sender: UIPinchGestureRecognizer) {
        if !isPinched { return }
        
        transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
        if sender.state == .ended {
            UIView.animate(withDuration: 0.3) {
                self.transform = .identity
            }
        }
    }
}
