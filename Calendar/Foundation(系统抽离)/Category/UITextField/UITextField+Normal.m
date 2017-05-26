//
//  UITextField+Normal.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/25.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "UITextField+Normal.h"
#import "GFObjcRuntime.h"

@implementation UITextField (Normal)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gf_Swizzle([UITextField class], @selector(setSecureTextEntry:), @selector(gf_setSecureTextEntry:));
    });
}

- (void)gf_setSecureTextEntry:(BOOL)secure
{
    [self gf_setSecureTextEntry:secure];
    NSString *text = self.text;
    self.text = text;
}

@end
