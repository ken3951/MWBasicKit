//
//  UIEdgeInsets+MWExtension.swift
//  MWBasicSDK
//
//  Created by 马文奎 on 2020/12/16.
//

import Foundation

public extension UIEdgeInsets {
    
    /// 创建UIEdgeInsets
    /// - Parameters:
    ///   - left: 左间距
    ///   - right: 右间距
    /// - Returns: UIEdgeInsets
    @discardableResult
    static func mw_leftRight(_ left: CGFloat, _ right: CGFloat) -> UIEdgeInsets {
        let edge = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
        return edge
    }
    
}

