//
//  WXFBaseViewController.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface WXFBaseViewController : UIViewController

- (void)setCustomLabelForNavTitle:(NSString*)title;


- (void)showHud;

- (void)hiddenHud;

- (void)showToastWithText:(NSString*)text;

- (void)showSuccessToast;

- (void)showFailedToast;

- (void)showBackButton;

- (void)showLeftButtonWithTitle:(NSString *)title;

- (void)backBarButtonPressed:(id)object;

@end
