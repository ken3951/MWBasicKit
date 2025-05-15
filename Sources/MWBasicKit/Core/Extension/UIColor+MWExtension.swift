//
//  UIColor+Extension.swift
//  FunCityMerchant_Swift
//
//  Created by mwk_pro on 2017/11/8.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import Foundation
import UIKit

@objc public extension UIColor {
    
    /// 创建rgb色值相同的颜色
    /// - Parameters:
    ///   - value: rgb值
    ///   - alpha: 透明度
    /// - Returns: UIColor
    @discardableResult
    @objc static func mw_rgbSame(_ value: NSInteger, _ alpha: CGFloat = 1.0) -> UIColor {
        return mw_rgba(value, value, value, alpha)
    }
    
    /// rgba创建颜色
    /// - Parameters:
    ///   - r: r值
    ///   - g: g值
    ///   - b: b值
    ///   - alpha: 透明度
    /// - Returns: UIColor
    @discardableResult
    @objc static func mw_rgba(_ r: NSInteger, _ g: NSInteger, _ b: NSInteger, _ alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
    
    /// 创建十六进制颜色
    /// - Parameters:
    ///   - hexString: 十六进制颜色值，如"333333"
    ///   - alpha: 透明度
    /// - Returns: UIColor
    @discardableResult
    @objc static func mw_hex(_ hexString: String, _ alpha: CGFloat = 1.0) -> UIColor {
        if hexString.count != 6 {
            return .clear
        }
        // 存储转换后的数值
        var red:UInt32 = 0,green:UInt32 = 0,blue:UInt32 = 0
        // 分别转换进行转换
        Scanner(string: hexString[0..<2]).scanHexInt32(&red)
        
        Scanner(string: hexString[2..<4]).scanHexInt32(&green)
        
        Scanner(string: hexString[4..<6]).scanHexInt32(&blue)
        
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    /// 创建十六进制颜色
    /// - Parameters:
    ///   - hexColor: 十六进制颜色值，如"f2"
    ///   - alpha: 透明度
    /// - Returns: UIColor
    @discardableResult
    @objc static func mw_hexRGBSame(_ hexString: String, _ alpha: CGFloat = 1.0) -> UIColor {
        return mw_hex(hexString + hexString + hexString, alpha)
    }
}
