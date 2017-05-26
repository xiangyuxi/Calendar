//
//  GFDeviceUtil.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/17.
//  Copyright © 2017年 xyx. All rights reserved.
//
// from:http://blog.csdn.net/ZuoWeiXiaoDuZuoZuo/article/details/49945157

#import <Foundation/Foundation.h>
#import "GF_Macros.h"

NS_ASSUME_NONNULL_BEGIN

@interface GFDeviceUtil : NSObject

gf_singleton_interface(GFDeviceUtil)

@property (nullable, nonatomic, copy, readonly) NSString *deviceModel;

@end

NS_ASSUME_NONNULL_END
