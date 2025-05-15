//
//  MWPopEnable.swift
//  AIChat
//
//  Created by 马文奎 on 2025/4/24.
//

import Foundation
import MWBasicKitCore
import UIKit

public protocol MWPopEnable {
    
    var mw_popDismissHandler: MWVoidCallback? {set get}
    
    func mw_present()
}

public extension MWPopEnable where Self: UIView {
    func mw_present() {
        guard let rootView = MWUtils.getFirstWindow()?.rootViewController?.view else { return }
        
        let isExist = rootView.subviews.contains(where: { s in
            if let v = s as? MWPopView {
                return v.contentView?.isKind(of: type(of: self)) ?? false
            }
            return false
        })
        
        guard !isExist else { return }
        
        let view = MWPopView()
        view.contentView = self
        view.contentView?.mw_popDismissHandler = {[weak view] in
            view?.dismissAnimation()
        }
        rootView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(MWProperty.screenHeight*0.7)
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.7)
            make.leading.trailing.equalToSuperview()
        }
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        self.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(0)
        }
        
        UIView.animate(withDuration: TimeInterval(0.3)) {
            view.layoutIfNeeded()
        }
    }
}
