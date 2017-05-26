//
//  GFObjcRuntime.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/21.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "GFObjcRuntime.h"

NSDictionary *gf_get_propertylist_from_obj(NSObject *object)
{
    return gf_get_propertylist_from_class([object class]);
}

NSDictionary *gf_get_propertylist_from_class(Class cls)
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (i = 0; i < outCount; i ++)
    {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        const char *propType = property_getAttributes(property);
        if(propType&&propName)
        {
            NSArray *anAttribute = [[NSString stringWithUTF8String:propType] componentsSeparatedByString:@","];
            NSString *aType = anAttribute[0];
            [dict setObject:aType forKey:[NSString stringWithUTF8String:propName]];
        }
    }
    free(properties);
    
    return dict;
}

void gf_Swizzle(Class c, SEL origSEL, SEL newSEL)
{
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method newMethod = nil;
    if (!origMethod)
    {
        origMethod = class_getClassMethod(c, origSEL);
        if (!origMethod)
            return;
        newMethod = class_getClassMethod(c, newSEL);
        if (!newMethod)
            return;
    }
    else
    {
        newMethod = class_getInstanceMethod(c, newSEL);
        if (!newMethod)
            return;
    }
    
    // 自身已经有，直接交换即可
    if(class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else method_exchangeImplementations(origMethod, newMethod);
}
