//
//  MWFunction.swift
//  MWBasic
//
//  Created by mwk_pro on 2019/4/4.
//  Copyright © 2019 mwk. All rights reserved.
//
import UIKit
import Foundation

//MARK:--自定义print
public func mw_print_d<T>(_ message: T,
                file: String = #file,
                line: Int = #line,
                function:String = #function) {
    
    #if DEBUG // 在debug,test,uat环境下打印报错信息
    //stderr
    print("ψ(｀∇´)ψ", String(format:
        """
        
        dddddddddd
        time:\(Date().mw_toString(format: "yyyy-MM-dd,HH:mm:ss"))
        file:\((file as NSString).lastPathComponent)
        line:\(line)
        function:\(function)
        message:\(message)
        """))
    #endif
}

public func mw_print_i<T>(_ message: T) {
    
    #if DEBUG  // 在debug,test,uat环境下打印报错信息
    //stderr
    print("ψ(｀∇´)ψ", String(format:
        """
        
        iiiiiiiiii
        message:\(message)
        """))
    #endif
}

///当前主线程直接执行，否则回到主线程异步执行
public func mw_main(_ execute: @escaping MWVoidCallback) {
    MWUtils.main(execute)
}

///当前主线程直接执行，否则等待回到主线程异步执行结束
public func mw_mainSyn(_ execute: @escaping MWVoidCallback) {
    MWUtils.mainSyn(execute)
}

/// 根据宽度获取适配值
/// - Parameter value: 宽度365下的值
/// - Returns: 适配后的值
@discardableResult
public func mw_fitWidth(_ value: CGFloat) -> CGFloat {
    return MWUtils.fitWidth(value)
}

/// 根据高度获取适配值
/// - Parameter value: 高度667下的值
/// - Returns: 适配后的值
@discardableResult
public func mw_fitHeight(_ value: CGFloat) -> CGFloat {
    return MWUtils.fitHeight(value)
}

///获取当前正在展示的mainView，UIAlertController除外
@discardableResult
public func mw_getCurrentMainView() -> UIView? {
    return MWUtils.getCurrentMainView()
}

public func mw_getScreenShotFromWindow() -> UIImage? {
    return MWUtils.getScreenShotFromWindow()
}

///获取当前时间戳
public func mw_getCurrentTimestamp() -> Int {
    return MWUtils.getCurrentTimestamp()
}

///获取当前毫秒级时间戳
public func mw_getCurrentMillisecondTimestamp() -> Int {
    return MWUtils.getCurrentMillisecondTimestamp()
}

///获取根控制器
public func mw_getCurrentRootVC() -> UIViewController? {
    return MWUtils.getCurrentRootVC()
}

///获取Navigation
public func mw_getCurrentNavigation() -> UINavigationController? {
    return MWUtils.getCurrentNavigation()
}

///获取Navigation
public func mw_getNavigation(in tabbarController: UITabBarController) -> UINavigationController? {
    return MWUtils.getNavigation(in: tabbarController)
}

///移动文件
public func moveFile(_ originFile: String, toFile: String) -> Bool {
    return MWUtils.moveFile(originFile, toFile: toFile)
}

///获取本地视频截图
public func mw_getScreenShotImageFromLocalVideo(url: URL, seconds: Double = 0.0, completion: MWInCallback<UIImage?>?) {
    return MWUtils.getScreenShotImageFromLocalVideo(url: url, seconds: seconds, completion: completion)
}

public func mw_getScreenShotImageFromLocalVideoAsyn(url: URL, seconds: Double = 0.0, completion: MWInCallback<UIImage?>?) {
    return MWUtils.getScreenShotImageFromLocalVideoAsyn(url: url, seconds: seconds, completion: completion)
}

///获取本地视频时长
public func mw_getLocalVideoSeconds(url: URL) -> CGFloat {
    return MWUtils.getLocalVideoSeconds(url: url)
}

///拨打电话
public func mw_callPhone(mobile: String?) {
    return MWUtils.callPhone(mobile: mobile)
}

///转换视频格式为mp4
public func mw_convertVideoFormatToMp4(sourceUrl: URL, targetURL: URL, completion: MWInCallback<Bool>?) {
    return MWUtils.convertVideoFormatToMp4(sourceUrl: sourceUrl, targetURL: targetURL, completion: completion)
}
