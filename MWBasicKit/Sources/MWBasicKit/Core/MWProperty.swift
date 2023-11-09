//
//  File.swift
//  MWBasicSDK
//
//  Created by 马文奎 on 2020/12/17.
//

import Foundation
import UIKit

///手机型号
public let mw_phoneType = MWProperty.phoneType

///app版本
public let mw_appVersion = MWProperty.appVersion

///屏幕宽度
public let mw_screenWidth = MWProperty.screenWidth
///屏幕高度
public let mw_screenHeight = MWProperty.screenHeight
///状态栏高度
public let mw_statusHeight = MWProperty.statusHeight
///宽度相对375的比例系数
public let mw_fitWidth375Value = MWProperty.fitWidth375Value
///高度相对667的比例系数
public let mw_fitHeight667Value = MWProperty.fitHeight667Value

//并行队列
public let mw_concurrentQueue = MWProperty.concurrentQueue

//串行队列
public let mw_serialQueue = MWProperty.serialQueue

@objc public class MWProperty: NSObject {
    @objc public static var customeTemplateWidth: CGFloat = 375.0
    @objc public static var customeTemplateHeight: CGFloat = 667.0
    
    ///手机型号
    @objc public static let phoneType = MWUtils.getPhoneType()
    
    ///app版本
    @objc public static let appVersion = MWUtils.getAppVersion()
        
    ///屏幕短一边
    @objc public static let screenMinLength = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)

    ///屏幕长的一边
    @objc public static let screenMaxLength = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
    ///屏幕宽度
    @objc public static let screenWidth = UIScreen.main.bounds.size.width
    ///屏幕高度
    @objc public static let screenHeight = UIScreen.main.bounds.size.height
    ///状态栏高度
    @objc public static let statusHeight = UIApplication.shared.statusBarFrame.size.height
    ///宽度相对375的比例系数
    @objc public static let fitWidth375Value = screenMinLength / customeTemplateWidth
    ///高度相对667的比例系数
    @objc public static let fitHeight667Value = screenMaxLength / customeTemplateHeight
    
    //并行队列
    @objc public static let concurrentQueue = DispatchQueue(label: mwConcurrentQueueLabel, qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
    
    //串行队列
    @objc public static let serialQueue = DispatchQueue(label: mwSerialQueueLabel, qos: .default, autoreleaseFrequency: .inherit, target: nil)
}
