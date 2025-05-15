//
//  UITextField+MWExtension.swift
//  MWCommonTool
//
//  Created by mwk_pro on 2019/3/28.
//  Copyright © 2019 mwk. All rights reserved.
//

import UIKit

@objc public extension UITableView {
    ///滑动到底部
    func mw_scrollToBottom(animated: Bool = true) {
        let section = numberOfSections
        if section < 1 {
            return
        }
        let row = numberOfRows(inSection: section - 1)
        if row < 1 {
            return
        }
        let indexPath = IndexPath(row: row - 1, section: section - 1)
        scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
    
}
