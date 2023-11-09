//
//  CABasicAnimation+MWExtension.swift
//  MWBasicSDK
//
//  Created by 马文奎 on 2020/11/13.
//

import Foundation
import QuartzCore

@objc public protocol CABasicAnimationLoadable {
    
}

public extension CABasicAnimationLoadable where Self: CABasicAnimation {
    ///缩放动画
    static func mw_scale(fromValue: Float, toValue: Float, duration: Float) -> CABasicAnimation {
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = (fromValue)
        scale.toValue = (toValue)
        scale.beginTime = CACurrentMediaTime()
        scale.duration = CFTimeInterval(duration)
        scale.isRemovedOnCompletion = false
        scale.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        scale.fillMode = CAMediaTimingFillMode.forwards
        return scale
    }
    
    ///旋转动画
    static func mw_transform(rotation: MWTransformRotation, duration: CGFloat = 2.0, repeatCount: Float = MAXFLOAT) -> CABasicAnimation {
        let transform = CABasicAnimation(keyPath: rotation.rawValue)
        transform.fromValue = (0)
        transform.toValue = (Double.pi*2)
        transform.duration = CFTimeInterval(duration)
        transform.repeatCount = repeatCount
        return transform
    }
}

extension CABasicAnimation: CABasicAnimationLoadable {
    
}
