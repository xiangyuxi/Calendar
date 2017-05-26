//
//  GFModel.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/21.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GFModelProtocol <NSObject>

@optional
/**
 数组中需要转换的模型类
 @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)objectClassInArray;

@end

@interface GFModel : NSObject <GFModelProtocol>

/**
 字典转模型
 */
- (instancetype)initWithDictionary:(NSDictionary *)keyValues;
+ (instancetype)modelFromDictionary:(NSDictionary *)keyValues;

/**
 模型转字典
 */
- (NSDictionary *)dictionaryFromModel;
+ (NSDictionary *)dictionaryFromModel:(GFModel *)model;

@end
