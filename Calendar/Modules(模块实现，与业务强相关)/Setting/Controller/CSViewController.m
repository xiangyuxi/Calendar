//
//  CSTableViewController.m
//  Calendar
//
//  Created by xiangyuxi on 2017/6/4.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CSViewController.h"

@interface CSViewController ()

@property (copy, nonatomic) NSArray *imageNames;

@property (copy, nonatomic) NSArray *cellTitles;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userSexImageView;
@property (weak, nonatomic) IBOutlet UILabel *userWorkLabel;
@property (weak, nonatomic) IBOutlet UILabel *userAgeLabel;

@end

@implementation CSViewController

#pragma mark - Properties

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageNames = @[@[@"changeUserInfo"],@[@"aboutUs",@"payForMe"],@[@"share",@"clear"],@[@"goOut"]];
    self.cellTitles = @[@[@"修改个人资料"],@[@"关于开发者",@"打赏开发者"],@[@"推荐App给好友",@"清除缓存"],@[@"退出登录"]];
    
    self.headerImageView.clipsToBounds = YES;
    self.headerImageView.cornerRadius = kScrWidth * 164 / 375 / 4;
}

#pragma mark - Private

#pragma mark - UITableViewDelegate

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
