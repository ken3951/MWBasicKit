//
//  MWPickerMatrixView.swift
//  AIChat
//
//  Created by 马文奎 on 2025/5/12.
//

import Foundation
import MWBasicKitCore

public protocol MWPickMatixable {
    var mw_pickerTitle: String {get}
}

public class MWPickerMatrixView: MWPickerView {
    var items: [[MWPickMatixable]]
    
    //多选picker
    public init(items: [[MWPickMatixable]], selectIndexs: [Int], callback: @escaping MWInCallback<[Int]>) {
        self.items = items
        super.init(maxDepth: items.count, selectIndexs: selectIndexs, callback: callback)
    }
    
    ///单选picker
    public init(items: [MWPickMatixable], selectIndex: Int, callback: @escaping MWInCallback<Int>) {
        self.items = [items]
        super.init(maxDepth: 1, selectIndexs: [selectIndex], callback: { arr in
            guard let firstIndex = arr.first else { return }
            callback(firstIndex)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func getItemTitle(inComponent component: Int, row: Int) -> String {
        return items.mw_get(component)?.mw_get(row)?.mw_pickerTitle ?? ""
    }
    
    override func numberOfRowsInComponent(_ component: Int) -> Int {
        return items.mw_get(component)?.count ?? 0
    }
}
