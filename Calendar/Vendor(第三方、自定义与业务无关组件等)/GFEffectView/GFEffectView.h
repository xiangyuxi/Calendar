//
//  GFEffectView.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/17.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Enum of translucent style.
typedef NS_ENUM(NSUInteger, GFEffectViewStyle) {
    /// Default(Dark).
    GFEffectViewStyleDefault,
    /// Light.
    GFEffectViewStyleLight
};

/*
 8.0以上使用UIEffectView实现，以下使用UIToolBar实现
 */

@interface GFEffectView : UIView

/**
 YES，支持ib
 */
@property (assign, nonatomic) IBInspectable BOOL translucent;
/**
 默认YXEffectStyleDefault，必须translucent为YES才有效
 */
@property (assign, nonatomic) IBInspectable GFEffectViewStyle style;

@end
