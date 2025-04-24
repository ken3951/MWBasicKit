//
//  NSObject+MWCategory.m
//  AIChat
//
//  Created by 马文奎 on 2025/4/24.
//

#import "NSObject+MWCategory.h"
#import <objc/runtime.h>

@implementation NSObject (MWCategory)

+ (void)mw_swizzlingForClass:(Class)forClass
           originalSelector:(SEL)originalSelector
           swizzledSelector:(SEL)swizzledSelector {
    // 获取原始方法和替换方法
    Method originalMethod = class_getInstanceMethod(forClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector);

    if (!originalMethod || !swizzledMethod) {
        return; // 如果方法不存在，直接返回
    }

    // 尝试添加原始方法到类中
    BOOL didAddMethod = class_addMethod(forClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        // 如果添加成功，用替换方法实现替换原始方法
        class_replaceMethod(forClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        // 如果添加失败，直接交换方法实现
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
