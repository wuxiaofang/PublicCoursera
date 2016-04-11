//
//  WXFBaseViewController.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFBaseViewController.h"

@interface WXFBaseViewController ()

@end

@implementation WXFBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor c_ffffff];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}



- (void)setCustomLabelForNavTitle:(NSString*)title
{
    UILabel* label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor c_323232];
    label.text = title;
    [label sizeToFit];
    label.frame = CGRectIntegral(label.frame);
    self.navigationItem.titleView = label;
}

- (void)showHud
{
 
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"Loading..."];
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];;
}

- (void)hiddenHud
{
    [SVProgressHUD dismiss];
}

- (void)showToastWithText:(NSString*)text
{
    [SVProgressHUD showSuccessWithStatus:text];
    [SVProgressHUD dismissWithDelay:1];
}

- (void)showSuccessToast
{
    [self showToastWithText:@"Success"];
}

- (void)showFailedToast
{
    [self showToastWithText:@"Failed"];
  
}

- (void)showLeftButtonWithTitle:(NSString *)title
{
    UIButton *button = [self createButtonWithTitle:title];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self
               action:@selector(backBarButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = barItem;
}

- (UIButton *)createButtonWithTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button sizeToFit];
    
    button.frame = CGRectIntegral(button.frame);
    return button;
}

- (void)showBackButton
{
    UIImage *image = [UIImage imageNamed:@"back_black"];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,44, 44)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self
               action:@selector(backBarButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void)backBarButtonPressed:(id)object
{

}

@end
