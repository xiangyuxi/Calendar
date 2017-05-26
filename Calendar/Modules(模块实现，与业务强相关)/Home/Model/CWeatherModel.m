//
//  CWeatherModel.m
//  Calendar
//
//  Created by yxiang on 2017/5/5.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CWeatherModel.h"
#import "CTools.h"

@implementation CWeatherModel

- (void)updateWeatherWithYear:(NSInteger)year inMonth:(NSInteger)month atDay:(NSInteger)day
{
    self.day = [NSString stringWithFormat:@"%ld",day];
    self.imageName = weatherTypeString().firstObject;
    self.weather = @"晴   -5℃~9℃";
    self.thing = @"陪朋友去吃饭";
    self.called = [[CTools sharedCTools] getCalledAtYear:year inMonth:month inDay:day];
    self.type = @"重度污染";
}

@end
