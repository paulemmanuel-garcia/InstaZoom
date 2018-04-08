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
        static var ImagePinchGestureKey: Int8 = 1
        static var ImagePanGestureKey: Int8 = 2
        static var ImageScaleKey: Int8 = 3
        static var PinchCenterKey: Int8 = 4
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
                pinchGesture.map { addGestureRecognizer($0) }
                panGesture.map { addGestureRecognizer($0) }
            } else {
                pinchGesture.map { removeGestureRecognizer($0) }
                panGesture.map { removeGestureRecognizer($0) }
            }
        }
    }

    /// Associated image's pinch gesture
    private var pinchGesture: UIPinchGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ImagePinchGestureKey) as? UIPinchGestureRecognizer
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ImagePinchGestureKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    /// Associated image's pan gesture
    private var panGesture: UIPanGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ImagePanGestureKey) as? UIPanGestureRecognizer
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ImagePanGestureKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    /// Associated image's scale -- there might be no need
    private var scale: CGFloat {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.ImageScaleKey) as? CGFloat) ?? 1.0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ImageScaleKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// The center from which the image is pinched
    private var pinchCenter: CGPoint {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.PinchCenterKey) as? CGPoint ?? CGPoint(x: bounds.midX, y: bounds.midY)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.PinchCenterKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// Initialize pinch & pan gestures
    private func inititialize() {
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(imagePinched(_:)))
        pinchGesture?.delegate = self
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(imagePanned(_:)))
        panGesture?.delegate = self
    }

    /// Perform the pinch to zoom if needed.
    ///
    /// - Parameter sender: UIPinvhGestureRecognizer
    @objc private func imagePinched(_ pinch: UIPinchGestureRecognizer) {
        switch pinch.state {
        case .began:
            pinchCenter = CGPoint(x: pinch.location(in: self).x - bounds.midX,
                                  y: pinch.location(in: self).y - bounds.midY)
        case .changed:
            if pinch.scale >= 1.0 {
                scale = pinch.scale
                transform(withTranslation: .zero)
            }
        default:
            reset()
        }
    }
    
    /// Perform the panning if needed
    ///
    /// - Parameter sender: UIPanGestureRecognizer
    @objc private func imagePanned(_ pan: UIPanGestureRecognizer) {
        if scale > 1.0 {
            transform(withTranslation: pan.translation(in: self))
        }

        if pan.state != .ended { return }

        reset()
    }

    /// Set the image back to it's initial state.
    private func reset() {
        scale = 1.0
        UIView.animate(withDuration: 0.3) {
            self.transform = .identity
        }
    }
    
    /// Will transform the image with the appropriate
    /// scale or translation.
    ///
    /// Parameter translation: CGPoint
    private func transform(withTranslation translation: CGPoint) {
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, pinchCenter.x * (1-scale), pinchCenter.y * (1-scale), 0)
        transform = CATransform3DScale(transform, scale, scale, 1.01)
        transform = CATransform3DTranslate(transform, translation.x, translation.y, 0)
        
        layer.transform = transform
    }
}

extension UIImageView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
