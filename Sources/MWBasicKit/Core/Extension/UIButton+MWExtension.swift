//
//  UIButton+Extension.swift
//  EOPPad
//
//  Created by mwk_pro on 2018/8/6.
//  Copyright © 2018年 mwk_pro. All rights reserved.
//

import Foundation
import UIKit

///button文字和图片同时显示时的排列方向
@objc public enum MWButtonDisplayOrientation: Int {
    case horizontalImageTitle = 1
    case horizontalTitleImage
    case verticalImageTitle
    case verticalTitleImage
}

public extension UIButton {
    
    ///根据方向和间距同时展示文字，图片
    @discardableResult
    func mw_display(orientation: MWButtonDisplayOrientation, space: CGFloat) {
        var titleEdge : UIEdgeInsets!
        var imageEdge : UIEdgeInsets!
        switch orientation {
        case .horizontalImageTitle:
            titleEdge = UIEdgeInsets(
                top: 0,
                left: CGFloat(space/2.0),
                bottom: 0,
                right: -CGFloat(space/2.0))
            imageEdge = UIEdgeInsets(
                top: 0,
                left: CGFloat(space/2.0),
                bottom: 0,
                right:  CGFloat(space/2.0))
            break
        case .horizontalTitleImage:
            titleEdge = UIEdgeInsets(
                top: 0,
                left: -self.imageView!.frame.size.width - CGFloat(space/2.0),
                bottom: 0,
                right: self.imageView!.frame.size.width + CGFloat(space/2.0))
            imageEdge = UIEdgeInsets(
                top: 0,
                left: min(self.titleLabel!.intrinsicContentSize.width + CGFloat(space/2.0),self.mw_width-self.imageView!.frame.size.width-CGFloat(space)),
                bottom: 0,
                right: max(-self.titleLabel!.intrinsicContentSize.width - CGFloat(space/2.0),-(self.mw_width-self.imageView!.frame.size.width-CGFloat(space))))
            break
        case .verticalImageTitle:
            titleEdge = UIEdgeInsets(
                top: 0,
                left: -self.imageView!.frame.size.width,
                bottom: -self.imageView!.frame.size.height - CGFloat(space/2.0),
                right: 0)
            imageEdge = UIEdgeInsets(
                top: -self.titleLabel!.intrinsicContentSize.height - CGFloat(space/2.0),
                left: 0,
                bottom: 0,
                right:  -self.titleLabel!.intrinsicContentSize.width)
            break
        case .verticalTitleImage:
            titleEdge = UIEdgeInsets(
                top: 0,
                left: -self.imageView!.frame.size.width,
                bottom: -self.imageView!.frame.size.height - CGFloat(space/2.0),
                right: 0)
            imageEdge = UIEdgeInsets(
                top: -self.titleLabel!.intrinsicContentSize.height - CGFloat(space/2.0),
                left: 0,
                bottom: 0,
                right:  -self.titleLabel!.intrinsicContentSize.width)
            break
        }

        
        self.titleEdgeInsets = titleEdge
        self.imageEdgeInsets = imageEdge
        
    }
}
