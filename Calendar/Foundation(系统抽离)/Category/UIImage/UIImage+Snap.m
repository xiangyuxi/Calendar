//
//  UIImage+Snap.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "UIImage+Snap.h"

@implementation UIImage (Snap)

+ (UIImage *)snapshotWithView:(UIView *)view
{
    return [self snapshotWithView:view size:view.bounds.size];
}
+ (UIImage *)snapshotWithView:(UIView *)view size:(CGSize)snapSize
{
    UIGraphicsBeginImageContextWithOptions(snapSize, NO, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
