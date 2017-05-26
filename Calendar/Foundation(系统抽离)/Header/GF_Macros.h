//
//  GF_Marocs.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/17.
//  Copyright © 2017年 xyx. All rights reserved.
//

#ifndef GF_Macros_h
#define GF_Macros_h

// Debug打印
#ifdef DEBUG
#define GFLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define GFLog(...)
#endif

// 获取屏幕宽度与高度
#define kScrWidth  [UIScreen mainScreen].bounds.size.width
#define kScrHeight [UIScreen mainScreen].bounds.size.height

// 获取当前语言
#define kCurLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

// 获取temp
#define kPathTemp NSTemporaryDirectory()

// 获取沙盒Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

// 获取沙盒Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

// GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

// GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

// 当前window
#define kCurWindow [[UIApplication sharedApplication].windows firstObject]

// 通知中心
#define kNotificationCenter [NSNotificationCenter defaultCenter]

// 非空的字符串 避免输出null
#define kUnNilStr(str) ((str && ![str isEqual:[NSNull null]])?str:@"")

// app名称
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

// app版本
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 过期
#define GFDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 单利声明
#define gf_singleton_interface(class) + (instancetype)shared##class;

// 单利实现
#define gf_singleton_implementation(class) \
static class* _instance = nil; \
+ (instancetype)shared##class \
{\
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[super allocWithZone:NULL] init]; \
    }); \
    return _instance; \
} \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
    return [class shared##class]; \
} \
- (id)copyWithZone:(struct _NSZone *)zone \
{ \
    return [class shared##class]; \
}


#endif /* GF_Macros_h */
