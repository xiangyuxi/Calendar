//
//  UIColor+Hex.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

// rgb颜色
#define RGB_255(r,g,b)    [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1]
#define RGBA_255(r,g,b,a) [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:a]
// 随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(NSUInteger)hexColor;
+ (UIColor *)colorWithHex:(NSUInteger)hexColor alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
