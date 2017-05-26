//
//  CWeatherModel.h
//  Calendar
//
//  Created by yxiang on 2017/5/5.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWeatherModel : NSObject

@property (copy, nonatomic) NSString *day;
@property (copy, nonatomic) NSString *imageName;
@property (copy, nonatomic) NSString *weather;
@property (copy, nonatomic) NSString *called;
@property (copy, nonatomic) NSString *thing;
@property (copy, nonatomic) NSString *type;

- (void)updateWeatherWithYear:(NSInteger)year inMonth:(NSInteger)month atDay:(NSInteger)day;

@end
