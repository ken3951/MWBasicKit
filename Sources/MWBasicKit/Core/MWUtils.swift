//
//  MWUtils.swift
//  MWBasicSDK
//
//  Created by 马文奎 on 2020/12/7.
//

import UIKit
import AVFoundation

let mwConcurrentQueueLabel = "com.mwbasicsdk.mw_concurrent"
let mwSerialQueueLabel = "com.mwbasicsdk.mw_serial"

@objc open class MWUtils: NSObject {

    ///当前主线程直接执行，否则回到主线程异步执行
    @objc public static func main(_ execute: @escaping MWVoidCallback) {
        if Thread.isMainThread {
            execute()
        }else{
            DispatchQueue.main.async {
                execute()
            }
        }
    }

    ///当前主线程直接执行，否则等待回到主线程异步执行结束
    @objc public static func mainSyn(_ execute: @escaping MWVoidCallback) {
        if Thread.isMainThread {
            execute()
        }else{
            let semaphore =  DispatchSemaphore(value: 0)
            DispatchQueue.main.async {
                execute()
                semaphore.signal()
            }
            semaphore.wait()
        }
    }

    /// 根据宽度获取适配值
    /// - Parameter value: 宽度365下的值
    /// - Returns: 适配后的值
    @discardableResult
    @objc public static func fitWidth(_ value: CGFloat) -> CGFloat {
        return value.mw_fw
    }

    /// 根据高度获取适配值
    /// - Parameter value: 高度667下的值
    /// - Returns: 适配后的值
    @discardableResult
    @objc public static func fitHeight(_ value: CGFloat) -> CGFloat {
        return value.mw_fh
    }

    //MARK:--获取应用信息
    ///获取app版本
    @discardableResult
    @objc public static func getAppVersion() -> String {
        let infoDictionary = Bundle.main.infoDictionary
        let appVersion = infoDictionary!["CFBundleShortVersionString"] as! String
        return appVersion
    }

    ///获取app版本
    @discardableResult
    @objc public static func getAppName() -> String {
        let infoDictionary = Bundle.main.infoDictionary
        let appName = infoDictionary!["CFBundleDisplayName"] as! String
        return appName
    }

    ///获取当前window截图
    @discardableResult
    @objc public static func getScreenShotFromWindow() -> UIImage? {
        let imageSize = CGSize(width: mw_screenWidth * UIScreen.main.scale, height: mw_screenHeight * UIScreen.main.scale)
        UIGraphicsBeginImageContextWithOptions(imageSize, true, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        UIApplication.shared.keyWindow?.layer.render(in: context)
        
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let imageCG = viewImage?.cgImage else {
            return nil
        }
        
        let cropSize = CGRect(x: 0, y: 0, width: mw_screenWidth * UIScreen.main.scale, height: mw_screenHeight * UIScreen.main.scale)
        guard let sendImageCG = imageCG.cropping(to: cropSize) else {
            return nil
        }
        
        let sendImage = UIImage(cgImage: sendImageCG)
        return sendImage
        
    }

    //MARK:--获取当前正在展示的mainView，UIAlertController除外
    ///获取当前正在展示的mainView，UIAlertController除外
    @discardableResult
    @objc public static func getCurrentMainView() -> UIView? {
        let currentVC = UIApplication.shared.windows.first?.rootViewController
        if let presentedVC = currentVC?.presentedViewController{
            if !presentedVC.isKind(of: UIAlertController.self) {
                return presentedVC.view
            }
        }
        return currentVC?.view
    }

    //MARK:--获取当前时间戳
    ///获取当前时间戳
    @discardableResult
    @objc public static func getCurrentTimestamp() -> Int {
        let date = NSDate()
        return Int(date.timeIntervalSince1970)
    }
    
    //MARK:--获取当前时间戳
    ///获取当前毫秒级时间戳
    @discardableResult
    @objc public static func getCurrentMillisecondTimestamp() -> Int {
        let date = NSDate()
        return Int(date.timeIntervalSince1970*1000.0)
    }

    //MARK:--获取根控制器
    ///获取根控制器
    @discardableResult
    @objc public static func getCurrentRootVC() -> UIViewController? {
        let currentVC = UIApplication.shared.windows.first?.rootViewController
        return currentVC
    }

    ///获取Navigation
    @discardableResult
    @objc public static func getCurrentNavigation() -> UINavigationController? {
        if let nav = getCurrentRootVC() as? UINavigationController {
            return nav
        }
        if let tabbar = getCurrentRootVC() as? UITabBarController {
            return getNavigation(in: tabbar)
        }
        return nil
    }

    @discardableResult
    @objc public static func getNavigation(in tabbarController: UITabBarController) -> UINavigationController? {
        if let selectVC = tabbarController.selectedViewController {
            if let nav = selectVC as? UINavigationController {
                return nav
            }
        }
        return nil
    }

    ///移动文件
    @discardableResult
    @objc public static func moveFile(_ originFile: String, toFile: String) -> Bool {
        do {
            
            let folderPath = (toFile as NSString).deletingLastPathComponent
            if !FileManager.default.fileExists(atPath: folderPath) {
                try? FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            }
            
            try FileManager.default.moveItem(atPath: originFile, toPath: toFile)
            return true
        } catch {
            mw_print_d(error)
            return false
        }
    }

    ///获取本地视频截图
    @objc public static func getScreenShotImageFromLocalVideo(url: URL, seconds: Double = 0.0, completion: MWInCallback<UIImage?>?) {
        var shotImage: UIImage?
        let asset = AVURLAsset(url: url, options: nil)
        let gen = AVAssetImageGenerator(asset: asset)
        gen.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(seconds, preferredTimescale: 60)
        var actualTime: CMTime = CMTime(value: 0, timescale: 0)
        if let image = try? gen.copyCGImage(at: time, actualTime: &actualTime) {
            shotImage = UIImage(cgImage: image)
        }
        completion?(shotImage)
    }
    
    @objc public static func getScreenShotImageFromLocalVideoAsyn(url: URL, seconds: Double = 0.0, completion: MWInCallback<UIImage?>?) {
        mw_concurrentQueue.async {
            getScreenShotImageFromLocalVideo(url: url, seconds: seconds, completion: completion)
        }
    }
    
    ///获取本地视频时长
    @discardableResult
    @objc public static func getLocalVideoSeconds(url: URL) -> CGFloat {
        let urlAsset = AVURLAsset(url: url)
        let time = urlAsset.duration
        let seconds = CGFloat(time.value)/CGFloat(time.timescale)
        return seconds
    }
    
    ///拨打电话
    @objc public static func callPhone(mobile: String?) {
        if mobile == nil {
            return
        }
        let urlString = "tel://\(mobile!)"
        if let url = URL(string: urlString) {
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    ///转换视频格式为mp4
    @objc static public func convertVideoFormatToMp4(sourceUrl: URL, targetURL: URL, completion: MWInCallback<Bool>?) {
        let avAsset = AVURLAsset(url: sourceUrl, options: nil)
        let compatiblePresets = AVAssetExportSession.exportPresets(compatibleWith: avAsset)
        if compatiblePresets.contains(AVAssetExportPresetHighestQuality) {
            let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetMediumQuality)
            try? FileManager.default.removeItem(at: targetURL)
            let mp4FilePath = (targetURL.path as NSString).deletingLastPathComponent
            if !FileManager.default.fileExists(atPath: mp4FilePath) {
                do {
                    try FileManager.default.createDirectory(atPath: mp4FilePath, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    mw_print_i("创建文件夹失败 error：\(error)")
                    completion?(false)
                    return
                }
            }
            
            exportSession?.outputURL = targetURL
            
            exportSession?.outputFileType = AVFileType.mp4
            
            exportSession?.shouldOptimizeForNetworkUse = true
            exportSession?.exportAsynchronously(completionHandler: {
                switch (exportSession!.status) {
                case AVAssetExportSession.Status.unknown:
                    completion?(false)
                    break
                case AVAssetExportSession.Status.waiting:
                    completion?(false)
                    break
                case AVAssetExportSession.Status.exporting:
                    completion?(false)
                    break
                case AVAssetExportSession.Status.completed:
                    completion?(true)
                    break
                case AVAssetExportSession.Status.failed:
                    completion?(false)
                    break
                default:
                    completion?(false)
                    break
                }
            })
        } else {
            completion?(false)
        }
    }
    
    ///获取设备型号
    @discardableResult
    @objc public static func getPhoneType() -> String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let platform = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
            return String(cString: ptr)
        }
        
        if platform == "iPhone1,1" { return "iPhone 2G"}
        if platform == "iPhone1,2" { return "iPhone 3G"}
        if platform == "iPhone2,1" { return "iPhone 3GS"}
        if platform == "iPhone3,1" { return "iPhone 4"}
        if platform == "iPhone3,2" { return "iPhone 4"}
        if platform == "iPhone3,3" { return "iPhone 4"}
        if platform == "iPhone4,1" { return "iPhone 4S"}
        if platform == "iPhone5,1" { return "iPhone 5"}
        if platform == "iPhone5,2" { return "iPhone 5"}
        if platform == "iPhone5,3" { return "iPhone 5C"}
        if platform == "iPhone5,4" { return "iPhone 5C"}
        if platform == "iPhone6,1" { return "iPhone 5S"}
        if platform == "iPhone6,2" { return "iPhone 5S"}
        if platform == "iPhone7,1" { return "iPhone 6 Plus"}
        if platform == "iPhone7,2" { return "iPhone 6"}
        if platform == "iPhone8,1" { return "iPhone 6S"}
        if platform == "iPhone8,2" { return "iPhone 6S Plus"}
        if platform == "iPhone8,4" { return "iPhone SE"}
        if platform == "iPhone9,1" { return "iPhone 7"}
        if platform == "iPhone9,2" { return "iPhone 7 Plus"}
        if platform == "iPhone10,1" { return "iPhone 8"}
        if platform == "iPhone10,2" { return "iPhone 8 Plus"}
        if platform == "iPhone10,3" { return "iPhone X"}
        if platform == "iPhone10,4" { return "iPhone 8"}
        if platform == "iPhone10,5" { return "iPhone 8 Plus"}
        if platform == "iPhone10,6" { return "iPhone X"}
        if platform == "iPhone11,2" { return "iPhone XS"}
        if platform == "iPhone11,4" { return "iPhone XS Max (China)"}
        if platform == "iPhone11,6" { return "iPhone XS Max (China)"}
        if platform == "iPhone11,8" { return "iPhone XR"}
        if platform == "iPhone12,1" { return "iPhone 11"}
        if platform == "iPhone12,3" { return "iPhone 11 Pro"}
        if platform == "iPhone12,5" { return "iPhone 11 Pro Max"}
        
        if platform == "iPod1,1" { return "iPod Touch 1G"}
        if platform == "iPod2,1" { return "iPod Touch 2G"}
        if platform == "iPod3,1" { return "iPod Touch 3G"}
        if platform == "iPod4,1" { return "iPod Touch 4G"}
        if platform == "iPod5,1" { return "iPod Touch 5G"}
        
        if platform == "iPad1,1" { return "iPad 1"}
        if platform == "iPad2,1" { return "iPad 2"}
        if platform == "iPad2,2" { return "iPad 2"}
        if platform == "iPad2,3" { return "iPad 2"}
        if platform == "iPad2,4" { return "iPad 2"}
        if platform == "iPad2,5" { return "iPad Mini 1"}
        if platform == "iPad2,6" { return "iPad Mini 1"}
        if platform == "iPad2,7" { return "iPad Mini 1"}
        if platform == "iPad3,1" { return "iPad 3"}
        if platform == "iPad3,2" { return "iPad 3"}
        if platform == "iPad3,3" { return "iPad 3"}
        if platform == "iPad3,4" { return "iPad 4"}
        if platform == "iPad3,5" { return "iPad 4"}
        if platform == "iPad3,6" { return "iPad 4"}
        if platform == "iPad4,1" { return "iPad Air"}
        if platform == "iPad4,2" { return "iPad Air"}
        if platform == "iPad4,3" { return "iPad Air"}
        if platform == "iPad4,4" { return "iPad Mini 2"}
        if platform == "iPad4,5" { return "iPad Mini 2"}
        if platform == "iPad4,6" { return "iPad Mini 2"}
        if platform == "iPad4,7" { return "iPad Mini 3"}
        if platform == "iPad4,8" { return "iPad Mini 3"}
        if platform == "iPad4,9" { return "iPad Mini 3"}
        if platform == "iPad5,1" { return "iPad Mini 4"}
        if platform == "iPad5,2" { return "iPad Mini 4"}
        if platform == "iPad5,3" { return "iPad Air 2"}
        if platform == "iPad5,4" { return "iPad Air 2"}
        if platform == "iPad6,3" { return "iPad Pro 9.7"}
        if platform == "iPad6,4" { return "iPad Pro 9.7"}
        if platform == "iPad6,7" { return "iPad Pro 12.9"}
        if platform == "iPad6,8" { return "iPad Pro 12.9"}
        
        if platform == "i386"   { return "iPhone Simulator"}
        if platform == "x86_64" { return "iPhone Simulator"}
        
        return platform
    }
}
