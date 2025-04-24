//
//  NSObject+MWCategory.h
//  AIChat
//
//  Created by 马文奎 on 2025/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MWCategory)

+ (void)mw_swizzlingForClass:(Class)forClass
           originalSelector:(SEL)originalSelector
            swizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
