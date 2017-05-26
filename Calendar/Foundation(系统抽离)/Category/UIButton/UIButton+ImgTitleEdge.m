//
//  UIButton+ImgTitleEdge.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/20.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "UIButton+ImgTitleEdge.h"
#import <objc/runtime.h>

static char it_style_key = '\0';
static char it_spacing_key = '\0';

@implementation UIButton (ImgTitleEdge)

- (void)updateImageAndTitleEdges
{
    // 1. imageView的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    // 2. titleLabel的宽、高
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    }
    else
    {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 3. 计算实际高低
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    switch (self.itStyle) {
        case GFButtonITStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-self.itSpacing/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-self.itSpacing/2.0, 0);
        }
            break;
        case GFButtonITStyleleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -self.itSpacing/2.0, 0, self.itSpacing/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, self.itSpacing/2.0, 0, -self.itSpacing/2.0);
        }
            break;
        case GFButtonITStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-self.itSpacing/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-self.itSpacing/2.0, -imageWith, 0, 0);
        }
            break;
        case GFButtonITStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+self.itSpacing/2.0, 0, -labelWidth-self.itSpacing/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-self.itSpacing/2.0, 0, imageWith+self.itSpacing/2.0);
        }
            break;
        default:
            break;
    }
    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = labelEdgeInsets;
}

- (void)setItStyle:(GFButtonITStyle)itStyle
{
    objc_setAssociatedObject(self, &it_style_key, @(itStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self updateImageAndTitleEdges];
}

- (GFButtonITStyle)itStyle
{
    return (GFButtonITStyle)[objc_getAssociatedObject(self, &it_style_key) integerValue];
}

- (void)setItSpacing:(CGFloat)itSpacing
{
    objc_setAssociatedObject(self, &it_spacing_key, @(itSpacing), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self updateImageAndTitleEdges];
}

- (CGFloat)itSpacing
{
    return [objc_getAssociatedObject(self, &it_spacing_key) floatValue];
}

@end
