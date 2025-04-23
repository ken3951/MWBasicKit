//
//  Dictionary+Extension.swift
//  EOPPad
//
//  Created by mwk_pro on 2018/7/2.
//  Copyright © 2018年 mwk_pro. All rights reserved.
//

import Foundation

public extension Dictionary {
    ///Dictionary转string
    func mw_JSONString() -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    ///Dictionary转Data
    func mw_JSONData() -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let data = try? JSONSerialization.data(withJSONObject: self)
        return data
    }
}
