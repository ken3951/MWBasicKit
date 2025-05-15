//
//  UIViewController+MWExtension.swift
//  AIChat
//
//  Created by 马文奎 on 2025/5/14.
//

import Foundation
import UIKit

public extension UIViewController {
    func mw_createBarButtonItem(image: UIImage?,
                                target: AnyObject,
                                action: Selector) -> UIBarButtonItem {
            
        let width: CGFloat = image?.size.width ?? 44

        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.frame.size = CGSize(width: width, height: 44)
        let buttonItem = UIBarButtonItem(customView: button)
        return buttonItem
    }
    
    func mw_createBarButtonItem(title: String?,
                                color: UIColor?,
                                size: CGFloat = 16,
                                target: AnyObject,
                                action: Selector) -> UIBarButtonItem {
            
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: size)
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
        let buttonItem = UIBarButtonItem(customView: button)
        return buttonItem
    }
}
