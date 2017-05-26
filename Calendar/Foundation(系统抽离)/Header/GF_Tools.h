//
//  GF_Tools.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/17.
//  Copyright © 2017年 xyx. All rights reserved.
//

#ifndef GF_Tools_h
#define GF_Tools_h

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#endif

// 系统版本
NS_INLINE CGFloat gf_device_version()
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
// 角度->弧度
NS_INLINE CGFloat gf_degrees_2_radian(CGFloat d)
{
    return (M_PI * (d) / 180.0);
}

// 弧度->角度
NS_INLINE CGFloat gf_radian_2_degrees(CGFloat r)
{
    return (r * 180.0) / (M_PI);
}

// 状态栏高度，20
UIKIT_EXTERN CGFloat const kStatusHeight;
// 导航栏高度，64
UIKIT_EXTERN CGFloat const kNavigationBarHeight;

#endif /* GF_Tools_h */
