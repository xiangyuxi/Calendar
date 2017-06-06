//
//  CSTableViewController.m
//  Calendar
//
//  Created by xiangyuxi on 2017/6/4.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CSViewController.h"
#import "CSectionView.h"

@interface CSViewController ()

@property (copy, nonatomic) NSArray *imageNames;

@property (copy, nonatomic) NSArray *cellTitles;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) CSectionView *sectionView;

@end

@implementation CSViewController

#pragma mark - Properties

- (CSectionView *)sectionView {
    if (!_sectionView) {
        _sectionView = [CSectionView loadInstanceFromNib];
        _sectionView.frame = CGRectMake(0, -kScrWidth * 164 / 375, kScrWidth,kScrWidth * 164 / 375);
        [self.tableView addSubview:_sectionView];
    }
    return _sectionView;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(CGRectGetHeight(self.sectionView.frame), 0, 0, 0);
    
    self.imageNames = @[@[@"changeUserInfo"],@[@"aboutUs",@"payForMe"],@[@"share",@"clear"],@[@"goOut"]];
    self.cellTitles = @[@[@"修改个人资料"],@[@"关于开发者",@"打赏开发者"],@[@"推荐App给好友",@"清除缓存"],@[@"退出登录"]];
}

#pragma mark - Private

#pragma mark - Actions

- (IBAction)cancelToBackAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y + kScrWidth * 164 / 375;
    CGFloat height = kScrWidth * 164 / 375;
    if (offsetY <= 0) {
        height -= offsetY;
    }
    _sectionView.frame = CGRectMake(0, offsetY-kScrWidth * 164 / 375, kScrWidth,height);

    NSLog(@"%f",offsetY);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section { return 0.0001f; }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return self.imageNames.count; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.imageNames[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:self.imageNames[indexPath.section][indexPath.row]];
    cell.textLabel.text = self.cellTitles[indexPath.section][indexPath.row];
    if (indexPath.section <= 2) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section == 2 && indexPath.row == 1) {
            cell.detailTextLabel.text = @"50M";
        }
    }
    return cell;
}

@end
