//
//  UIImage+Color.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 用color生成image
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 改变image透明度
 */
- (UIImage *)imageWithAlpha:(CGFloat)alpha;

@end
