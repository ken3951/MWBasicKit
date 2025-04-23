//
//  MWReuseable.swift
//  AIChat
//
//  Created by 马文奎 on 2025/4/23.
//

import Foundation
import UIKit

public protocol MWIdentifiable: NSObject {
    static var mw_identify: String { get }
}

public extension MWIdentifiable {
    static var mw_identify: String {
        return String(describing: Self.self)
    }
}

public protocol MWReusable {}

public extension MWReusable where Self: UITableView {
    func mw_register<T: UITableViewCell & MWIdentifiable>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.mw_identify)
    }
    
    func mw_registerHeaderFooter<T: UITableViewHeaderFooterView & MWIdentifiable>(_ cellClass: T.Type) {
        self.register(cellClass, forHeaderFooterViewReuseIdentifier: cellClass.mw_identify)
    }
    
    func mw_dequeueReusableCell<T: UITableViewCell & MWIdentifiable>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: cellClass.mw_identify, for: indexPath) as! T
    }
    
    func mw_dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView & MWIdentifiable>(_ cellClass: T.Type) -> T? {
        return self.dequeueReusableHeaderFooterView(withIdentifier: cellClass.mw_identify) as? T
    }
}

public extension MWReusable where Self: UICollectionView {
    func mw_register<T: UICollectionViewCell & MWIdentifiable>(_ cellClass: T.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.mw_identify)
    }
    
    func mw_registerSupplementaryView<T: UICollectionReusableView & MWIdentifiable>(_ cellClass: T.Type, kind: String) {
        self.register(cellClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: cellClass.mw_identify)
    }
    
    func mw_dequeueReusableCell<T: UICollectionViewCell & MWIdentifiable>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cellClass.mw_identify, for: indexPath) as! T
    }
    
    func mw_dequeueReusableSupplementaryView<T: UICollectionReusableView & MWIdentifiable>(_ cellClass: T.Type, kind: String, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellClass.mw_identify, for: indexPath) as? T
    }
}

extension UIView: MWReusable {}
extension UIView: MWIdentifiable {}
