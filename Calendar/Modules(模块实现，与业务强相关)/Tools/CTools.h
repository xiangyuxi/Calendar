//
//  CTools.h
//  Calendar
//
//  Created by yxiang on 2017/4/25.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTools : NSObject

/**
 返回天气状况数组
 */
extern NSArray *weatherTypeString();

gf_singleton_interface(CTools)

/**
 根据年月获取本月总共天数
 @param year 年
 @param month 月
 @return 总共天数
 */
- (NSInteger)totalDayAtYear:(NSInteger)year inMonth:(NSInteger)month;

/**
 根据年月获取本月第一天为星期几
 @param year 年
 @param month 月
 @return 星期几（星期天-星期六：1,2,3,4,5,6,7   为了和数组匹配，-1）
 */
- (NSInteger)firstDayisWeekAtYear:(NSInteger)year inMonth:(NSInteger)month;


/**
 当前时间是多少年，多少月，多少号
 @return @[year,month,day]
 */
- (NSArray *)currentDay;

/**
 获取本年本月中的农历第一天是几号
 @param year 年
 @param month 月
 @return 农历第一天
 */
- (NSArray *)chinaFirstDayAtYear:(NSInteger)year inMonth:(NSInteger)month;

/**
 根据公历年获取农历年的叫法
 @param year 年
 @return 例如：丙申猴年
 */
- (NSString *)chinaYearStringAtSolYear:(NSInteger)year;

/**
 获取本月的每天对应的农历叫法
 @param year 年
 @param month 月
 @return 叫法数组
 */
- (NSArray *)chinaCalledAtYear:(NSInteger)year inMonth:(NSInteger)month;

- (NSString *)getCalledAtYear:(NSInteger)year inMonth:(NSInteger)month inDay:(NSInteger)day;

@end
