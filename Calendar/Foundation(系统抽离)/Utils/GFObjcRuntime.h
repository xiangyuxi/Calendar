//
//  GFObjcRuntime.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/21.
//  Copyright © 2017年 xyx. All rights reserved.
//

#ifndef GFObjcRuntime_h
#define GFObjcRuntime_h

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/**
 根据对象或类，获取属性列表。key表示属性类型，value表示属性名称。
 只能获取@property的对象，无法获取到父类的属性信息。
 */
extern NSDictionary *gf_get_propertylist_from_obj(NSObject *obj);
extern NSDictionary *gf_get_propertylist_from_class(Class cls);

/**
  静态就交换静态，实例方法就交换实例方法
 */
extern void gf_Swizzle(Class c, SEL origSEL, SEL newSEL);

#endif /* GFObjcRuntime_h */
