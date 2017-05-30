//
//  CNAFlowLayout.m
//  Calendar
//
//  Created by xiangyuxi on 2017/5/29.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CNAFlowLayout.h"

@implementation CNAFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(82, 64);
        self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        self.minimumInteritemSpacing = 15;
    }
    return self;
}

@end
