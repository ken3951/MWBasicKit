//
//  UIView+Extension.swift
//  Swift_UIView
//
//  Created by mwk_pro on 2017/2/21.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import Foundation

@objc public extension UIView {
    
    @objc var mw_x : CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    @objc var mw_y : CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    @objc var mw_width : CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    @objc var mw_height : CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    
    @objc var mw_bottom : CGFloat {
        get {
            return self.mw_height + self.mw_y
        }
        set {
            self.mw_y = newValue - self.mw_height
        }
    }
    
    @objc var mw_right : CGFloat {
        get {
            return self.mw_width + self.mw_x
        }
        set {
            self.mw_x = newValue - self.mw_width
        }
    }
    
    @objc var mw_centerX : CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
    }
    
    @objc var mw_centerY : CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }
    
    @objc func mw_screenShot() -> UIImage? {
        
        guard frame.size.height > 0 && frame.size.width > 0 else {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.mw_width * UIScreen.main.scale, height: self.mw_height * UIScreen.main.scale), true, UIScreen.main.scale)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

public enum MWTransformRotation : String {
    case x = "transform.rotation.x"
    case y = "transform.rotation.y"
    case z = "transform.rotation.z"
}

///view动画协议
public protocol MWViewAnimatable {

}

extension UIView: MWViewAnimatable {
    
}

public extension MWViewAnimatable where Self : UIView {

    ///旋转动画
    func mw_animateTransform(rotation: MWTransformRotation, duration: CGFloat = 2.0, repeatCount: Float = MAXFLOAT, forKey key: String? = nil) {
        let transform = CABasicAnimation.mw_transform(rotation: rotation, duration: duration, repeatCount: repeatCount)
        self.layer.add(transform, forKey: key)
    }

    ///位移+透明度动画，设置时间,设置动画完成是否移除
    func mw_animation(toRect: CGRect? = nil, toAlpha: CGFloat? = nil, duration: TimeInterval, completion: ((Bool) -> Void)?) {

        UIView.animate(withDuration: duration, animations: {

            if toRect != nil {
                self.frame = toRect!
            }
            if toAlpha != nil {
                self.alpha = toAlpha!
            }

        }, completion: completion)
    }
    
    ///缩放动画
    func mw_animationScale(fromValue: Float, toValue: Float, duration: Float, forKey key: String? = nil) {
        let scale = CABasicAnimation.mw_scale(fromValue: fromValue, toValue: toValue, duration: duration)
        self.layer.add(scale, forKey: key)
    }

}
