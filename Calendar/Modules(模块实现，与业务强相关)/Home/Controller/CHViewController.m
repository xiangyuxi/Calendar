//
//  CHViewController.m
//  Calendar
//
//  Created by yxiang on 2017/5/3.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CHViewController.h"
#import "CWeatherCell.h"
#import "CDatePickerView.h"
#import "CNAddViewController.h"

static NSString *weatherIdentifer = @"weather";

@interface CHViewController () <UITableViewDelegate, UITableViewDataSource, CWeatherCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *yearMonthBtn;
@property (weak, nonatomic) IBOutlet UIView *homeNavgationBar;
@property (weak, nonatomic) IBOutlet UIView *waterWaveView;
@property (weak, nonatomic) IBOutlet UILabel *staticLabel;

@property (assign, nonatomic) CGFloat waveHeight;
@property (assign, nonatomic) CGFloat waveWidth;
@property (assign, nonatomic) CGFloat waveAmplitude;
@property (strong, nonatomic) CAShapeLayer *waveShapeLayer;
@property (assign, nonatomic) CGFloat offsetX;
@property (assign, nonatomic) CGFloat waveSpeed;
@property (strong, nonatomic) CAShapeLayer *waveShapeLayerT;
@property (assign, nonatomic) CGFloat offsetXT;
@property (strong, nonatomic) CADisplayLink *waveDisplayLink;

@property (copy, nonatomic) VBFPopFlatButton *menuButton;

@property (copy, nonatomic) NSDate *currentDate;
@property (assign, nonatomic) NSInteger year;
@property (assign, nonatomic) NSInteger month;
@property (assign, nonatomic) NSInteger day;

@property (copy, nonatomic) UICountingLabel *countingLabel;

@end

@implementation CHViewController

#pragma mark - Properties

- (UICountingLabel *)countingLabel {
    if (!_countingLabel) {
        _countingLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(0, 30, kScrWidth, 50)];
        _countingLabel.font = [UIFont boldSystemFontOfSize:40];
        _countingLabel.textAlignment = NSTextAlignmentCenter;
        _countingLabel.textColor = [UIColor colorWithHex:0x3DA1FF];
        _countingLabel.format = @"%.2f";
        _countingLabel.positiveFormat = @"###,##0.00";
        [self.waterWaveView addSubview:_countingLabel];
    }
    return _countingLabel;
}

- (VBFPopFlatButton *)menuButton {
    if (!_menuButton) {
        _menuButton = [[VBFPopFlatButton alloc] initWithFrame:CGRectMake(kScrWidth-39, 30, 24, 24)
                                                   buttonType:buttonMenuType
                                                  buttonStyle:buttonPlainStyle
                                        animateToInitialState:NO];
        _menuButton.tintColor = [UIColor colorWithHex:0x3DA1FF];
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

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.countingLabel.text = @"0.00";
    
    self.currentDate = [NSDate date];
    
    [[self.menuButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(VBFPopFlatButton *sender) {
        if (sender.currentButtonType == buttonAddType) {
            NSLog(@"add");
        }else if (sender.currentButtonType == buttonMenuType) {
            NSLog(@"menu");
        }
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self wave];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    
    /*
     *CADisplayLink是一个能让我们以和屏幕刷新率相同的频率将内容画到屏幕上的定时器。我们在应用中创建一个新的 CADisplayLink 对象，把它添加到一个runloop中，并给它提供一个 target 和selector 在屏幕刷新的时候调用。
     */
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.countingLabel countFromCurrentValueTo:-3048.64];
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

- (void)wave {
    /*
     *创建两个layer
     */
    
    self.offsetX =
    self.offsetXT= 80;
    self.waveSpeed = 0.5; // 水波速度
    self.waveWidth = kScrWidth; // 水波长度（直线）
    self.waveHeight = 55; // x轴
    self.waveAmplitude = 8; // 振幅
    
    self.waveShapeLayer = [CAShapeLayer layer];
    self.waveShapeLayer.fillColor = [UIColor colorWithRed:157/255.0 green:206/255.0 blue:1 alpha:0.6].CGColor;
    [self.waterWaveView.layer addSublayer:self.waveShapeLayer];
    
    self.waveShapeLayerT = [CAShapeLayer layer];
    self.waveShapeLayerT.fillColor = [UIColor colorWithRed:201/255.0 green:228/255.0 blue:1 alpha:0.6].CGColor;
    [self.waterWaveView.layer addSublayer:self.waveShapeLayerT];
    
    [self.waterWaveView bringSubviewToFront:self.countingLabel];
    [self.waterWaveView bringSubviewToFront:self.staticLabel];
}

#pragma mark - Actions

//CADispayLink相当于一个定时器 会一直绘制曲线波纹 看似在运动，其实是一直在绘画不同位置点的余弦函数曲线
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
    
    /*
     *  第二个
     */
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

#pragma mark - CWeatherCellDelegate

- (void)cweatherCellAddBtnDidTouchupInside:(UIButton *)sender {
    [self performSegueWithIdentifier:@"addNew" sender:nil];
}

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

@end
