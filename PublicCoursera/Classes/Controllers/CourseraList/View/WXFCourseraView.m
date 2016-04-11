//
//  WXFCourseraView.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/10.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFCourseraView.h"
#import "WXFCourses.h"
#import "WXFFavoriteHandler.h"

@interface WXFCourseraView()

@property (nonatomic, strong) UIImageView* photoView;

@property (nonatomic, strong) UILabel* nameLabel;

//@property (nonatomic, strong) UILabel* startTimeLabel;

@property (nonatomic, strong) UILabel* workloadLabel;

@property (nonatomic, strong) UILabel* universityLabel;

@property (nonatomic, strong) WXFCourses* courses;

@property (nonatomic, strong) UIButton* favoriteButton;

@end

@implementation WXFCourseraView

- (void)reloadDataWithCourses:(WXFCourses*)courses;
{
    self.courses = courses;
    NSURL* url = [NSURL URLWithString:courses.photoUrl];
    [self.photoView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSString* absoluteString = [imageURL absoluteString];
        if([absoluteString isEqualToString:self.courses.photoUrl]){
            self.photoView.image = image;
        }else{
            self.photoView.image = nil;
        }
    }];;
    self.nameLabel.text = self.courses.name;
    

    self.workloadLabel.text = [NSString stringWithFormat:@"Workload: %@",self.courses.workload];
    
    self.universityLabel.text = [NSString stringWithFormat:@"University: %@",self.courses.university];
    
    [self.workloadLabel sizeToFit];
    self.workloadLabel.frame = CGRectIntegral(self.workloadLabel.frame);
    [self.universityLabel sizeToFit];
    self.universityLabel.frame = CGRectIntegral(self.universityLabel.frame);
    self.favoriteButton.selected = [[WXFFavoriteHandler instance] isFavorite:self.courses.c_id];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.photoView.v_left = 5;
    self.photoView.v_top = 5;
    self.photoView.v_width = self.v_width - 10;
    self.photoView.v_height = 190;
    self.nameLabel.v_left = 0;
    self.nameLabel.v_top = self.photoView.v_height - 30;
    self.nameLabel.v_width = self.photoView.v_width;
    self.nameLabel.v_height = 30;
    
//    self.startTimeLabel.v_left = 5;
//    self.startTimeLabel.v_top = self.photoView.v_bottom + 5;
    
    self.workloadLabel.v_left = 5;
    self.workloadLabel.v_top = self.photoView.v_bottom + 5;
    
    self.universityLabel.v_left = 5;
    self.universityLabel.v_top = self.workloadLabel.v_bottom + 5;
    
    self.favoriteButton.v_left = self.v_width - self.favoriteButton.v_width - 5;
    self.favoriteButton.v_top = self.v_height - self.favoriteButton.v_height - 10;
}


- (UIImageView*)photoView
{
    if(_photoView == nil){
        _photoView = [[UIImageView alloc] init];
        _photoView.backgroundColor = [UIColor c_ffffff];
        _photoView.layer.cornerRadius = 6;
        _photoView.layer.masksToBounds = YES;
        _photoView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_photoView];
    }
    return _photoView;
}

- (UILabel*)nameLabel
{
    if(_nameLabel == nil){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:16.0f];
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        [self.photoView addSubview:_nameLabel];
    }
    return _nameLabel;
}

//- (UILabel*)startTimeLabel
//{
//    if(_startTimeLabel == nil){
//        _startTimeLabel = [[UILabel alloc] init];
//        _startTimeLabel.textAlignment = NSTextAlignmentLeft;
//        _startTimeLabel.textColor = [UIColor c_888888];
//        _startTimeLabel.font = [UIFont systemFontOfSize:16.0f];
//        [self addSubview:_startTimeLabel];
//    }
//    return _startTimeLabel;
//}

- (UILabel*)workloadLabel
{
    if(_workloadLabel == nil){
        _workloadLabel = [[UILabel alloc] init];
        _workloadLabel.textAlignment = NSTextAlignmentLeft;
        _workloadLabel.textColor = [UIColor c_888888];
        _workloadLabel.font = [UIFont systemFontOfSize:18.0f];
        [self addSubview:_workloadLabel];
    }
    return _workloadLabel;
}

- (UILabel*)universityLabel
{
    if(_universityLabel == nil){
        _universityLabel = [[UILabel alloc] init];
        _universityLabel.textAlignment = NSTextAlignmentLeft;
        _universityLabel.textColor = [UIColor c_888888];
        _universityLabel.font = [UIFont systemFontOfSize:18.0f];
        [self addSubview:_universityLabel];
    }
    return _universityLabel;
}

- (NSString*)changeTime:(NSTimeInterval)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    return [formatter stringFromDate:confromTimesp];
}


- (UIButton*)favoriteButton
{
    if(_favoriteButton == nil){
        _favoriteButton = [[UIButton alloc] init];
        [_favoriteButton setImage:[UIImage imageNamed:@"coursera_no_fav"] forState:UIControlStateNormal];
        [_favoriteButton setImage:[UIImage imageNamed:@"coursera_fav"] forState:UIControlStateSelected];
        [_favoriteButton sizeToFit];
        _favoriteButton.frame = CGRectIntegral(_favoriteButton.frame);
        [_favoriteButton addTarget:self action:@selector(favoriteButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_favoriteButton];
    }
    return _favoriteButton;
}

- (void)favoriteButtonPress
{
    if(self.favoriteButton.selected){
        [[WXFFavoriteHandler instance] removeCoursesFromFavoriteList:self.courses.c_id];
        
    }else{
        [[WXFFavoriteHandler instance] addCoursesToFavoriteList:self.courses.c_id];
    }
    self.favoriteButton.selected = !self.favoriteButton.selected;
}

@end
