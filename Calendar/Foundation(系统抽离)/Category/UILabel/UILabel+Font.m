//
//  UILabel+Font.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/24.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <objc/runtime.h>
#import "UILabel+Font.h"

@implementation UILabel (Font)

static char font_size_key = '\0';

- (void)setFontSize:(CGFloat)fontSize
{
    if (self.fontSize == fontSize)
        return;
    objc_setAssociatedObject(self, &font_size_key, @(fontSize), OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.font = [UIFont systemFontOfSize:fontSize];
}

- (CGFloat)fontSize
{
    return [objc_getAssociatedObject(self, &font_size_key) floatValue];
}

@end
