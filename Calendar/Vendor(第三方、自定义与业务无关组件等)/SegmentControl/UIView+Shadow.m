//
//  UIView+Shadow.m
//  Calendar
//
//  Created by xiangyuxi on 2017/5/29.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)

- (void)addShadowWithColor:(UIColor *)color {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = 8;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowOffset = CGSizeMake(0, 5);
}

- (void)removeShadow {
    self.layer.shadowOpacity = 0;
}

@end
