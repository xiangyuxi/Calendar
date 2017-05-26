//
//  UIImage+Snap.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Snap)

/**
 view快照
 */
+ (UIImage *)snapshotWithView:(UIView *)view;
+ (UIImage *)snapshotWithView:(UIView *)view size:(CGSize)snapSize;

@end
