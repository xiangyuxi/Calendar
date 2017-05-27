//
//  CNViewController.h
//  Calendar
//
//  Created by yxiang on 2017/5/9.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNCellModel : NSObject

@property(copy, nonatomic) NSDate *date;
@property(copy, nonatomic) NSString *title;

@end

@interface CNViewController : UIViewController

@end
