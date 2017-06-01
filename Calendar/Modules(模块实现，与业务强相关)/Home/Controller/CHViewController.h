//
//  CHViewController.h
//  Calendar
//
//  Created by yxiang on 2017/5/3.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CBaseViewController.h"

@interface CHViewController : CBaseViewController

#pragma mark - IBOutlet

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *yearMonthBtn;
@property (weak, nonatomic) IBOutlet UIView *homeNavgationBar;
@property (weak, nonatomic) IBOutlet UIView *waterWaveView;
@property (weak, nonatomic) IBOutlet UILabel *staticLabel;
@property (weak, nonatomic) IBOutlet UICountingLabel *countingLabel;
@property (weak, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UICountingLabel *payLabel;
@property (weak, nonatomic) IBOutlet UIView *incomeView;
@property (weak, nonatomic) IBOutlet UICountingLabel *incomeLabel;

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

@property (copy, nonatomic) VBFPopFlatButton *menuButton;

#pragma mark - Date

@property (copy, nonatomic) NSDate *currentDate;
@property (assign, nonatomic) NSInteger year;
@property (assign, nonatomic) NSInteger month;
@property (assign, nonatomic) NSInteger day;

#pragma mark - Counting

@property (copy, nonatomic) NSString *payString;
@property (copy, nonatomic) NSString *incomeString;

#pragma mark - Add

@property (weak, nonatomic) IBOutlet UIView *addView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end
