//
//  CGFloat+MWExtension.swift
//  MWBasicSDK
//
//  Created by 马文奎 on 2020/11/17.
//

import Foundation

public extension CGFloat {
    
    /// 根据宽度适配
    var mw_fw: CGFloat {
        return self * MWProperty.screenMinLength / MWProperty.customeTemplateWidth
    }
    
    /// 根据高度适配
    var mw_fh: CGFloat {
        return self * MWProperty.screenMaxLength / MWProperty.customeTemplateHeight
    }
    
    var mw_int: Int {
        return Int(self)
    }
    
    var mw_float: Float {
        return Float(self)
    }
    
    var mw_double: Double {
        return Double(self)
    }
    
    var mw_decimal: NSDecimalNumber {
        return NSDecimalNumber(value: self.mw_float)
    }
    
}
