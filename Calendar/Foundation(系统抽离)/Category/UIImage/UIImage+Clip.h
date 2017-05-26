//
//  UIImage+Clip.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Clip)

/**
 生成相应圆角image
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;
+ (UIImage *)imageWithCornerRadius:(CGFloat)radius fromImage:(UIImage *)image;

@end
