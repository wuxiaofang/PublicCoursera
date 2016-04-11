//
//  WXFCourseaDetailViewController.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/10.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFCourseaDetailViewController.h"
#import "WXFCourseraDetailTableViewCell.h"
#import "WXFPartnersDetailTableViewCell.h"
#import "WXFCourseraDescTableViewCell.h"

@interface WXFCourseaDetailViewController()

@end

@implementation WXFCourseaDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackButton];
    [self setCustomLabelForNavTitle:self.courses.slug];
    [self initListTableView];
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

- (void)backBarButtonPressed:(id)object
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 3;

    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentify = @"UITableViewCell";
    if(indexPath.row == 0){
        cellIdentify = @"WXFCourseraDetailTableViewCell";
    }else if(indexPath.row == 1){
        cellIdentify = @"WXFPartnersDetailTableViewCell";
    }else{
        cellIdentify = @"WXFCourseraDescTableViewCell";
        
    }
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil){
        cell = [[NSClassFromString(cellIdentify) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    if([cellIdentify isEqualToString:@"WXFCourseraDetailTableViewCell"]){
        WXFCourseraDetailTableViewCell* courseraCell = (WXFCourseraDetailTableViewCell*)cell;
        
        [courseraCell loadCourses:self.courses];
        
    }else if([cellIdentify isEqualToString:@"WXFPartnersDetailTableViewCell"]){
        WXFPartnersDetailTableViewCell* pCell = (WXFPartnersDetailTableViewCell*)cell;
        [pCell loadCourses:self.courses];
    }else if([cellIdentify isEqualToString:@"WXFCourseraDescTableViewCell"]){
        WXFCourseraDescTableViewCell* dCell = (WXFCourseraDescTableViewCell*)cell;
        [dCell loadCourses:self.courses];
    }
 
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeigth = 0;
    if(indexPath.row == 0){
        cellHeigth = [WXFCourseraDetailTableViewCell cellheigthForCoursera:self.courses
                                                                     width:self.listTableView.v_width];
    }else if(indexPath.row == 1){
        cellHeigth = [WXFPartnersDetailTableViewCell cellheigthForCoursera:self.courses
                                                                     width:self.listTableView.v_width];
    }else{
        cellHeigth = [WXFCourseraDescTableViewCell cellheigthForCoursera:self.courses
                                                                   width:self.listTableView.v_width];
    }
    return cellHeigth;
}

@end
