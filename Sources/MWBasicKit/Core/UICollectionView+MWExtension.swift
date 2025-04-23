//
//  UICollectionView+MWExtension.swift
//  MWBasicSDK
//
//  Created by mwk_pro on 2020/1/8.
//  Copyright © 2020 mwk. All rights reserved.
//

import Foundation

var MWContentSizeChangedCallbackKey = "MWContentSizeChangedCallbackKey"

@objc public extension UICollectionView {
    
    ///contentSize改变回调
    var contentSizeChangedCallback: MWInCallback<CGSize>? {
        set {
            objc_setAssociatedObject(self, &MWContentSizeChangedCallbackKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            if let rs = objc_getAssociatedObject(self, &MWContentSizeChangedCallbackKey) as? MWInCallback<CGSize> {
                return rs
            }
            return nil
        }
    }
    
    override var contentSize: CGSize {
        set {
            if newValue == self.contentSize {
                return
            }
            super.contentSize = newValue
            self.contentSizeChangedCallback?(newValue)
        }
        
        get {
            return super.contentSize
        }
    }
}
