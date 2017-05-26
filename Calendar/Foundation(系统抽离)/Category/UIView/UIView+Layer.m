//
//  UIView+Layer.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/21.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "UIView+Layer.h"
#import <objc/runtime.h>

@implementation UIView (Layer)

static char border_color_key = '\0';
- (void)setBorderColor:(UIColor *)borderColor
{
    objc_setAssociatedObject(self, &border_color_key, borderColor, OBJC_ASSOCIATION_COPY);
    self.layer.backgroundColor = borderColor.CGColor;
}
- (UIColor *)borderColor
{
    return objc_getAssociatedObject(self, &border_color_key);
}

static char border_width_key = '\0';
- (void)setBorderWidth:(CGFloat)borderWidth
{
    objc_setAssociatedObject(self, &border_width_key, @(borderWidth), OBJC_ASSOCIATION_COPY);
    self.layer.borderWidth = borderWidth;
}
- (CGFloat)borderWidth
{
    return [objc_getAssociatedObject(self, &border_width_key) floatValue];
}

static char corner_radius_key = '\0';
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    objc_setAssociatedObject(self, &corner_radius_key, @(cornerRadius), OBJC_ASSOCIATION_COPY);
    self.layer.cornerRadius = cornerRadius;
}
- (CGFloat)cornerRadius
{
    return [objc_getAssociatedObject(self, &corner_radius_key) floatValue];
}

static char masks_tobounds_key = '\0';
- (void)setMasksToBounds:(BOOL)masksToBounds
{
    objc_setAssociatedObject(self, &masks_tobounds_key, @(masksToBounds), OBJC_ASSOCIATION_COPY);
    self.layer.masksToBounds = masksToBounds;
}
- (BOOL)masksToBounds
{
    return [objc_getAssociatedObject(self, &masks_tobounds_key) boolValue];
}

@end
