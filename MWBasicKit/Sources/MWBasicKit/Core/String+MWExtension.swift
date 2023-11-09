//
//  String+Extension.swift
//  Swift_UIView
//
//  Created by mwk_pro on 2017/2/21.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import Foundation
@_exported import UIKit

infix operator +/ : AdditionPrecedence
public func +/ (left: String, right: String) -> String {
    return left.mw_appendPath(right)
}

public extension String {
    
    var mw_isNoContent: Bool {
        return self.mw_trimmed.count == 0
    }
    
    var mw_trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    
    func mw_filterEmpty(_ valueOnEmpty: String = "") -> String {
        return self.count == 0 ? valueOnEmpty : self
    }
}

public extension Optional where Wrapped == String {
    
    /// Optional Property
    var mw_isNoContent: Bool {
        switch self {
        case .some(let value):
            return value.mw_isNoContent
        case .none:
            return true
        }
    }
    
    /// Optional Func
    
    func mw_filterNil(_ valueOnNil: String = "") -> String {
        switch self {
        case .some(let value):
            return value
        case .none:
            return valueOnNil
        }
    }
    
    /// Optional Func
    
    func mw_filterEmpty(_ valueOnEmpty: String = "") -> String {
        switch self {
        case .some(let value):
            return value.count == 0 ? valueOnEmpty : value
        case .none:
            return valueOnEmpty
        }
    }
}

public extension String {
    var mw_sequences: Array<String> {
        var arr: Array<String> = []
        enumerateSubstrings(in: startIndex..<endIndex, options: String.EnumerationOptions.byComposedCharacterSequences) { (str, range1, range2, _) in
            if let subStr = str {
                arr.append(subStr)
            }
        }
        return arr
    }
    
    subscript(index: Int) -> Character {
        let position = self.index(self.startIndex, offsetBy: index)
        return self[position]
    }
    
    subscript(index: Int) -> String {
        return String(self[index] as Character)
    }
    
    subscript(range: Range<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start..<end])
    }
    
    ///根据左右字符串获取中间的string，并不包含左右字符串
    func mw_getCenterStringNotContain(leftStr:String, rightStr:String) -> String? {
        let totalStr = self as NSString
        var startIndex = 0
        var endIndex = 0
        let startRange = totalStr.range(of: leftStr)
        let endRange = totalStr.range(of: rightStr)
        if startRange.length > 0 && endRange.length > 0 {
            startIndex = startRange.location + startRange.length
            endIndex = endRange.location
            let subStr = totalStr.substring(with: NSRange.init(location: startIndex, length: endIndex-startIndex))
            return subStr
        }
        return nil
    }
    
    ///根据左右字符串获取中间的string，并包含左右字符串
    func mw_getCenterStringContain(leftStr:String, rightStr:String) -> String? {
        let totalStr = self as NSString
        var startIndex = 0
        var endIndex = 0
        let startRange = totalStr.range(of: leftStr)
        let endRange = totalStr.range(of: rightStr)
        if startRange.length > 0 && endRange.length > 0 {
            startIndex = startRange.location
            endIndex = endRange.location  + endRange.length
            let subStr = totalStr.substring(with: NSRange.init(location: startIndex, length: endIndex-startIndex))
            return subStr
        }
        return nil
    }
    
    /// 拼接路径
    /// - Parameter path: 路径，可以/开头
    /// - Returns: 返回拼接完成后的路径
    func mw_appendPath(_ path: String) -> String {
        var str1 = self
        if str1.hasSuffix("/") {
            str1 = (str1 as NSString).substring(to: str1.count-1)
        }
        
        var str2 = path
        if path.hasPrefix("/") {
            str2 = (str2 as NSString).substring(from: 1)
        }
        return "\(str1)/\(str2)"
    }
    
    ///x/y
    func mw_stringPath(_ x:String) -> String {
        return self.appending("/\(x)")
    }
    
    ///判断是否是手机号
    func mw_isMobile() -> Bool {
        //检测是否是手机号
        let predicateStr = "^1\\d{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@",predicateStr)
        let result = predicate.evaluate(with: self)
        return result
    }
    
    ///判断是否是email
    func mw_isEmail() -> Bool {
        //检测是否是email
        let predicateStr = "^([a-zA-Z0-9]+([._\\-])*[a-zA-Z0-9]*)+@([a-zA-Z0-9])+(.([a-zA-Z])+)+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@",predicateStr)
        let result = predicate.evaluate(with: self)
        return result
    }
    
    ///判断两位小数
    func mw_isFloat2() -> Bool {
        //是两位小数
        let predicateStr = "^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@",predicateStr)
        let result = predicate.evaluate(with: self)
        return result
    }
        
    /// 正则匹配
    /// - Parameter pattern: 正则表达式
    /// - Returns: 是否匹配
    
    func mw_evaluate(pattern: String) -> Bool {
        guard let reg = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else { return false }
        let result = reg.matches(in: self, options: .reportProgress, range: NSMakeRange(0, self.count))
//        let predicate = NSPredicate(format: "SELF MATCHES %@",pattern)
//        let result = predicate.evaluate(with: self)
        return result.count == self.count
    }
        
    /// 正则匹配筛选合法内容
    /// - Parameter pattern: 正则表达式
    /// - Returns: 筛选后的合法内容
    
    func mw_filterLegal(pattern: String) -> String {
        guard let reg = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else { return "" }
        var legalString = ""
        let result = reg.matches(in: self, options: .reportProgress, range: NSMakeRange(0, self.utf16.count))
        print("\(NSMakeRange(0, self.utf16.count))")
        result.forEach { (check) in
            legalString = legalString + (self as NSString).substring(with: check.range)
        }
        return legalString
    }
    
    /// 正则匹配筛选合法内容
    /// - Parameter pattern: 正则表达式
    /// - Parameter selectedRange: 光标位置
    /// - Returns: 筛选后的合法内容和新的光标位置
    
    func mw_filterLegal(pattern: String, selectedRange: NSRange) -> (String, NSRange) {
        guard let reg = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else { return ("",NSRange(location: 0, length: 0)) }
        var legalString = ""
        let result = reg.matches(in: self, options: .reportProgress, range: NSMakeRange(0, self.utf16.count))
        print("\(NSMakeRange(0, self.utf16.count))")
        var newSelectedRange: NSRange = NSRange(location: 0, length: 0);
        result.forEach { (check) in
            legalString = legalString + (self as NSString).substring(with: check.range)
            if check.range.location < selectedRange.location {
                newSelectedRange.location += check.range.length
            }
        }
        newSelectedRange.location = min(newSelectedRange.location, selectedRange.location)
        return (legalString,newSelectedRange)
    }
    
    /// 正则匹配筛选合非法内容
    /// - Parameter pattern: 正则表达式
    /// - Returns: 筛选后的非法内容
    
    func mw_filterIllegal(pattern: String) -> String {
        guard let reg = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else { return "" }
        var content = self
        let result = reg.matches(in: self, options: .reportProgress, range: NSMakeRange(0, self.count))
        var count = 0
        result.forEach { (check) in
            let replaceStr = ""
            content = (content as NSString).replacingCharacters(in: NSRange(location: check.range.location+count, length: check.range.length), with: replaceStr)
            count = count - check.range.length + replaceStr.count
        }
        return content
    }
        
    /// 创建QRImage
    /// - Parameter size: 大小
    /// - Returns: 二维码图片
    
    func mw_creatQRImage(size: CGFloat) -> UIImage? {
        let strData = self.data(using: .utf8, allowLossyConversion: false)
        // 创建一个二维码的滤镜
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        qrFilter.setValue(strData, forKey: "inputMessage")
        qrFilter.setValue(size <= 150 ? "L" : "H", forKey: "inputCorrectionLevel")
        let qrCIImage = qrFilter.outputImage
        // 创建一个颜色滤镜,黑白色
        guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
        colorFilter.setDefaults()
        
        colorFilter.setValue(qrCIImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        
        guard let outputImage = colorFilter.outputImage else { return nil }
        let scale = size / outputImage.extent.size.width
        let image_tr = outputImage.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        let qrImage = UIImage(ciImage: image_tr)
        return qrImage
    }
        
    /// string转字典
    /// - Returns: [String: Any?]?
    
    func mw_toDictionary() -> [String: Any?]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?]
            } catch {
                mw_print_d(error.localizedDescription)
            }
        }
        return nil
    }
        
    /// string转数组
    /// - Returns: [Any?]?
    
    func mw_toArray() -> Array<Any?>? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Array<Any?>
            } catch {
                mw_print_d(error.localizedDescription)
            }
        }
        return nil
    }
        
    /// 去掉小数点后面无效的0，"1.3400"->"1.34"
    /// - Returns: 结果String
    
    func mw_deleteSuffixInvalidZero() -> String {
        var outNumber = self
        var i = 0
        
        if self.contains("."){
            while i < self.count{
                if outNumber.hasSuffix("0"){
                    outNumber.removeLast()
                    i = i + 1
                }else{
                    break
                }
            }
            if outNumber.hasSuffix("."){
                outNumber.removeLast()
            }
            return outNumber
        }
        else{
            return outNumber
        }
    }
    
    
    func mw_toDate(format: String) -> Date? {
        let date = Date.mw_from(string: self, format: format)
        return date
    }
    
    
    /// 去除前面无效的0，"001.2"->"1.2"
    /// - Returns: 结果String
    
    func mw_deletePrefixInvalidZero() -> String {
        var outNumber = self
        if outNumber.hasPrefix("0.") {
            return outNumber
        }
        if outNumber.count == 1 {
            return outNumber
        }
        
        while outNumber.hasPrefix("0") && outNumber.count > 1 {
            outNumber = (outNumber as NSString).substring(from: 1)
            if outNumber.hasPrefix("0.") {
                return outNumber
            }
        }
        return outNumber
    }
    
    /// HTMLString转化为NSAttributedString
    /// - Parameter textSize: 文本字体大小
    /// - Returns: NSAttributedString?
    
    func mw_addHtmlHeadToAttributedString(textSize: CGFloat = 22.0) -> NSAttributedString? {
        let string = self.mw_addHtmlHead(textSize: textSize)

        let attStr = try? NSMutableAttributedString(data: string.data(using: String.Encoding.utf8)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
        return attStr
    }

    /// 添加html头用于显示网页标签
    /// - Parameter textSize: 文本字体大小
    /// - Returns: String?
    
    func mw_addHtmlHead(textSize: CGFloat = 22.0) -> String {
        let headerS = "<html lang=\"zh-cn\"><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width, user-scalable=no\"></meta><style>img{max-width: 100%; width:auto; height:auto;}body{color:#333;text-align:justify;font-size:\(textSize)px !important;}</style></head><body>"
        let endS = "</body></html>"
        let string = headerS + self + endS
        return string
    }
    
    ///获取文件大小
    
    func mw_getFileSize() -> UInt64  {
        var size: UInt64 = 0
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        let isExists = fileManager.fileExists(atPath: self, isDirectory: &isDir)
        // 判断文件存在
        if isExists {
            // 是否为文件夹
            if isDir.boolValue {
                // 迭代器 存放文件夹下的所有文件名
                let enumerator = fileManager.enumerator(atPath: self)
                for subPath in enumerator! {
                    // 获得全路径
                    let fullPath = self.appending("/\(subPath)")
                    do {
                        let attr = try fileManager.attributesOfItem(atPath: fullPath)
                        size += attr[FileAttributeKey.size] as! UInt64
                    } catch  {
                        print("error :\(error)")
                    }
                }
            } else {    // 单文件
                do {
                    let attr = try fileManager.attributesOfItem(atPath: self)
                    size += attr[FileAttributeKey.size] as! UInt64
                    
                } catch  {
                    print("error :\(error)")
                }
            }
        }
        return size
    }
    
    ///真实内容，""会串返回空
    
    func mw_realContent() -> Self? {
        if self.count == 0 {
            return nil
        }
        return self
    }
    
    ///真实内容并过滤，空字符串会返回空
    
    func mw_realContentByTrimming(_ characterSet: CharacterSet) -> Self? {
        let trimmingStr = self.trimmingCharacters(in: characterSet)
        return trimmingStr.mw_realContent()
    }
    
    ///更新url中的querys
    
    func mw_updateQuerys(querys: String?) -> String {
        guard let newQuerys = querys?.mw_realContent() else {
            mw_print_i("无效querys")
            return self
        }
        
        var urlStr = self

        let subs = newQuerys.components(separatedBy: "&").filter{$0.count > 0}
        
        subs.forEach { (query) in
            urlStr = urlStr.mw_updateQuery(query: query)
        }
        
        return urlStr
    }
    
    ///更新url中的query
    
    private func mw_updateQuery(query: String?) -> String {
        guard let newQuery = query?.mw_realContent() else {
            mw_print_i("无效query")
            return self
        }
        
        guard let key = newQuery.components(separatedBy: "=").first, key.count > 0 else {
            mw_print_i("无效query")
            return self
        }
        
        var urlStr = self
        
        if let originQuery = URL(string: urlStr)?.query {
            
            let needUpdateQuerys = originQuery.components(separatedBy: "&").filter{$0.count > 0}.filter{$0.contains("\(key)=")}
            if needUpdateQuerys.count > 0 {
                needUpdateQuerys.forEach { (oldQuery) in
                    ///query需要更新直接替换
                    urlStr = urlStr.replacingOccurrences(of: oldQuery, with: newQuery)
                }
            }else{
                ///没有query需要更新直接add
                urlStr = urlStr.replacingOccurrences(of: "?", with: "?\(newQuery)&")
            }
            
            
        }else{
            ///没有旧query直接add
            urlStr = "\(urlStr)?\(newQuery)"
        }
        return urlStr
    }
    
    var mw_decimal: NSDecimalNumber {
        return NSDecimalNumber(string: self)
    }
    
    var mw_int: Int {
        return self.mw_decimal.intValue
    }
    
    var mw_double: Double {
        return self.mw_decimal.doubleValue
    }
    
    var mw_cgFloat: CGFloat {
        return CGFloat(self.mw_decimal.floatValue)
    }
    
    var mw_float: Float {
        return self.mw_decimal.floatValue
    }
    
}

