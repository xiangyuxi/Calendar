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

@interface CNAddViewController () <SegmentedControlDelegate/*, UICollectionViewDelegate, UICollectionViewDataSource, YBPopupMenuDelegate*/>

@end

@implementation CNAddViewController

// static NSString *kPayTypeCellIdentifier = @"addTypeCell";

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.payTypeArray = @[@"现金",@"支付宝",@"微信",@"银行卡"];
    
//    self.payOutCollectionViewImageNames = @[@"餐饮",@"车贷",@"房贷",@"家具",@"交通费用",@"旅游",@"日常开支",@"信用卡还贷",@"娱乐休闲",@"衣服",@"医疗保健",@"运动",@"其他"];
    
    SegmentControl *sc = [[SegmentControl alloc] initWithFrame:CGRectMake(0, 0, 130, 40)];
    [sc setSegmentItems:@[@"支出",@"收入"]];
    sc.delegate = self;
    self.navigationItem.titleView = sc;
    
}

#pragma mark - Actions

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SegmentedControlDelegate

- (void)segmentControl:(SegmentControl *)segment didSelected:(NSInteger)index {
    NSLog(@"%ld",index);
}

/*
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
*/

@end
