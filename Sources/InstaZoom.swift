//
//  InstaZoom.swift
//  InstaZoom
//
//  Created by Paul-Emmanuel on 04/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import UIKit

// MARK: - UIImageView extension to easily replicate Instagram zooming feature
public extension UIImageView {
    /// Key for associated object
    private struct AssociatedKeys {
        static var ImagePinchKey: Int8 = 0
        static var ImageGestureKey: Int8 = 0
    }
    
    /// The image should zoom on Pinch
    public var isPinchable: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ImagePinchKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ImagePinchKey, newValue, .OBJC_ASSOCIATION_RETAIN)

            if pinchGesture == nil {
                inititialize()
            }

            if newValue {
                isUserInteractionEnabled = true
                addGestureRecognizer(pinchGesture!)
            } else {
                removeGestureRecognizer(pinchGesture!)
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
        if  pinchGesture == nil {
            preconditionFailure("Unable to set Pinch Gesture to image")
        }
    }
    
    /// Perform the pinch to zoom if needed.
    ///
    /// - Parameter sender: UIPinvhGestureRecognizer
    @objc private func imagePinched(_ sender: UIPinchGestureRecognizer) {
        transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
        if sender.state == .ended {
            UIView.animate(withDuration: 0.3) {
                self.transform = .identity
            }
        }
    }
}
