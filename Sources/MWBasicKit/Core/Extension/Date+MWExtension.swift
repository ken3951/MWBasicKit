//
//  Date+Extension.swift
//  FunCityMerchant_Swift
//
//  Created by mwk_pro on 2017/12/19.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import Foundation

public extension Date {
    
    /// 时间比较类型
    enum CompareSameType: Int {
        case year = 10011
        case yearToMonth
        case yearToDay
        case yearToHour
        case yearToMinute
    }
    
    var mw_year : Int {
        get{
            let calendar = Calendar.current
            return calendar.component(.year, from: self)
        }
        set{
            let calendar = Calendar.current

            var components = DateComponents()
            components.year = newValue
            components.month = self.mw_month
            components.day = self.mw_day
            components.hour = self.mw_hour
            components.minute = self.mw_minute
            components.second = self.mw_second
            self = calendar.date(from: components) ?? self
        }
    }
    
    var mw_month : Int {
        get{
            let calendar = Calendar.current
            return calendar.component(.month, from: self)
        }
        set{
            let calendar = Calendar.current

            var components = DateComponents()
            components.year = self.mw_year
            components.month = newValue
            components.day = self.mw_day
            components.hour = self.mw_hour
            components.minute = self.mw_minute
            components.second = self.mw_second
            self = calendar.date(from: components) ?? self
        }
    }
    
    var mw_day : Int {
        get{
            let calendar = Calendar.current
            return calendar.component(.day, from: self)
        }
        set{
            let calendar = Calendar.current
                                                  
            var components = DateComponents()
            components.year = self.mw_year
            components.month = self.mw_month
            components.day = newValue
            components.hour = self.mw_hour
            components.minute = self.mw_minute
            components.second = self.mw_second
            self = calendar.date(from: components) ?? self
        }
    }
    
    var mw_hour : Int {
        get{
            let calendar = Calendar.current
            return calendar.component(.hour, from: self)
        }
        set{
            let calendar = Calendar.current

            var components = DateComponents()
            components.year = self.mw_year
            components.month = self.mw_month
            components.day = self.mw_day
            components.hour = newValue
            components.minute = self.mw_minute
            components.second = self.mw_second
            self = calendar.date(from: components) ?? self
        }
    }
    
    var mw_minute : Int {
        get{
            let calendar = Calendar.current
            return calendar.component(.minute, from: self)
        }
        set{
            let calendar = Calendar.current

            var components = DateComponents()
            components.year = self.mw_year
            components.month = self.mw_month
            components.day = self.mw_day
            components.hour = self.mw_hour
            components.minute = newValue
            components.second = self.mw_second
            self = calendar.date(from: components) ?? self
        }
    }
    
    var mw_second : Int {
        get{
            let calendar = Calendar.current
            return calendar.component(.second, from: self)
        }
        set{
            let calendar = Calendar.current

            var components = DateComponents()
            components.year = self.mw_year
            components.month = self.mw_month
            components.day = self.mw_day
            components.hour = self.mw_hour
            components.minute = self.mw_minute
            components.second = newValue
            self = calendar.date(from: components) ?? self
        }
    }
    
    ///周几
    var mw_weekday : String {
        get{
            let weekDays = [NSNull.init(),"周日","周一","周二","周三","周四","周五","周六"]as [Any]
            let calendar = NSCalendar.init(calendarIdentifier: .gregorian)
            let timeZone = NSTimeZone.init(name:"Asia/Shanghai")
            calendar?.timeZone = timeZone! as TimeZone
            let calendarUnit = NSCalendar.Unit.weekday
            let theComponents = calendar?.components(calendarUnit, from:self)
            return weekDays[(theComponents?.weekday)!]as! String
        }
        set{
            
        }
    }
    
    ///星期几
    var mw_weekday2 : String {
        get{
            let weekDays = [NSNull.init(),"星期日","星期一","星期二","星期三","星期四","星期五","星期六"]as [Any]
            let calendar = NSCalendar.init(calendarIdentifier: .gregorian)
            let timeZone = NSTimeZone.init(name:"Asia/Shanghai")
            calendar?.timeZone = timeZone! as TimeZone
            let calendarUnit = NSCalendar.Unit.weekday
            let theComponents = calendar?.components(calendarUnit, from:self)
            return weekDays[(theComponents?.weekday)!]as! String
        }
        set{
            
        }
    }
    
    ///该月的天数
    func mw_numberOfDaysInMonth() -> Int {
        let calendar = Calendar.current
        let days = calendar.range(of: .day, in: .month, for: self)
        return days!.count
    }
    
    ///格式化
    func mw_toString(format: String) -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat=format
        let string = formatter.string(from: self)
        return string
    }
    
    //根据年月日时分秒创建date
    static func mw_from(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date? {
        let calendar = Calendar.current
        var components = DateComponents.init()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        let date = calendar.date(from: components)
        return date
    }
    
    ///string转date
    static func mw_from(string: String, format: String) -> Date? {
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        let date = formatter.date(from: string)
        return date
    }
    
    ///string,根据timeZone转date
    static func mw_from(string: String, format: String, timeZone: Int) -> Date? {
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: timeZone)
        let date = formatter.date(from: string)
        return date
    }
    
    ///获取前七天[date],包含今天
    static func mw_getPreSevenDate() -> Array<Date> {
        var list : Array<Date> = []
        let todayDate = Date()
        for i in 0...6 {
            var day = todayDate.mw_day - (6 - i)
            
            var month = todayDate.mw_month
            var year = todayDate.mw_year

            if day <= 0 {
                month = month - 1
                if month <= 0 {
                    month = 12
                    year = year - 1
                }
                let tempDate = self.mw_from(year: year, month: month, day: 1)!
                let monthDays = tempDate.mw_numberOfDaysInMonth()
                day = monthDays + day
            }
            let indexDate = self.mw_from(year: year, month: month, day: day)!
            list.append(indexDate)
        }
        return list
    }
    
    //当天0点时间戳
    func mw_getTodayStartTimeInterval() -> Int {
        var selfDate = self
        selfDate.mw_hour = 0
        selfDate.mw_minute = 0
        selfDate.mw_second = 0
        let timeInterval = Int(selfDate.timeIntervalSince1970)
        return timeInterval
    }
    
    //当天23.59分的时间戳
    func mw_getTodayEndTimeInterval() -> Int {
        let timeInterval = self.mw_getTodayStartTimeInterval() + 24 * 60 * 60 - 1
        return timeInterval
    }
    
    ///本周最开始的时间
    func mw_getWeekStartDate() -> Date {
        let today = Date(timeIntervalSince1970: TimeInterval(self.mw_getTodayStartTimeInterval()))
        switch today.mw_weekday {
        case "周一":
            return today
        case "周二":
            return Date(timeIntervalSince1970: TimeInterval(today.timeIntervalSince1970 - 24*60*60))
        case "周三":
            return Date(timeIntervalSince1970: TimeInterval(today.timeIntervalSince1970 - 2*24*60*60))
        case "周四":
            return Date(timeIntervalSince1970: TimeInterval(today.timeIntervalSince1970 - 3*24*60*60))
        case "周五":
            return Date(timeIntervalSince1970: TimeInterval(today.timeIntervalSince1970 - 4*24*60*60))
        case "周六":
            return Date(timeIntervalSince1970: TimeInterval(today.timeIntervalSince1970 - 5*24*60*60))
        case "周日":
            return Date(timeIntervalSince1970: TimeInterval(today.timeIntervalSince1970 - 6*24*60*60))
        default:
            return today
        }
    }
    
    ///本周结束的时间
    func mw_getWeekEndDate() -> Date {
        let startDate = mw_getWeekStartDate()
        return Date(timeIntervalSince1970: TimeInterval(startDate.timeIntervalSince1970 + 7*24*60*60 - 1))
    }
    
    ///本月开始的时间
    func mw_getMonthStartDate() -> Date {
        let today = Date(timeIntervalSince1970: TimeInterval(self.mw_getTodayStartTimeInterval()))
        return Date(timeIntervalSince1970: TimeInterval(Int(today.timeIntervalSince1970) - (today.mw_day - 1)*24*60*60))
    }
    
    ///本月结束的时间
    func mw_getMonthEndDate() -> Date {
        let startDate = mw_getMonthStartDate()
        return Date(timeIntervalSince1970: TimeInterval(Int(startDate.timeIntervalSince1970) + startDate.mw_numberOfDaysInMonth()*24*60*60 - 1))
    }
    
    /// 时间比较
    /// - Parameters:
    ///   - date: 对比时间
    ///   - compareSameType: 比较类型
    /// - Returns: 返回是否相同
    func mw_isSameTo(_ date: Date, compareSameType: CompareSameType) -> Bool {
        switch compareSameType {
        case .year:
            return self.mw_year == date.mw_year
        case .yearToMonth:
            return self.mw_year == date.mw_year && self.mw_month == date.mw_month
        case .yearToDay:
            return self.mw_year == date.mw_year && self.mw_month == date.mw_month && self.mw_day == date.mw_day
        case .yearToHour:
            return self.mw_year == date.mw_year && self.mw_month == date.mw_month && self.mw_day == date.mw_day && self.mw_hour == date.mw_hour
        case .yearToMinute:
            return self.mw_year == date.mw_year && self.mw_month == date.mw_month && self.mw_day == date.mw_day && self.mw_hour == date.mw_hour && self.mw_minute == date.mw_minute
        }
    }
}


