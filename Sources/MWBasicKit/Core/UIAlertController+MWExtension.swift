//
//  UIAlertController+Extension.swift
//  FunCityMerchant_Swift
//
//  Created by mwk_pro on 2017/11/20.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import Foundation

//MARK:--显示dialog弹窗
public func mw_showAlert(message: String ,title: String = "提示",  buttonItems: Array<String> = ["确定"] , indexBlock: MWInCallback<Int>? = nil) {
    DispatchQueue.main.async {
        let alertController = UIAlertController.mw_create(title: title, message: message, buttonItems: buttonItems, alertStyle: .alert, indexBlock: indexBlock)
        MWUtils.getCurrentRootVC()?.present(alertController, animated: true, completion: nil)
    }
}

public func mw_showActionSheet(title: String?, message: String?, buttonItems: Array<String> = ["确定"] , indexBlock: MWInCallback<Int>? = nil) {
    DispatchQueue.main.async {
        MWUtils.getCurrentRootVC()?.present(UIAlertController.mw_create(title: title, message: message, buttonItems: buttonItems, alertStyle: .actionSheet, indexBlock: indexBlock), animated: true, completion: nil)
    }
}

@objc public extension UIAlertController {
    @discardableResult
    static func mw_create(title: String?, message: String?, buttonItems: Array<String>, alertStyle: UIAlertController.Style, indexBlock: MWInCallback<Int>?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for i in 0 ..< buttonItems.count {
            let alertAction = UIAlertAction(title: buttonItems[i], style: .default, handler: {[weak alertController] (alertAction) in
                guard let alertController = alertController else {
                    return
                }
                for j in 0 ..< alertController.actions.count {
                    if alertAction == alertController.actions[j] {
                        indexBlock?(j)
                    }
                }
            })
            alertController.addAction(alertAction)
        }
        return alertController
    }
}
