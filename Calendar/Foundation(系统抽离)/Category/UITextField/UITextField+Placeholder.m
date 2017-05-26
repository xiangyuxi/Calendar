//
//  UITextField+Placeholder.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/25.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <objc/runtime.h>
#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)

static char placeholder_color_key = '\0';

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    if (![self.placeholderColor isEqual:placeholderColor])
        return;
    objc_setAssociatedObject(self, &placeholder_color_key, placeholderColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, &placeholder_color_key);
}

@end
