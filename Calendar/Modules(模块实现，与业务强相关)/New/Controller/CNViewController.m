//
//  CNViewController.m
//  Calendar
//
//  Created by yxiang on 2017/5/9.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CNViewController.h"
#import "CNEditViewController.h"
#import "CNTimeCell.h"
#import "CNTitleCell.h"
#import "CDatePickerView.h"
#import "CNCellModel.h"

static NSString *timeCellIdentifier = @"time";
static NSString *titleCellIdentifier = @"title";

@interface CNViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *titleBtn;

@property (nonatomic, copy) NSArray *dateArray; // [year,month,day]

@property (copy, nonatomic) VBFPopFlatButton *menuButton;

@property (weak, nonatomic) IBOutlet UIView *cnewNavigationBar;

@property (strong, nonatomic) CNCellModel *model;

@end

@implementation CNViewController {
    NSDate *_cacheDate;
}

#pragma mark - Properties

- (VBFPopFlatButton *)menuButton {
    if (!_menuButton) {
        _menuButton = [[VBFPopFlatButton alloc] initWithFrame:CGRectMake(kScrWidth-39, 30, 24, 24)
                                                   buttonType:buttonCloseType
                                                  buttonStyle:buttonPlainStyle
                                        animateToInitialState:NO];
        [self.cnewNavigationBar addSubview:_menuButton];
    }
    return _menuButton;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [CNCellModel new];
    self.model.date =
    _cacheDate = [NSDate date];
    
    self.dateArray = [self.title componentsSeparatedByString:@"-"];
    [self.titleBtn setTitle:[self _titleBtnTitle] forState:UIControlStateNormal];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[self.menuButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(VBFPopFlatButton *sender) {
        if (sender.currentButtonType == buttonOkType) {
            
        }else if (sender.currentButtonType == buttonCloseType) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [[RACSignal combineLatest:@[RACObserve(self, model.title)]] subscribeNext:^(NSArray *x) {
        if (((NSString *)x[0]).length > 0) {
            [self.menuButton animateToType:buttonOkType];
        }else {
            [self.menuButton animateToType:buttonCloseType];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CNEditViewController *editController = segue.destinationViewController;
    editController.defaultString = self.model.title;
    @weakify(self)
    editController.titleDidChangedBlock = ^(NSString *text) {
        @strongify(self)
        self.model.title = text;
    };
}

#pragma mark - Private

- (NSString *)_titleBtnTitle {
    return [NSString stringWithFormat:@"%@年%@月%@日",self.dateArray[0],self.dateArray[1],self.dateArray[2]];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        @weakify(self)
        CDatePickerView *dateView = [CDatePickerView loadInstanceFromNibWithSelectedBlock:^(NSDate *date) {
            @strongify(self)
            self.model.date = date;
        }];
        dateView.type = CDatePickerTypeTime;
        [dateView showDatePickerView];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        [self performSegueWithIdentifier:@"edit" sender:nil];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CNTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:timeCellIdentifier forIndexPath:indexPath];
        cell.model = self.model;
        return cell;
    }else {
        CNTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCellIdentifier forIndexPath:indexPath];
        cell.model = self.model;
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   return @"基础信息";
}

@end
