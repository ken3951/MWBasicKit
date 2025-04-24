//
//  UIControl+MWCategory.m
//  ShopManagerProgect
//
//  Created by mwk_pro on 2017/6/5.
//  Copyright © 2017年 mwk All rights reserved.
//

#import "UIControl+MWCategory.h"
#import <objc/runtime.h>
#import "NSObject+MWCategory.h"

@implementation UIControl (MWCategory)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self mw_swizzlingForClass:self originalSelector:@selector(sendAction:to:forEvent:) swizzledSelector:@selector(custom_sendAction:to:forEvent:)];
    });
}

- (NSTimeInterval )mw_eventInterval{
    return [objc_getAssociatedObject(self, "UIControl_acceptEventInterval") doubleValue];
}

- (void)setMw_eventInterval:(NSTimeInterval)custom_acceptEventInterval{
    objc_setAssociatedObject(self, "UIControl_acceptEventInterval", @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval )custom_acceptEventTime{
    return [objc_getAssociatedObject(self, "UIControl_acceptEventTime") doubleValue];
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{
    objc_setAssociatedObject(self, "UIControl_acceptEventTime", @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    // 如果想要设置统一的间隔时间，可以在此处加上以下几句
    // 值得提醒一下：如果这里设置了统一的时间间隔，会影响UISwitch,如果想统一设置，又不想影响UISwitch，建议将UIControl分类，改成UIButton分类，实现方法是一样的
//     if (self.custom_acceptEventInterval <= 0) {
//         // 如果没有自定义时间间隔，则默认为0.3秒
//        self.custom_acceptEventInterval = 1;
//     }
    
    // 是否小于设定的时间间隔
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= self.mw_eventInterval);
    
    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
    if (needSendAction) {
        // 更新上一次点击时间戳
        if (self.mw_eventInterval > 0) {
            self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
        }
        [self custom_sendAction:action to:target forEvent:event];
    }
}

@end
