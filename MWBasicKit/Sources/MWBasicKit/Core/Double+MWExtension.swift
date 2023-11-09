//
//  Double+MWExtension.swift
//  MWBasicSDK
//
//  Created by 马文奎 on 2020/11/17.
//

import Foundation

public extension Double {
    
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
    
    var mw_int: Int {
        return Int(self)
    }
    
    var mw_decimal: NSDecimalNumber {
        return NSDecimalNumber(value: self)
    }
    
}
