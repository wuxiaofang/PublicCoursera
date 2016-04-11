//
//  WXFFavoriteViewController.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFFavoriteViewController.h"
#import "MJRefreshNormalHeader.h"
#import "WXFFavoriteHandler.h"
#import "WXFFavoriteTableViewCell.h"
#define kRightPadding        90

@interface WXFFavoriteViewController ()

@property (nonatomic, strong) UILabel* titlelabel;

@property (nonatomic, strong) UIView* titleSeperateLine;

@end

@implementation WXFFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initListTableView];
    
    [self.view addSubview:self.listTableView];
    
    // 下拉刷新
    self.listTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self refreshTableView];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.titlelabel.v_left = kRightPadding + 10;
    self.titlelabel.v_top = 30;
    self.titleSeperateLine.v_left = kRightPadding;
    self.titleSeperateLine.v_top = self.titlelabel.v_bottom;
    self.titleSeperateLine.v_height = 0.5;
    self.titleSeperateLine.v_width = self.view.v_width - kRightPadding;
    
    self.listTableView.v_left =  kRightPadding;
    self.listTableView.v_top =  self.titleSeperateLine.v_bottom;
    self.listTableView.v_width = self.view.v_width - kRightPadding;
    self.listTableView.v_height = self.view.v_height - self.listTableView.v_top;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [WXFFavoriteHandler instance].courseraList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentify = @"WXFFavoriteTableViewCell";
    WXFFavoriteTableViewCell* cell = (WXFFavoriteTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil){
        cell = [[WXFFavoriteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    NSArray* array = [WXFFavoriteHandler instance].courseraList;
    if(indexPath.row < array.count){
        WXFCourses* courses = [array objectAtIndex:indexPath.row];
        [cell reloadDataWithCourses:courses];
    }
    
    __weak typeof(self)weakSelf = self;
    cell.cancelFavoriteBlock = ^(WXFCourses* courses){
        [[WXFFavoriteHandler instance] removeCourses:courses];
        [weakSelf.listTableView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FavoriteListChangeNtification" object:nil];
    };
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < [WXFFavoriteHandler instance].courseraList.count){
        WXFCourses* courses = [[WXFFavoriteHandler instance].courseraList objectAtIndex:indexPath.row];
        if(self.showCourseaDetailBlock){
            self.showCourseaDetailBlock(courses);
        }
        
    }
}

#pragma mark - title

- (UILabel*)titlelabel
{
    if(_titlelabel == nil){
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.textAlignment = NSTextAlignmentLeft;
        _titlelabel.textColor = [UIColor c_323232];
        _titlelabel.font = [UIFont systemFontOfSize:35.0f];
        _titlelabel.text = @"My Favorite";
        [_titlelabel sizeToFit];
        _titlelabel.frame = CGRectIntegral(_titlelabel.frame);
        [self.view addSubview:_titlelabel];
    }
    return _titlelabel;
}

- (UIView*)titleSeperateLine
{
    if(_titleSeperateLine == nil){
        _titleSeperateLine = [[UIView alloc] init];
        _titleSeperateLine.backgroundColor = [UIColor c_323232];
        [self.view addSubview:_titleSeperateLine];
    }
    return _titleSeperateLine;
}

- (void)loadFavoriteData
{
    if([WXFFavoriteHandler instance].needrefreshFavCourseraList){
        [self.listTableView.mj_header beginRefreshing];
    }else{
        if([WXFFavoriteHandler instance].courseraList.count == 0 && [WXFFavoriteHandler instance].coursesIds.count != 0){
            [self.listTableView.mj_header beginRefreshing];
        }else{
            [self.listTableView reloadData];
            [self.listTableView scrollRectToVisible:CGRectMake(0, 0, 10, 10) animated:YES];
        }
        
    }
    
    
}

- (void)refreshTableView
{
    [[WXFFavoriteHandler instance] getCourseraList:^(BOOL isSuccess) {
        [self.listTableView.mj_header endRefreshing];
        [self.listTableView reloadData];
    }];

}

@end
