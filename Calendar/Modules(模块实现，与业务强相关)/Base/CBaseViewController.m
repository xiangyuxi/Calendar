//
//  CBaseViewController.m
//  Calendar
//
//  Created by yxiang on 2017/6/1.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CBaseViewController.h"

@interface CBaseViewController () 

@end

@implementation CBaseViewController

+ (void)load {
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    //设置背景透明图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    //去掉 bar 下面有一条黑色的线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

}

@end
