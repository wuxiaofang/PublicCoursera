//
//  WXFMainViewController.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFMainViewController.h"
#import "WXFFavoriteViewController.h"
#import "WXFCourseraListViewController.h"
#import "WXFCourseaDetailViewController.h"
#define kRightPadding        90

@interface WXFMainViewController ()

@property (nonatomic, strong) WXFFavoriteViewController* favoriteViewController;

@property (nonatomic, strong) WXFCourseraListViewController* courseraListViewController;

@property (nonatomic, strong) UIPanGestureRecognizer* panGestureRecognizer;

@property (nonatomic, assign) CGPoint panGesturePoint;

@property (nonatomic, strong) UIView* maskView;

@end

@implementation WXFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setCustomLabelForNavTitle:@"Coursera"];
    [self showLeftButtonWithTitle:@"Favorites"];
    
    [self addChildViewController:self.courseraListViewController];
    [self.view addSubview:self.courseraListViewController.view];
    
    [self.navigationController.view addSubview:self.favoriteViewController.view];
    self.favoriteViewController.view.frame = self.navigationController.view.bounds;
    self.favoriteViewController.view.v_left = - self.navigationController.view.v_width;
    __weak typeof(self)weakSelf = self;
    
    self.favoriteViewController.showCourseaDetailBlock = ^(WXFCourses* coursera){
        
        __strong typeof(self)strongSelf = weakSelf;
        
        [strongSelf hiddenFavoriteViewController:^(BOOL finished) {
            WXFCourseaDetailViewController* detail = [[WXFCourseaDetailViewController alloc] init];
            detail.courses = coursera;
            [strongSelf.navigationController pushViewController:detail animated:YES];
            
        }];
    };
    
    
    
}

- (void)backBarButtonPressed:(id)object
{
    [self showFavoriteViewController:^(BOOL finished) {
        [self.favoriteViewController loadFavoriteData];
    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addPanGestureRecognizer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removePanGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (WXFFavoriteViewController*)favoriteViewController
{
    if(_favoriteViewController == nil){
        _favoriteViewController = [[WXFFavoriteViewController alloc] init];
    }
    return _favoriteViewController;
}

- (WXFCourseraListViewController*)courseraListViewController
{
    if(_courseraListViewController == nil){
        _courseraListViewController = [[WXFCourseraListViewController alloc] init];
    }
    return _courseraListViewController;
}


#pragma mark - UISwipeGestureRecognizer

- (UIPanGestureRecognizer*)panGestureRecognizer
{
    if(_panGestureRecognizer == nil){
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchPanGestureRecognizer:)];
    }
    return _panGestureRecognizer;
}

- (void)addPanGestureRecognizer
{
    [self.navigationController.view addGestureRecognizer:self.panGestureRecognizer];
}

- (void)removePanGestureRecognizer
{
    [self.navigationController.view removeGestureRecognizer:self.panGestureRecognizer];
}

- (void)touchPanGestureRecognizer:(UIPanGestureRecognizer*)panGestureRecognizer
{
    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan){
        
        self.panGesturePoint = [panGestureRecognizer locationInView:self.view];
        
        
    }else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGPoint point = [panGestureRecognizer locationInView:self.view];
        self.favoriteViewController.view.v_left += point.x - self.panGesturePoint.x;
        if(self.favoriteViewController.view.v_left < -self.view.v_width){
            self.favoriteViewController.view.v_left = -self.view.v_width;
        }else if(self.favoriteViewController.view.v_left >  - kRightPadding){
            self.favoriteViewController.view.v_left =  - kRightPadding;
        }
        self.panGesturePoint = point;

        
    }else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded){
        
        
        [self userPanGestureRecognizerEnd:panGestureRecognizer];
        
    }else if(panGestureRecognizer.state == UIGestureRecognizerStateCancelled || panGestureRecognizer.state == UIGestureRecognizerStateFailed){

        [self userPanGestureRecognizerEnd:panGestureRecognizer];
        
    }

}

- (void)userPanGestureRecognizerEnd:(UIPanGestureRecognizer*)panGestureRecognizer
{
    CGPoint point = [panGestureRecognizer velocityInView:self.view];
    
    CGFloat f_left = 0;
    CGFloat moveDistance = 0;
    if(self.favoriteViewController.view.v_left <  - (kRightPadding + self.view.v_width)/2){
        f_left = -self.view.v_width;
        moveDistance = fabs(self.favoriteViewController.view.v_left - -self.view.v_width);
    }else{
        f_left = -kRightPadding;
        moveDistance = fabs(-kRightPadding - self.favoriteViewController.view.v_left);
    }
    
    CGFloat animateTime = moveDistance / fabs(point.x);
    
    if(animateTime > 0.5){
        animateTime = 0.5;
    }
    if(f_left == -kRightPadding){
        [self.maskView removeFromSuperview];
        [self.navigationController.view insertSubview:self.maskView belowSubview:self.favoriteViewController.view];
    }

    [UIView animateWithDuration:animateTime animations:^{
        self.favoriteViewController.view.v_left = f_left;
        if(f_left == -kRightPadding){
            self.maskView.alpha = 0.4;
        }else{
            self.maskView.alpha = 0;
        }
    } completion:^(BOOL finished) {
        if(f_left == -kRightPadding){
            [self.favoriteViewController loadFavoriteData];
        }else{
            [self.maskView removeFromSuperview];
            
        }
    }];
}


- (UIView*)maskView
{
    if(_maskView == nil){
        _maskView = [[UIView alloc] init];
        _maskView.alpha = 0;
        _maskView.backgroundColor = [UIColor c_323232];
        _maskView.frame = self.navigationController.view.bounds;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskTapGestureRecognizer)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}
- (void)maskTapGestureRecognizer
{
    [self hiddenFavoriteViewController:nil];
}

- (void)showFavoriteViewController:(void (^ __nullable)(BOOL finished))completion
{

        [self.maskView removeFromSuperview];
        [self.navigationController.view insertSubview:self.maskView belowSubview:self.favoriteViewController.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.favoriteViewController.view.v_left = -kRightPadding;
        self.maskView.alpha = 0.4;
  
    } completion:^(BOOL finished) {
        if(completion){
            completion(finished);
        }
    }];
}

- (void)hiddenFavoriteViewController:(void (^ __nullable)(BOOL finished))completion
{
    [UIView animateWithDuration:0.3 animations:^{
        self.favoriteViewController.view.v_left = -self.view.v_width;;
        self.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        if(completion){
            completion(finished);
        }
    }];
}

@end
