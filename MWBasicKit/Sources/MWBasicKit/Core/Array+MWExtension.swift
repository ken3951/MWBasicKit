//
//  Array+MWExtension.swift
//  WorkPlatformIOS
//
//  Created by mwk_pro on 2019/2/27.
//  Copyright © 2019 mwk_pro. All rights reserved.
//

import Foundation

public extension Optional where Wrapped: RandomAccessCollection {
    var mw_length: Int {
        switch self {
        case .some(let value):
            return value.count
        case .none:
            return 0
        }
    }
}

public extension Array {
    
    ///Array转string
    func mw_JSONString() -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    ///Array转Data
    func mw_JSONData() -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let data = try? JSONSerialization.data(withJSONObject: self)
        return data
    }
    
    ///去重
    func mw_filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}
