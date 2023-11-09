//
//  Int+MWExtension.swift
//  MWBasicSDK
//
//  Created by mwk_pro on 2020/8/7.
//  Copyright © 2020 mwk. All rights reserved.
//

import Foundation

public extension Int {
    
    /// 根据宽度适配
    var mw_fw: CGFloat {
        return CGFloat(self) * MWProperty.screenMinLength / MWProperty.customeTemplateWidth
    }
    
    /// 根据高度适配
    var mw_fh: CGFloat {
        return CGFloat(self) * MWProperty.screenMaxLength / MWProperty.customeTemplateHeight
    }
    
    var mw_cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    var mw_float: Float {
        return Float(self)
    }
    
    var mw_double: Double {
        return Double(self)
    }
    
    var mw_decimal: NSDecimalNumber {
        return NSDecimalNumber(value: self)
    }
    
    /// 时间戳转string
    /// - Parameter format: 时间格式
    /// - Returns: 格式化后的时间
    func mw_toDateString(format: String) -> String {
        let dateStr = Date(timeIntervalSince1970: TimeInterval(self)).mw_toString(format: format)
        return dateStr
    }
    
    /// 时间戳转Date
    /// - Returns: Date
    func mw_toDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
