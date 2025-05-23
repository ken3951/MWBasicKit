//
//  MWToastView.swift
//  MWBasic
//
//  Created by mwk_pro on 2017/11/29.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import Foundation
import UIKit
import MWBasicKitCore

//MARK: - enum
///toast几种显示的位置
public enum MWToastPosition: Int {
    case   bottom = 1001
    case   center = 1002
    case   top = 1003
}

//MARK: - public func
///当前window的根视图快捷显示toast
public func mw_showToast(message: String, position: MWToastPosition = .bottom) {
    MWToast.show(message: message, position: position)
}

///MWToast弹窗
public struct MWToast {
    ///MWToast配置类
    public struct Config {
        
        public static var backgroundColor = UIColor.black

        ///文字容器最小左间距
        public static var leftMargin: CGFloat = 20
        
        ///文字容器的左内间距
        public static var paddingLeft: CGFloat = 10
        
        ///文字容器的上内间距
        public static var paddingTop: CGFloat = 4
        
        public static var font = UIFont.systemFont(ofSize: 13.0)

        public static var textColor = UIColor.white
        
        public static var cornerRadius: CGFloat = 5.0

    }
    
    ///MWToast显示message，position选填
    public static func show(message: String?, position: MWToastPosition = .bottom) {
        guard let rootView = mw_getCurrentRootVC()?.view else {
            mw_print_d("未获取到根视图")
            return
        }
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textAlignment = .left
        messageLabel.textColor = MWToast.Config.textColor
        messageLabel.numberOfLines = 0
        messageLabel.font = MWToast.Config.font
        messageLabel.backgroundColor = UIColor.clear
        
        let size = messageLabel.sizeThatFits(CGSize(width: MWProperty.screenWidth - CGFloat(MWToast.Config.leftMargin * 2 + MWToast.Config.paddingLeft * 2), height: 0))
        
        let labelWidth = (size.width + 1)
        let labelHeight = (size.height + 1)
        let contentView_width = labelWidth + CGFloat(MWToast.Config.paddingLeft * 2)
        let contentView_height = labelHeight + CGFloat(MWToast.Config.paddingTop * 2)
        let contentView_x = (MWProperty.screenWidth - contentView_width)/2.0
        var contentView_start_y: CGFloat!
        var contentView_end_y: CGFloat!
        var contentView_end_alpha: CGFloat!
        switch position {
        case .top:
            contentView_start_y = MWProperty.statusHeight
            contentView_end_y = contentView_start_y
            contentView_end_alpha = 0.9
        case .bottom:
            contentView_start_y = CGFloat(MWProperty.screenHeight) - CGFloat(contentView_height) - CGFloat(34) - CGFloat(60.0)
            contentView_end_y = contentView_start_y - 30
            contentView_end_alpha = 0.0
        case .center:
            contentView_start_y = MWProperty.screenHeight/2.0 - contentView_height/2.0
            contentView_end_y = contentView_start_y
            contentView_end_alpha = 0.0
        }

        messageLabel.frame = CGRect(x: MWToast.Config.paddingLeft, y: MWToast.Config.paddingTop, width: labelWidth, height: labelHeight)
        
        let contentView = UIView()
        contentView.backgroundColor = MWToast.Config.backgroundColor
        contentView.frame = CGRect(x: contentView_x, y: contentView_start_y, width: contentView_width, height: contentView_height)
        contentView.layer.cornerRadius = MWToast.Config.cornerRadius
        contentView.layer.masksToBounds = true
        contentView.addSubview(messageLabel)
        rootView.addSubview(contentView)
                
        
        UIView.animate(withDuration: 2.0, animations: {
            contentView.mw_y = contentView_end_y
            contentView.alpha = contentView_end_alpha
        }) { (result) in
            contentView.removeFromSuperview()
        }

    }
    
}
