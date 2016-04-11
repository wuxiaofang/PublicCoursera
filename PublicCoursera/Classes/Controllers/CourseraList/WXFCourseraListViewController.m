//
//  WXFCourseraListViewController.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFCourseraListViewController.h"
#import "WXFCourseraListHandler.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshBackNormalFooter.h"
#import "WXFCourseraTableViewCell.h"
#import "WXFCourseaDetailViewController.h"


@interface WXFCourseraListViewController()

@property (nonatomic, strong) WXFCourseraListHandler* handler;

@end

@implementation WXFCourseraListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [self initListTableView];
    
    self.handler = [[WXFCourseraListHandler alloc] init];
    // 下拉刷新
    self.listTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self refreshTableView];
    }];
    
    // 上拉刷新
    self.listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self reloadMoreDataTableView];
      
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.listTableView.mj_header beginRefreshing];
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(favoriteListChangeNtification) name:@"FavoriteListChangeNtification" object:nil];
}



- (void)refreshTableView
{
    [self showHud];
    [self.handler getCourseraList:^(BOOL isSuccess) {
        [self showSuccessToast];
        [self.listTableView.mj_header endRefreshing];
        
        [self.listTableView reloadData];
        
        if(self.handler.totalCoursera > 0 &&self.handler.courseraList.count == self.handler.totalCoursera){
            [self.listTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.listTableView.mj_footer resetNoMoreData];
            
        }
    }
                          refresh:YES] ;
}

- (void)reloadMoreDataTableView
{
    [self showHud];
    [self.handler getCourseraList:^(BOOL isSuccess) {
        [self showSuccessToast];
        [self.listTableView.mj_footer endRefreshing];
        [self.listTableView reloadData];
        if(self.handler.courseraList.count == self.handler.totalCoursera){
            [self.listTableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
                          refresh:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.listTableView.frame = self.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.handler.courseraList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentify = @"WXFCourseraTableViewCell";
    WXFCourseraTableViewCell* cell = (WXFCourseraTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil){
        cell = [[WXFCourseraTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    if(indexPath.row < self.handler.courseraList.count){
        WXFCourses* courses = [self.handler.courseraList objectAtIndex:indexPath.row];
        [cell reloadDataWithCourses:courses indexPath:indexPath];
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 310;
    }
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.handler.courseraList.count){
        WXFCourses* courses = [self.handler.courseraList objectAtIndex:indexPath.row];
        WXFCourseaDetailViewController* detail = [[WXFCourseaDetailViewController alloc] init];
        detail.courses = courses;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

- (void)favoriteListChangeNtification
{
    [self.listTableView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
