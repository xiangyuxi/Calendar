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
//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView: (UIView *)theView atFrame:(CGRect)r
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}
@end
