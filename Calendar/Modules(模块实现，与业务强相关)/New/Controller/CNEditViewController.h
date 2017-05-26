//
//  CNEditViewController.h
//  Calendar
//
//  Created by yxiang on 2017/5/9.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNEditViewController : UIViewController

@property (copy, nonatomic) NSString *defaultString;
@property (copy, nonatomic) void (^titleDidChangedBlock) (NSString *text);

@end
