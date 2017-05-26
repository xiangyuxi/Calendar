//
//  CTools.m
//  Calendar
//
//  Created by yxiang on 2017/4/25.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CTools.h"

@implementation CTools

/* 多次调用NSCalendar初始化对象可能会造成性能问题 */
static NSCalendar *gregorianCalendar = nil; // 公历
static NSCalendar *chinaCalendar = nil; // 农历

static NSArray *week = nil; // 周
static NSArray *heavenlyDry = nil; // 天干
static NSArray *earthSupport = nil; // 地支
static NSArray *chineseMonths = nil; // 农历月
static NSArray *chineseDays = nil; // 农历日
static NSArray *lunarZodiac = nil; // 农历属性

// 得出Date对象
static NSDate *date_from_year_month(NSInteger year, NSInteger month)
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM";
    NSDate *newDate = [format dateFromString:[NSString stringWithFormat:@"%lu-%lu",(unsigned long)year,(unsigned long)month]];
    return newDate;
}

NSArray *weatherTypeString()
{
    return @[@"阴", @"晴", @"雨", @"雪", @"雾"];
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        chinaCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        week = @[@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
        heavenlyDry = @[@"甲", @"乙", @"丙", @"丁", @"戊", @"己", @"庚", @"辛", @"壬", @"癸"];
        earthSupport = @[@"子", @"丑", @"寅", @"卯", @"辰", @"巳", @"午", @"未", @"申", @"酉", @"戌", @"亥"];
        chineseMonths = [NSArray arrayWithObjects:@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月", nil];
        chineseDays = [NSArray arrayWithObjects:
                       @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                       @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                       @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",
                       nil];
        lunarZodiac = [NSArray arrayWithObjects:@"鼠年",@"牛年",@"虎年",@"兔年",@"龙年",@"蛇年",@"马年",@"羊年",@"猴年",@"鸡年",@"狗年",@"猪年",nil];
    });
}

gf_singleton_implementation(CTools)

- (NSInteger)totalDayAtYear:(NSInteger)year inMonth:(NSInteger)month
{
    if((month == 0)||(month == 1)||(month == 3)||(month == 5)||(month == 7)||(month == 8)||(month == 10)||(month == 12))
        return 31;
    if((month == 4)||(month == 6)||(month == 9)||(month == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
        return 28;
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}

- (NSInteger)firstDayisWeekAtYear:(NSInteger)year inMonth:(NSInteger)month
{
    // 获取第一天是星期几
    NSDateComponents *comps = [gregorianCalendar components:NSCalendarUnitWeekday fromDate:date_from_year_month(year, month)];
    return [comps weekday] - 1;
}

- (NSArray *)currentDay
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [format stringFromDate:[NSDate date]];
    return [dateStr componentsSeparatedByString:@"-"];
}

- (NSArray *)chinaFirstDayAtYear:(NSInteger)year inMonth:(NSInteger)month
{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger totalDay = [self totalDayAtYear:year inMonth:month]; // 本月总共天数
    NSDateComponents *toComp = [self getChineseCalendarWithDate:date_from_year_month(year, month)]; // 本月第一天的农历
    // 如果第一天是初一
    if (toComp.day == 1)
        [array addObject:@{@(0):@(toComp.month==1)}];
    
    if (month == 12)
    {
        month = 1;
        ++ year;
    }
    else
        ++ month;
    
    NSDateComponents *nextComp = [self getChineseCalendarWithDate:date_from_year_month(year, month)]; // 下月第一天的农历
    // 如果下月第一天也是初一，则直接返回
    if (nextComp.day == 1)
        return array.copy;
    [array addObject:@{@(totalDay-nextComp.day+2):@(nextComp.month==1)}];
    
    return array.copy;
}

- (NSDateComponents *)getChineseCalendarWithDate:(NSDate *)date
{
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *localeComp = [chinaCalendar components:unitFlags fromDate:date];
    return localeComp;
}

- (NSString *)chinaYearStringAtSolYear:(NSInteger)year
{
    // 2008年是鼠年
    NSString *lunarZodiacString = lunarZodiac[labs(year-2008)%12];
    NSString *hd = heavenlyDry[(year-4)%10];
    NSString *es = earthSupport[(year-4)%12];
    return [[hd stringByAppendingString:es] stringByAppendingString:lunarZodiacString];
}

- (NSArray *)chinaCalledAtYear:(NSInteger)year inMonth:(NSInteger)month
{
    NSInteger totalDay = [self totalDayAtYear:year inMonth:month]; // 本月总共天数
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:totalDay];
    for (int i = 1; i <= totalDay; ++ i) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"yyyy-MM-dd";
        NSDate *newDate = [format dateFromString:[NSString stringWithFormat:@"%lu-%lu-%d",(unsigned long)year,(unsigned long)month,i]];
        NSDateComponents *comp = [self getChineseCalendarWithDate:newDate];
        NSString *called = chineseDays[comp.day-1];
        if ([called isEqualToString:@"初一"]) {
            called = chineseMonths[comp.month-1];
        }
        [array addObject:called];
    }
    return array.copy;
}

- (NSString *)getCalledAtYear:(NSInteger)year inMonth:(NSInteger)month inDay:(NSInteger)day
{
    // 月份
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *newDate = [format dateFromString:[NSString stringWithFormat:@"%lu-%lu-%lu",(unsigned long)year,(unsigned long)month,day]];
    NSDateComponents *comp = [self getChineseCalendarWithDate:newDate];
    NSString *Cday = chineseDays[comp.day-1];
    NSString *Cmonth = chineseMonths[comp.month-1];
    NSDateComponents *comps = [gregorianCalendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *Cweek = week[comps.weekday-1];
    return [NSString stringWithFormat:@"%@   %@%@",Cweek,Cmonth,Cday];
}

@end
