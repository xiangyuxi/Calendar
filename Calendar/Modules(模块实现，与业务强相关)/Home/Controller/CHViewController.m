//
//  CHViewController.m
//  Calendar
//
//  Created by yxiang on 2017/5/3.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CHViewController.h"
#import "CDatePickerView.h"
#import "CNAddViewController.h"

@interface CHViewController () /** <UITableViewDelegate, UITableViewDataSource>*/

@property (weak, nonatomic) IBOutlet UIButton *showMoreButton;
@property (weak, nonatomic) IBOutlet UICountingLabel *countingLabel;

@property (weak, nonatomic) IBOutlet UILabel *incomeTitleLabel;
@property (weak, nonatomic) IBOutlet UICountingLabel *incomeMoneyLabel;

@end

@implementation CHViewController

#pragma mark - Properties

- (void)setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    NSString *dateString = [NSDate converDate:_currentDate toStringWithFormatter:@"yyyy-MM-dd"];
    NSArray *dateArray = [dateString componentsSeparatedByString:@"-"];
    self.year = [dateArray[0] integerValue];
    self.month = [dateArray[1] integerValue];
    self.day = [dateArray[2] integerValue];
    [self updateUIElements];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentDate = [NSDate date];
    
    self.countingLabel.format = @"%.2f";
    self.countingLabel.positiveFormat = @"###,##0.00";
    
    self.incomeMoneyLabel.format = @"%.2f";
    self.incomeMoneyLabel.positiveFormat = @"###,##0.00";
    
    [self makeViewInWaterWaView];
    
    [self.view bringSubviewToFront:self.incomeTitleLabel];
    [self.view bringSubviewToFront:self.incomeMoneyLabel];
    
    [self makeShowMoreButtonShadow];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.countingLabel countFromCurrentValueTo:8789.00];
    [self.incomeMoneyLabel countFromCurrentValueTo:6789.89];
    
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.waveDisplayLink invalidate];
    self.waveDisplayLink = nil;
}

#pragma mark - private

- (void)updateUIElements {
    self.title = [NSString stringWithFormat:@"%lu年%lu月",self.year,self.month];
}

- (void)makeShowMoreButtonShadow {
    self.showMoreButton.cornerRadius = 25;
    self.showMoreButton.layer.shadowRadius = 25;
    self.showMoreButton.layer.shadowColor = [UIColor colorWithHex:0x3DA1FF].CGColor;
    self.showMoreButton.layer.shadowOpacity = 0.8;
    self.showMoreButton.layer.shadowOffset = CGSizeMake(0, 30);
    
    [self.view bringSubviewToFront:self.showMoreButton];
}

- (void)makeViewInWaterWaView {
    
    self.offsetX =
    self.offsetXT= kScrWidth/0.8;
    self.waveSpeed = 2; // 水波速度
    self.waveWidth = kScrWidth; // 水波长度（直线）
    self.waveHeight = kScrHeight/2.5; // x轴
    self.waveAmplitude = 10; // 振幅
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = @[(__bridge id)[UIColor colorWithHex:0xC9E4FF alpha:0.05].CGColor,(__bridge id)[UIColor colorWithHex:0x3DA1FF alpha:0.95].CGColor];
    gradient.frame = CGRectMake(0, 0, kScrWidth, kScrHeight);
    [self.view.layer addSublayer:gradient];
    
    self.waveShapeLayer = [CAShapeLayer layer];
    self.waveShapeLayer.fillColor = [UIColor redColor].CGColor;
    gradient.mask = self.waveShapeLayer;
    
    CAGradientLayer *gradientT = [CAGradientLayer layer];
    gradientT.colors = @[(__bridge id)[UIColor colorWithHex:0xC9E4FF alpha:0.05].CGColor,(__bridge id)[UIColor colorWithHex:0x9DCEFF alpha:0.95].CGColor];
    gradientT.frame = CGRectMake(0, 0, kScrWidth, kScrHeight);
    [self.view.layer addSublayer:gradientT];

    self.waveShapeLayerT = [CAShapeLayer layer];
    self.waveShapeLayerT.fillColor = [UIColor redColor].CGColor;
    gradientT.mask = self.waveShapeLayerT;
}


#pragma mark - Actions

- (IBAction)addActioin:(id)sender {
    [self performSegueWithIdentifier:@"addNew" sender:nil];
}
- (IBAction)menuAction:(id)sender {
}

- (void)getCurrentWave {
    //offsetX决定x位置，如果想搞明白可以多试几次
    self.offsetX += self.waveSpeed;
    //声明第一条波曲线的路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始点
    CGPathMoveToPoint(path, nil, 0, self.waveHeight);
    
    CGFloat y = 0.f;
    //第一个波纹的公式
    for (float x = 0.f; x <= self.waveWidth ; x++) {
        y = self.waveAmplitude * sin((300 / self.waveWidth) * (x * M_PI / 180) - self.offsetX * M_PI / 270) + self.waveHeight*1;
        CGPathAddLineToPoint(path, nil, x, y);
        x++;
    }
    //把绘图信息添加到路径里
    CGPathAddLineToPoint(path, nil, self.waveWidth, CGRectGetHeight(self.view.frame));
    CGPathAddLineToPoint(path, nil, 0, CGRectGetHeight(self.view.frame));
    //结束绘图信息
    CGPathCloseSubpath(path);
    
    self.waveShapeLayer.path = path;
    //释放绘图路径
    CGPathRelease(path);
    
    self.offsetXT += self.waveSpeed;
    CGMutablePathRef pathT = CGPathCreateMutable();
    CGPathMoveToPoint(pathT, nil, 0, self.waveHeight+100);
    
    CGFloat yT = 0.f;
    for (float x = 0.f; x <= self.waveWidth ; x++) {
        yT = self.waveAmplitude*1.6 * sin((260 / self.waveWidth) * (x * M_PI / 180) - self.offsetXT * M_PI / 180) + self.waveHeight;
        CGPathAddLineToPoint(pathT, nil, x, yT-10);
    }
    CGPathAddLineToPoint(pathT, nil, self.waveWidth, CGRectGetHeight(self.view.frame));
    CGPathAddLineToPoint(pathT, nil, 0, CGRectGetHeight(self.view.frame));
    CGPathCloseSubpath(pathT);
    self.waveShapeLayerT.path = pathT;
    CGPathRelease(pathT);
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addNew"]) {
        CNAddViewController *vc = segue.destinationViewController;
        vc.dateArray = @[@(self.year),@(self.month),@(self.day)];
    }
}

/*
#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 55) {
        if (self.menuButton.currentButtonType != buttonAddType) {
            [self.menuButton animateToType:buttonAddType];
        }
    }else {
        if (self.menuButton.currentButtonType == buttonAddType) {
            [self.menuButton animateToType:buttonMenuType];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath { return 104; }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section { return 10; }

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:weatherIdentifer forIndexPath:indexPath];
    cell.date = self.currentDate;
    cell.delegate = self;
    return cell;
}
 */

@end
