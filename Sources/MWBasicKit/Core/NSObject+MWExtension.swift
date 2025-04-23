//
//  NSObject+MWExtension.swift
//  MWBasicSDK
//
//  Created by 马文奎 on 2021/1/26.
//

import Foundation

extension NSObject {
    @objc static func mw_swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(forClass, originalSelector),
              let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) else {
            return
        }
        
        let isAddSuccess = class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        if isAddSuccess {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
