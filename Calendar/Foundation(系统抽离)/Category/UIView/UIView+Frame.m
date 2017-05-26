//
//  UIView+Frame.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setGf_x:(CGFloat)gf_x
{
    CGRect frame = self.frame;
    frame.origin.x = gf_x;
    self.frame = frame;
}

- (CGFloat)gf_x
{
    return self.frame.origin.x;
}

- (void)setGf_y:(CGFloat)gf_y
{
    CGRect frame = self.frame;
    frame.origin.y = gf_y;
    self.frame = frame;
}

- (CGFloat)gf_y
{
    return self.frame.origin.y;
}

- (void)setGf_w:(CGFloat)gf_w
{
    CGRect frame = self.frame;
    frame.size.width = gf_w;
    self.frame = frame;
}

- (CGFloat)gf_w
{
    return self.frame.size.width;
}

- (void)setGf_h:(CGFloat)gf_h
{
    CGRect frame = self.frame;
    frame.size.height = gf_h;
    self.frame = frame;
}

- (CGFloat)gf_h
{
    return self.frame.size.height;
}

- (void)setGf_size:(CGSize)gf_size
{
    CGRect frame = self.frame;
    frame.size = gf_size;
    self.frame = frame;
}

- (CGSize)gf_size
{
    return self.frame.size;
}

- (void)setGf_origin:(CGPoint)gf_origin
{
    CGRect frame = self.frame;
    frame.origin = gf_origin;
    self.frame = frame;
}

- (CGPoint)gf_origin
{
    return self.frame.origin;
}

@end
