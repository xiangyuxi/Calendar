//
//  CHViewController.m
//  Calendar
//
//  Created by yxiang on 2017/5/3.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CHViewController.h"
#import "CMonthView.h"
#import "CTools.h"
#import "CWeatherCell.h"
#import "CWeatherModel.h"
#import "CDatePickerView.h"

static NSString *weatherIdentifer = @"weather";

@interface CHViewController () <CMonthViewDelegate, CWeatherCellDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) CMonthView *monthView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstriant;
@property (weak, nonatomic) IBOutlet UIButton *yearMonthBtn;
@property (copy, nonatomic) VBFPopFlatButton *menuButton;

@property (assign, nonatomic) NSInteger year;
@property (assign, nonatomic) NSInteger month;
@property (assign, nonatomic) NSInteger day;

@property (strong, nonatomic) CWeatherModel *cwModel;

@property (weak, nonatomic) IBOutlet UIView *homeNavgationBar;

@end

@implementation CHViewController

#pragma mark - Properties

- (VBFPopFlatButton *)menuButton {
    if (!_menuButton) {
        _menuButton = [[VBFPopFlatButton alloc] initWithFrame:CGRectMake(kScrWidth-39, 30, 24, 24)
                                                   buttonType:buttonMenuType
                                                  buttonStyle:buttonPlainStyle
                                        animateToInitialState:NO];
        [self.homeNavgationBar addSubview:_menuButton];
    }
    return _menuButton;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self.menuButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(VBFPopFlatButton *sender) {
        if (sender.currentButtonType == buttonAddType) {
            NSLog(@"add");
        }else if (sender.currentButtonType == buttonMenuType) {
            NSLog(@"menu");
        }
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSArray *cArray = [[CTools sharedCTools] currentDay];
    self.year = [cArray.firstObject integerValue];
    self.month = [cArray[1] integerValue];
    self.day = [cArray[2] integerValue];
    
    if (!_cwModel)
        _cwModel = [CWeatherModel new];
    [_cwModel updateWeatherWithYear:self.year inMonth:self.month atDay:self.day];
    
    CMonthView *monthView = [CMonthView loadInstanceFromNib];
    [self.view addSubview:monthView];
    monthView.delegate = self;
    self.monthView = monthView;
    
    [self updateUIElements];
}

- (void)updateUIElements
{
    [self.yearMonthBtn setTitle:[NSString stringWithFormat:@"%lu年%lu月",self.year,self.month] forState:UIControlStateNormal];
    [self.monthView updateUIElementsWithYear:self.year atMonth:self.month atDay:self.day];
}

- (IBAction)yearMonthAction:(UIButton *)sender
{
    CDatePickerView *pickerView = [CDatePickerView loadInstanceFromNibWithSelectedBlock:^(NSDate *date) {
        NSString *fmt = [date convertToStringWithFormatter:@"yyyy/MM/dd"];
        NSArray *fmtArray = [fmt componentsSeparatedByString:@"/"];
        
        self.year = [fmtArray[0] integerValue];
        self.month = [fmtArray[1] integerValue];
        self.day = [fmtArray[2] integerValue];
        
        [self cmonthView:self.monthView didItemSelected:fmtArray[2] withTouchCount:1];
        
        [self updateUIElements];
    }];
    pickerView.type = CDatePickerTypeDate;
    [pickerView showDatePickerView];
}

#pragma mark - CMonthViewDelegate

- (void)cmonthView:(CMonthView *)aView didLayoutSubview:(CGRect)rect
{
    self.monthView.frame = CGRectMake(0, 64, kScrWidth, rect.size.height);
    self.topConstriant.constant = rect.size.height;
}

- (void)cmonthView:(CMonthView *)aView didItemSelected:(NSString *)dayString withTouchCount:(NSInteger)count
{
    if (count == 1) {
        [_cwModel updateWeatherWithYear:self.year inMonth:self.month atDay:[dayString integerValue]];
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"presentNew"]) {
        UINavigationController *vc = segue.destinationViewController;
        vc.viewControllers.firstObject.title = [NSString stringWithFormat:@"%ld-%ld-%@",self.year,self.month,_cwModel.day];
    }
}

#pragma mark - CWeatherCellDelegate

- (void)cweatherCellAddBtnDidTouchupInside:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"presentNew" sender:nil];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:weatherIdentifer forIndexPath:indexPath];
    cell.cwModel = self.cwModel;
    cell.delegate = self;
    return cell;
}

@end
