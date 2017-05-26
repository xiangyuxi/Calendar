//
//  UIViewController+LifeCycleCalled.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/24.
//  Copyright © 2017年 xyx. All rights reserved.
//
//  封装本文件是在某些情况我们会在一个controller内初始化一个controller，只是做一些简单的使用
//  ，如果还要单独建一个文件管理它又显得多此一举，所以通过本文件可以快速定制一个controller。

#import <UIKit/UIKit.h>

/**
 *  页面需要透出的通用事件，例如viewDidLoad，viewWillAppear，viewDidAppear等
 */
typedef void(^GFViewDidLoadBlock)(UIViewController *controller);
typedef void(^GFViewWillAppearBlock)(UIViewController *controller, BOOL aAnimated);
typedef void(^GFViewDidAppearBlock)(UIViewController *controller, BOOL aAnimated);
typedef void(^GFViewWillDisappearBlock)(UIViewController *controller, BOOL aAnimated);
typedef void(^GFViewDidDisappearBlock)(UIViewController *controller, BOOL aAnimated);

@protocol UIViewControllerLifeCycleDelegate <NSObject>

/**
 *  View的相关事件调出
 */
- (void)setViewDidLoadBlock:(GFViewDidLoadBlock)viewDidLoadBlock; /// 调用时应该在第一时间设置，否则不会执行到
- (void)setViewWillAppearBlock:(GFViewWillAppearBlock)viewWillAppearBlock;
- (void)setViewDidAppearBlock:(GFViewDidAppearBlock)viewDidAppearBlock;
- (void)setViewWillDisappearBlock:(GFViewWillDisappearBlock)viewWillDisappearBlock;
- (void)setViewDidDisappearBlock:(GFViewDidDisappearBlock)viewDidDisappearBlock;

@end

@interface UIViewController (LifeCycleCalled) <UIViewControllerLifeCycleDelegate>

@end
