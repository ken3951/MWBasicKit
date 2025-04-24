//
//  UILabel+MWCategory.m
//  AIChat
//
//  Created by 马文奎 on 2025/4/24.
//

#import "UILabel+MWCategory.h"
#import "NSObject+MWCategory.h"
#import <objc/runtime.h>

@implementation UILabel (MWCategory)

// 动态添加 padding 属性
- (void)setPadding:(UIEdgeInsets)padding {
    NSValue *value = [NSValue valueWithUIEdgeInsets:padding];
    objc_setAssociatedObject(self, @selector(padding), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self invalidateIntrinsicContentSize]; // 触发重新布局
}

- (UIEdgeInsets)padding {
    NSValue *value = objc_getAssociatedObject(self, @selector(padding));
    return value ? [value UIEdgeInsetsValue] : UIEdgeInsetsZero;
}

// 替换 drawTextInRect: 方法
- (void)swizzled_drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = self.padding;
    CGRect insetRect = UIEdgeInsetsInsetRect(rect, insets);
    [self swizzled_drawTextInRect:insetRect]; // 调用原始的 drawTextInRect:
}

// 重写 intrinsicContentSize 方法，确保内边距影响 label 的大小
- (CGSize)swizzled_intrinsicContentSize {
    CGSize originalSize = [self swizzled_intrinsicContentSize];
    UIEdgeInsets insets = self.padding;
    return CGSizeMake(originalSize.width + insets.left + insets.right,
                      originalSize.height + insets.top + insets.bottom);
}

// 重写 sizeThatFits: 方法，确保内边距影响 label 的大小
- (CGSize)swizzled_sizeThatFits:(CGSize)size {
    CGSize originalSize = [self swizzled_sizeThatFits:size];
    UIEdgeInsets insets = self.padding;
    return CGSizeMake(originalSize.width + insets.left + insets.right,
                      originalSize.height + insets.top + insets.bottom);
}

// 在 +load 方法中执行方法交换
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self mw_swizzlingForClass:self originalSelector:@selector(drawTextInRect:) swizzledSelector:@selector(swizzled_drawTextInRect:)];
        
        [self mw_swizzlingForClass:self originalSelector:@selector(intrinsicContentSize) swizzledSelector:@selector(swizzled_intrinsicContentSize)];
        
        [self mw_swizzlingForClass:self originalSelector:@selector(sizeThatFits:) swizzledSelector:@selector(swizzled_sizeThatFits:)];
    });
}

@end
