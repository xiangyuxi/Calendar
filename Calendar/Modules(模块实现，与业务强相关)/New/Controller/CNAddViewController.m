//
//  CNAddViewController.m
//  Calendar
//
//  Created by xiangyuxi on 2017/5/29.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CNAddViewController.h"
#import "SegmentControl.h"
#import "CNIncomeView.h"

@interface CNAddViewController () <SegmentedControlDelegate>

@property (strong, nonatomic) CNIncomeView *incomeView;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation CNAddViewController

#pragma mark - Properties

- (CNIncomeView *)incomeView {
    if (!_incomeView) {
        _incomeView = [CNIncomeView loadInstanceFromNib];
        _incomeView.frame = CGRectMake(0, 64, kScrWidth, kScrHeight-64-20-50-10);
    }
    return _incomeView;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SegmentControl *sc = [[SegmentControl alloc] initWithFrame:CGRectMake(0, 0, 130, 40)];
    [sc setSegmentItems:@[@"支出",@"收入"]];
    sc.delegate = self;
    self.navigationItem.titleView = sc;
    
    [self.view addSubview:self.incomeView];
    
    [self _makeShowMoreButtonShadow];
    
}

#pragma mark - Actions

#pragma mark - Pravite

- (void)_makeShowMoreButtonShadow {
    self.saveButton.cornerRadius = 4.f;
    self.saveButton.layer.shadowRadius = 4.f;
    self.saveButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.saveButton.layer.shadowOpacity = 0.6;
    self.saveButton.layer.shadowOffset = CGSizeMake(0, 5);
    
    [self.view bringSubviewToFront:self.saveButton];
}

#pragma mark - SegmentedControlDelegate

- (void)segmentControl:(SegmentControl *)segment didSelected:(NSInteger)index {
    NSLog(@"%ld",index);
    [self.view endEditing:YES];
}

@end
