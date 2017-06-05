//
//  UIButton+Highlight.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GF_Macros.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GFButtonState) {
    GFButtonStateNormal,
    GFButtonStateHighlight,
    GFButtonStateSelected
};

@interface UIButton (Highlight)

/**
 默认在GFButtonStateNormal状态下的颜色为透明
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(GFButtonState)state;
- (UIColor *)backgroundColorForState:(GFButtonState)state;

@end

@interface UIButton (Deprecated)

@property (nullable, nonatomic, copy) UIColor *backgroundColor; //GFDeprecated("使用'setBackgroundColor:forState:'代替。");

@end

NS_ASSUME_NONNULL_END
