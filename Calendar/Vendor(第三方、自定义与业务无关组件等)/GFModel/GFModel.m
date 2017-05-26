//
//  GFModel.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/21.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "GFModel.h"
#import "MJExtension.h"

@implementation GFModel

// 实现coding方法
MJExtensionCodingImplementation

- (instancetype)initWithDictionary:(NSDictionary *)keyValues
{
    return [self.class modelFromDictionary:keyValues];
}

+ (instancetype)modelFromDictionary:(NSDictionary *)keyValues
{
    if (!keyValues)
        return nil;
    return [[self alloc] mj_setKeyValues:keyValues];
}

- (NSDictionary *)dictionaryFromModel
{
    return [self.class dictionaryFromModel:self];
}

+ (NSDictionary *)dictionaryFromModel:(GFModel *)model
{
    if ([model isKindOfClass:[GFModel class]])
        return [model mj_keyValues].copy;
    return nil;
}

+ (NSDictionary *)mj_objectClassInArray
{
    if ([self respondsToSelector:@selector(objectClassInArray)])
        return [self objectClassInArray];
    return nil;
}

@end
