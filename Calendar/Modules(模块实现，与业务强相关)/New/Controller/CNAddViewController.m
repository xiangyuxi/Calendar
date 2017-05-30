//
//  CNAddViewController.m
//  Calendar
//
//  Created by xiangyuxi on 2017/5/29.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CNAddViewController.h"
#import "SegmentControl.h"
#import "CNACollectionViewCell.h"
#import "CNAFlowLayout.h"
#import "YBPopupMenu.h"
#import "YBPTableViewCell.h"

@interface CNAddViewController () <SegmentedControlDelegate, UICollectionViewDelegate, UICollectionViewDataSource, YBPopupMenuDelegate>

@property (weak, nonatomic) IBOutlet UIView *addNavigationBar;
@property (weak, nonatomic) IBOutlet UIView *moneyInputView;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UIView *saveView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *payTypeButton;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIView *textInputView;

@property (copy, nonatomic) NSArray *payOutCollectionViewImageNames;
@property (assign, nonatomic) NSInteger paySelectedFlag;
@property (copy, nonatomic) NSArray *payTypeArray;
@property (strong, nonatomic) JVFloatLabeledTextView *textView;

@end

@implementation CNAddViewController

static NSString *kPayTypeCellIdentifier = @"addTypeCell";

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.payTypeArray = @[@"现金",@"支付宝",@"微信",@"银行卡"];
    
    self.textView = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(0, 5, kScrWidth-20, 135)];
    self.textView.placeholder = @"请输入详细信息";
    self.textView.font = [UIFont systemFontOfSize:15];
    [self.textInputView addSubview:self.textView];
    
    self.payOutCollectionViewImageNames = @[@"餐饮",@"车贷",@"房贷",@"家具",@"交通费用",@"旅游",@"日常开支",@"信用卡还贷",@"娱乐休闲",@"衣服",@"医疗保健",@"运动",@"其他"];
    self.paySelectedFlag = 0;
    
    self.collectionView.collectionViewLayout = [[CNAFlowLayout alloc] init];
    
    SegmentControl *sc = [[SegmentControl alloc] initWithFrame:CGRectMake(kScrWidth/2-80, 21.5, 160, 40)];
    [sc setSegmentItems:@[@"支出",@"收入"]];
    sc.delegate = self;
    [self.addNavigationBar addSubview:sc];
    
    self.saveView.layer.cornerRadius =
    self.saveView.layer.shadowRadius =
    self.moneyInputView.layer.cornerRadius =
    self.moneyInputView.layer.shadowRadius = 4.f;
    
    self.saveView.layer.shadowColor =
    self.moneyInputView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    
    self.saveView.layer.shadowOpacity =
    self.moneyInputView.layer.shadowOpacity = 0.6;
    
    self.saveView.layer.shadowOffset = CGSizeMake(0, 7);
    self.moneyInputView.layer.shadowOffset = CGSizeZero;
    
    self.collectionView.clipsToBounds = NO;
    
}

#pragma mark - Actions

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)payTypeAction:(UIButton *)sender {
    CGPoint point = CGPointMake(33, 122);
    YBPopupMenu *popup = [YBPopupMenu showAtPoint:point titles:self.payTypeArray icons:self.payTypeArray menuWidth:kScrWidth-20 delegate:self];
    popup.cornerRadius = 4.f;
    [popup.tableView registerNib:[YBPTableViewCell loadNib] forCellReuseIdentifier:@"YBPTableViewCell"];
    [UIView animateWithDuration:0.3 animations:^{
        self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

#pragma mark - YBPopupMenuDelegate

- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu {
    [self.payTypeButton setImage:[UIImage imageNamed:self.payTypeArray[index]] forState:UIControlStateNormal];
}

- (void)ybPopupMenuBeganDismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.arrowImageView.transform = CGAffineTransformIdentity;
    }];
}

- (UITableViewCell *)ybPopupMenuWithTableView:(UITableView *)tableView image:(UIImage *)image title:(NSString *)title {
    YBPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBPTableViewCell"];
    cell.imageView.image = image;
    cell.titleLabel.text = title;
    return cell;
}

#pragma mark - SegmentedControlDelegate

- (void)segmentControl:(SegmentControl *)segment didSelected:(NSInteger)index {
    NSLog(@"%ld",index);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.payOutCollectionViewImageNames.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CNACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPayTypeCellIdentifier forIndexPath:indexPath];
    NSString *imageName = self.payOutCollectionViewImageNames[indexPath.row];
    BOOL isSelected = NO;
    cell.titleLabel.text = imageName;
    if (indexPath.row == self.paySelectedFlag) {
        imageName = [imageName stringByAppendingString:@"_s"];
        isSelected = YES;
    }
    cell.typeImageView.image = [UIImage imageNamed:imageName];
    cell.isSelected = isSelected;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.paySelectedFlag) {
        return;
    }
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.paySelectedFlag inSection:0];
    self.paySelectedFlag = indexPath.row;
    [self.collectionView reloadItemsAtIndexPaths:@[lastIndex,indexPath]];
}

@end
