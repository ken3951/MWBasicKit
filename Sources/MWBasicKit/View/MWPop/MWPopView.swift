//
//  MWPopView.swift
//  AIChat
//
//  Created by 马文奎 on 2025/4/24.
//

import Foundation
import UIKit
import SnapKit
import MWBasicKitCore

class MWPopView: UIView {
    
    var contentView: (UIView & MWPopEnable)? {
        didSet {
            guard let contentView = self.contentView else { return }
            self.addSubview(contentView)
        }
    }
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func dismissAnimation() {
        self.endEditing(true)
        if let contentView = self.contentView {
            contentView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(MWProperty.screenHeight*0.7)
            }
            
            UIView.animate(withDuration: TimeInterval(0.3), animations: {
                self.layoutIfNeeded()

            }, completion: {_ in 
                self.removeFromSuperview()
            })
        } else {
            self.removeFromSuperview()
        }
    }
    
    //MARK: -- Override
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let contentView = self.contentView else {
            self.dismissAnimation()
            return
        }

        let touch = ((touches as NSSet).anyObject() as AnyObject)
        let point = touch.location(in:self)

        if !contentView.frame.contains(point) {
            self.dismissAnimation()
            return
        }
    }
}


