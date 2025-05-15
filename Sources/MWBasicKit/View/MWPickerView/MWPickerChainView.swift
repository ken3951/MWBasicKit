//
//  MWPickerChainView.swift
//  AIChat
//
//  Created by 马文奎 on 2025/5/12.
//

import Foundation
import MWBasicKitCore

public protocol MWPickChainable {
    var mw_pickerTitle: String {get}
    var mw_pickerSubItems: [MWPickChainable] {get}
}

extension Array where Element == MWPickChainable {
    var maxDepth: Int {
        if self.isEmpty {
            return 0
        }
        return self.map({$0.mw_pickerSubItems.maxDepth+1}).max() ?? 1
    }
}

public class MWPickerChainView: MWPickerView {
    
    var items: [MWPickChainable]
    
    public init(items: [MWPickChainable], selectIndexs: [Int], callback: @escaping MWInCallback<[Int]>) {
        self.items = items
        super.init(maxDepth: items.maxDepth, selectIndexs: selectIndexs, callback: callback)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func getItemTitle(inComponent component: Int, row: Int) -> String {
        getItem(component: component, row: row)?.mw_pickerTitle ?? ""
    }
    
    override func numberOfRowsInComponent(_ component: Int) -> Int {
        if component == 0 {
            return items.count
        }
        return getItem(component: component-1, row: pickerView.selectedRow(inComponent:  component-1))?.mw_pickerSubItems.count ?? 0
    }
    
    private func getItem(component: Int, row: Int) -> MWPickChainable? {
        if component == 0 {
            return items.mw_get(row)
        }
        
        let lastItem = getItem(component: component-1, row: pickerView.selectedRow(inComponent:  component-1))
        
        return lastItem?.mw_pickerSubItems.mw_get(row)
    }
    
}
