//
//  CHViewController.h
//  Calendar
//
//  Created by yxiang on 2017/5/3.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CBaseViewController.h"

@interface CHViewController : CBaseViewController

#pragma mark - Water wave

@property (assign, nonatomic) CGFloat waveHeight;
@property (assign, nonatomic) CGFloat waveWidth;
@property (assign, nonatomic) CGFloat waveAmplitude;
@property (strong, nonatomic) CAShapeLayer *waveShapeLayer;
@property (assign, nonatomic) CGFloat offsetX;
@property (assign, nonatomic) CGFloat waveSpeed;
@property (strong, nonatomic) CAShapeLayer *waveShapeLayerT;
@property (assign, nonatomic) CGFloat offsetXT;
@property (strong, nonatomic) CADisplayLink *waveDisplayLink;

#pragma mark - Navigation item

#pragma mark - Date

@property (copy, nonatomic) NSDate *currentDate;
@property (assign, nonatomic) NSInteger year;
@property (assign, nonatomic) NSInteger month;
@property (assign, nonatomic) NSInteger day;

@end
