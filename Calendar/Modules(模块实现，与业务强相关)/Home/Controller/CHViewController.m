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

@interface CHViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CHViewController

#pragma mark - Properties

- (VBFPopFlatButton *)menuButton {
    if (!_menuButton) {
        _menuButton = [[VBFPopFlatButton alloc] initWithFrame:CGRectMake(10, 30, 24, 24)
                                                   buttonType:buttonMenuType
                                                  buttonStyle:buttonPlainStyle
                                        animateToInitialState:NO];
        _menuButton.tintColor = [UIColor colorWithHex:0x00A6F3];
        [self.homeNavgationBar addSubview:_menuButton];
    }
    return _menuButton;
}

- (void)setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    NSString *dateString = [NSDate converDate:_currentDate toStringWithFormatter:@"yyyy-MM-dd"];
    NSArray *dateArray = [dateString componentsSeparatedByString:@"-"];
    self.year = [dateArray[0] integerValue];
    self.month = [dateArray[1] integerValue];
    self.day = [dateArray[2] integerValue];
    [self updateUIElements];
}

- (void)setIncomeString:(NSString *)incomeString {
    if (![_incomeString isEqualToString:incomeString]) {
        _incomeString = incomeString;
        [self updateCountingLabelText];
    }
}

- (void)setPayString:(NSString *)payString {
    if (![_payString isEqualToString:payString]) {
        _payString = payString;
        [self updateCountingLabelText];
    }
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.payLabel.format =
    self.incomeLabel.format =
    self.countingLabel.format = @"%.2f";
    
    self.payLabel.positiveFormat =
    self.incomeLabel.positiveFormat =
    self.countingLabel.positiveFormat = @"###,##0.00";
    
    self.payLabel.method =
    self.incomeLabel.method =
    self.countingLabel.method = UILabelCountingMethodEaseInOut;
    
    self.currentDate = [NSDate date];
    
    [[self.menuButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(VBFPopFlatButton *sender) {
        if (sender.currentButtonType == buttonAddType) {
            NSLog(@"add");
        }else if (sender.currentButtonType == buttonMenuType) {
            NSLog(@"menu");
        }
    }];
    
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    
    [self makeViewInWaterWaView];
    
    [self bringViewToFront];
    
    [self makeCornerRadius];
    
    [self makeGradientWithinAddView];
    
//    [self makeShadowWithinTopView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.payString = @"5481.56";
    self.incomeString = @"7421.64";
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.waveDisplayLink invalidate];
    self.waveDisplayLink = nil;
}

#pragma mark - private

- (void)updateUIElements {
    [self.yearMonthBtn setTitle:[NSString stringWithFormat:@"%lu年%lu月",self.year,self.month] forState:UIControlStateNormal];
}

- (void)updateCountingLabelText {
    [self.payLabel countFromCurrentValueTo:[_payString floatValue]];
    [self.incomeLabel countFromCurrentValueTo:[_incomeString floatValue]];
    [self.countingLabel countFromCurrentValueTo:[_incomeString floatValue]-[_payString floatValue]];
}

- (void)bringViewToFront {
    [self.waterWaveView bringSubviewToFront:self.countingLabel];
    [self.waterWaveView bringSubviewToFront:self.staticLabel];
    [self.waterWaveView bringSubviewToFront:self.payView];
    [self.waterWaveView bringSubviewToFront:self.incomeView];
}

- (void)makeCornerRadius {
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 75, 32)
                                                  byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                        cornerRadii:CGSizeMake(16, 16)];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.payView.layer.mask = shape;
    
    rounded = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 75, 32)
                                    byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                          cornerRadii:CGSizeMake(16, 16)];
    shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.incomeView.layer.mask = shape;
}

- (void)makeViewInWaterWaView {
    self.offsetX =
    self.offsetXT= 80;
    self.waveSpeed = 2; // 水波速度
    self.waveWidth = kScrWidth; // 水波长度（直线）
    self.waveHeight = 55; // x轴
    self.waveAmplitude = 15; // 振幅
    
    self.waveShapeLayer = [CAShapeLayer layer];
    self.waveShapeLayer.fillColor = [UIColor colorWithHex:0x1580E2 alpha:0.1].CGColor;
    [self.waterWaveView.layer addSublayer:self.waveShapeLayer];
    
    self.waveShapeLayerT = [CAShapeLayer layer];
    self.waveShapeLayerT.fillColor = [UIColor colorWithHex:0x1580E2 alpha:0.1].CGColor;
    [self.waterWaveView.layer addSublayer:self.waveShapeLayerT];
}

- (void)makeGradientWithinAddView {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.addView.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHex:0xffffff alpha:0].CGColor,(__bridge id)[UIColor colorWithHex:0xffffff].CGColor];
    [self.addView.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)makeShadowWithinTopView {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 184, kScrWidth, 5);
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHex:0x333333 alpha:0.2].CGColor,(__bridge id)[UIColor colorWithHex:0x333333 alpha:0].CGColor];
    [self.view.layer addSublayer:gradientLayer];
}

#pragma mark - Actions

- (IBAction)addNewAction:(id)sender {
    [self performSegueWithIdentifier:@"addNew" sender:nil];
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
    CGPathAddLineToPoint(path, nil, self.waveWidth, CGRectGetHeight(self.waterWaveView.frame));
    CGPathAddLineToPoint(path, nil, 0, CGRectGetHeight(self.waterWaveView.frame));
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
    CGPathAddLineToPoint(pathT, nil, self.waveWidth, CGRectGetHeight(self.waterWaveView.frame));
    CGPathAddLineToPoint(pathT, nil, 0, CGRectGetHeight(self.waterWaveView.frame));
    CGPathCloseSubpath(pathT);
    self.waveShapeLayerT.path = pathT;
    CGPathRelease(pathT);
}

- (IBAction)yearMonthAction:(UIButton *)sender {
    CDatePickerView *pickerView = [CDatePickerView loadInstanceFromNibWithSelectedBlock:^(NSDate *date) {
        NSString *fmt = [date convertToStringWithFormatter:@"yyyy/MM/dd"];
        NSArray *fmtArray = [fmt componentsSeparatedByString:@"/"];
        
        self.year = [fmtArray[0] integerValue];
        self.month = [fmtArray[1] integerValue];
        self.day = [fmtArray[2] integerValue];
        
        [self updateUIElements];
    }];
    pickerView.type = CDatePickerTypeDate;
    [pickerView showDatePickerView];
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
