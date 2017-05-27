//
//  CNEditViewController.m
//  Calendar
//
//  Created by yxiang on 2017/5/9.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "CNEditViewController.h"

@interface CNEditViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textField;

@property (copy, nonatomic) VBFPopFlatButton *menuButton;

@property (weak, nonatomic) IBOutlet UIView *editNavigationBar;

@end

@implementation CNEditViewController

#pragma mark - Properties

- (VBFPopFlatButton *)menuButton {
    if (!_menuButton) {
        _menuButton = [[VBFPopFlatButton alloc] initWithFrame:CGRectMake(15, 30, 24, 24)
                                                   buttonType:buttonBackType
                                                  buttonStyle:buttonPlainStyle
                                        animateToInitialState:NO];
        [self.editNavigationBar addSubview:_menuButton];
    }
    return _menuButton;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.textField becomeFirstResponder];
    self.textField.text = self.defaultString;
    self.textField.delegate = self;
    
    @weakify(self)
    [[self.menuButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(VBFPopFlatButton *sender) {
        @strongify(self)
        if (self.menuButton.currentButtonType == buttonOkType && self.titleDidChangedBlock) {
            
        }else {
            
        }
        self.titleDidChangedBlock(self.textField.text);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.textField.rac_textSignal subscribeNext:^(NSString *x) {
        if (x.length > 0) {
            if (self.menuButton.currentButtonType != buttonOkType) {
                [self.menuButton animateToType:buttonOkType];
            }
        }else {
            if (self.menuButton.currentButtonType == buttonOkType) {
                [self.menuButton animateToType:buttonBackType];
            }
        }
    }];
}

- (IBAction)backAction:(id)sender
{
    if (self.textField.text.length > 0 && self.titleDidChangedBlock) {
        self.titleDidChangedBlock(self.textField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *beString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([beString length] > 20) {
        textField.text = [beString substringToIndex:20];
        return NO;
    }
    return YES;
}

@end
