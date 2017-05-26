//
//  UIViewController+LifeCycleCalled.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/24.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "UIViewController+LifeCycleCalled.h"
#import "GF_Utils.h"

@implementation UIViewController (LifeCycleCalled)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gf_Swizzle([UIViewController class], @selector(viewDidLoad), @selector(gf_viewDidLoad));
        gf_Swizzle([UIViewController class], @selector(viewWillAppear:), @selector(gf_viewWillAppear:));
        gf_Swizzle([UIViewController class], @selector(viewDidAppear:), @selector(gf_viewDidAppear:));
        gf_Swizzle([UIViewController class], @selector(viewWillDisappear:), @selector(gf_viewWillDisappear:));
        gf_Swizzle([UIViewController class], @selector(viewDidDisappear:), @selector(gf_viewDidDisappear:));
    });
}

- (void)gf_viewDidLoad
{
    [self gf_viewDidLoad];
    if ([self viewDidLoadBlock])
        [self viewDidLoadBlock](self);
}

- (void)gf_viewWillAppear:(BOOL)animation
{
    [self gf_viewWillAppear:animation];
    if ([self viewWillAppearBlock])
        [self viewWillAppearBlock](self,animation);
}

- (void)gf_viewDidAppear:(BOOL)animation
{
    [self gf_viewDidAppear:animation];
    if ([self viewDidAppearBlock])
        [self viewDidAppearBlock](self,animation);
}

- (void)gf_viewWillDisappear:(BOOL)animation
{
    [self gf_viewWillDisappear:animation];
    if ([self viewWillDisappearBlock])
        [self viewWillDisappearBlock](self,animation);
}

- (void)gf_viewDidDisappear:(BOOL)animation
{
    [self gf_viewDidDisappear:animation];
    if ([self viewDidDisappearBlock])
        [self viewDidDisappearBlock](self,animation);
}

static char view_didload_key = '\0';
static char view_willappear_key = '\0';
static char view_didappear_key = '\0';
static char view_willdisappear_key = '\0';
static char view_diddisappear_key = '\0';

- (void)setViewDidLoadBlock:(GFViewDidLoadBlock)viewDidLoadBlock
{
    objc_setAssociatedObject(self, &view_didload_key, viewDidLoadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (GFViewDidLoadBlock)viewDidLoadBlock
{
    return objc_getAssociatedObject(self, &view_didload_key);
}

- (void)setViewWillAppearBlock:(GFViewWillAppearBlock)viewWillAppearBlock
{
    objc_setAssociatedObject(self, &view_willappear_key, viewWillAppearBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (GFViewWillAppearBlock)viewWillAppearBlock
{
    return objc_getAssociatedObject(self, &view_willappear_key);
}

- (void)setViewDidAppearBlock:(GFViewDidAppearBlock)viewDidAppearBlock
{
    objc_setAssociatedObject(self, &view_didappear_key, viewDidAppearBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (GFViewDidAppearBlock)viewDidAppearBlock
{
    return objc_getAssociatedObject(self, &view_didappear_key);
}

- (void)setViewWillDisappearBlock:(GFViewWillDisappearBlock)viewWillDisappearBlock
{
    objc_setAssociatedObject(self, &view_willdisappear_key, viewWillDisappearBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (GFViewWillDisappearBlock)viewWillDisappearBlock
{
    return objc_getAssociatedObject(self, &view_willdisappear_key);
}

- (void)setViewDidDisappearBlock:(GFViewDidDisappearBlock)viewDidDisappearBlock
{
    objc_setAssociatedObject(self, &view_diddisappear_key, viewDidDisappearBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (GFViewDidDisappearBlock)viewDidDisappearBlock
{
    return objc_getAssociatedObject(self, &view_diddisappear_key);
}

@end
