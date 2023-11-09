//
//  Optional+MWExtension.swift
//  MWBasicSDK
//
//  Created by mwk_pro on 2020/9/14.
//  Copyright © 2020 mwk. All rights reserved.
//

import Foundation

public extension Optional {
    
    /// 过滤可选项为nil的情况
    ///
    /// - Parameter valueOnNil: 可选项为空时的默认值
    /// - Returns: 解包后的值
    @discardableResult
    func mw_filterNil(_ valueOnNil: Wrapped) -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            return valueOnNil
        }
    }
}
