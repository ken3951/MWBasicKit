

#import "UIView+MWCategory.h"
#import <objc/runtime.h>
#import "NSObject+MWCategory.h"

@implementation UIView (MWCategory)

// extendHitArea 是暴露出来的一个属性 。
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self mw_swizzlingForClass:self originalSelector:@selector(pointInside:withEvent:) swizzledSelector:@selector(swz_pointInside:withEvent:)];
    });
}

- (void)setExtendedHitArea:(UIEdgeInsets)insets {
    objc_setAssociatedObject(self, @selector(extendedHitArea), @(insets), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)extendedHitArea {
    UIEdgeInsets insets = [objc_getAssociatedObject(self, @selector(extendedHitArea)) UIEdgeInsetsValue];
    return insets;
}

- (void)setExtendedSubViewEnable:(BOOL)enable {
    objc_setAssociatedObject(self, @selector(extendedSubViewEnable), @(enable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)extendedSubViewEnable {
    BOOL enable = [objc_getAssociatedObject(self, @selector(extendedSubViewEnable)) boolValue];
    return enable;
}

/*!
 @method 可以响应点击事件的rect
 */
- (CGRect)responseHitAreaWidtRect:(CGRect)rect {
    UIEdgeInsets insets = self.extendedHitArea;
    
    if (!UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero)) {
        return                       CGRectMake(
                                                rect.origin.x-insets.left,
                                                rect.origin.y-insets.top,
                                                rect.size.width+insets.left+insets.right,
                                                rect.size.height+insets.top+insets.bottom);

    } else {
        return rect;
    }
}

- (BOOL)swz_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL result = [self swz_pointInside:point withEvent:event];
    CGRect responseHitArea = [self responseHitAreaWidtRect:self.bounds];
    BOOL ret = ( result
                ||CGRectEqualToRect(responseHitArea, CGRectZero)
                ||!self.isUserInteractionEnabled
                ||self.isHidden);
    if (ret) {
        return result;
    } 
    BOOL containPoint = CGRectContainsPoint(responseHitArea, point);
    if (!containPoint && self.extendedSubViewEnable) {
        for (UIView *v in self.subviews) {
            BOOL ignore = (CGRectContainsRect(self.bounds, v.frame)
                           ||!v.isUserInteractionEnabled
                           ||v.isHidden);
            if (ignore) {
                continue;
            }
            CGRect subViewResponseHitArea = [v responseHitAreaWidtRect:v.frame];
            BOOL subViewContainPoint = CGRectContainsPoint(subViewResponseHitArea, point);
            if (subViewContainPoint) {
                return subViewContainPoint;
            }
            continue;
        }
    }
    return containPoint;
}


@end
