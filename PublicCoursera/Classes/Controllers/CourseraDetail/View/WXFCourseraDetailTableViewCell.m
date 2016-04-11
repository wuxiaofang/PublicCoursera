//
//  WXFCourseraDetailTableViewCell.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/10.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFCourseraDetailTableViewCell.h"

#define kLeftPadding   120

@interface WXFCourseraDetailTableViewCell()

@property (nonatomic, strong) UIImageView* photoView;

@property (nonatomic, strong) UILabel* nameTagLabel;

@property (nonatomic, strong) UILabel* nameLabel;

@property (nonatomic, strong) UILabel* workloadTagLabel;
@property (nonatomic, strong) UILabel* workloadLabel;

@property (nonatomic, strong) UILabel* languageTagLabel;
@property (nonatomic, strong) UILabel* languageLabel;

@property (nonatomic, strong) WXFCourses* courses;


@end

@implementation WXFCourseraDetailTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor c_e1e1e1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)loadCourses:(WXFCourses*)courses
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
    }];
    NSString* name = [NSString stringWithFormat:@"%@ ",self.courses.name];
    CGSize nameSize = [name sizeForFont:[UIFont systemFontOfSize:18.0f] size:CGSizeMake(kScreenWidth - 10 - kLeftPadding, 9999) mode:NSLineBreakByWordWrapping];
    self.nameLabel.text = name;
    self.nameLabel.v_width = kScreenWidth - 10 - kLeftPadding;
    self.nameLabel.v_height = nameSize.height;
    
    NSString* workLoad = [NSString stringWithFormat:@"%@ ",self.courses.workload];
    CGSize workLoadSize = [workLoad sizeForFont:[UIFont systemFontOfSize:18.0f] size:CGSizeMake(kScreenWidth - 10 - kLeftPadding, 9999) mode:NSLineBreakByWordWrapping];
    self.workloadLabel.text = workLoad;
    self.workloadLabel.v_width = kScreenWidth - 10 - kLeftPadding;
    self.workloadLabel.v_height = workLoadSize.height;
    
    NSString* language = [self.courses.primaryLanguages componentsJoinedByString:@","];
    
    language = [NSString stringWithFormat:@"%@ ",language];
    CGSize languageSize = [language sizeForFont:[UIFont systemFontOfSize:18.0f] size:CGSizeMake(kScreenWidth - 10 - kLeftPadding, 9999) mode:NSLineBreakByWordWrapping];
    self.languageLabel.text = language;
    self.languageLabel.v_width = kScreenWidth - 10 - kLeftPadding;
    self.languageLabel.v_height = languageSize.height;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.photoView.v_left = 10;
    self.photoView.v_top = 10;
    self.photoView.v_width = self.v_width - 20;
    self.photoView.v_height = 190;
    
    self.nameTagLabel.v_left = 10;
    self.nameTagLabel.v_top = self.photoView.v_bottom + 5;
    self.nameTagLabel.v_width = kLeftPadding - 10;
    
    self.nameLabel.v_left = self.nameTagLabel.v_right;
    self.nameLabel.v_top = self.photoView.v_bottom + 5;

    self.workloadTagLabel.v_left = 10;
    self.workloadTagLabel.v_top = self.nameLabel.v_bottom + 5;
    self.workloadTagLabel.v_width = kLeftPadding - 10;
    
    self.workloadLabel.v_left = self.workloadTagLabel.v_right;
    self.workloadLabel.v_top = self.nameLabel.v_bottom + 5;
    
    self.languageTagLabel.v_left = 10;
    self.languageTagLabel.v_top = self.workloadLabel.v_bottom + 5;
    self.languageTagLabel.v_width = kLeftPadding - 10;
    
    self.languageLabel.v_left = self.languageTagLabel.v_right;
    self.languageLabel.v_top = self.workloadLabel.v_bottom + 5;

    
   
}

- (UIImageView*)photoView
{
    if(_photoView == nil){
        _photoView = [[UIImageView alloc] init];
        _photoView.backgroundColor = [UIColor c_ffffff];
        _photoView.layer.masksToBounds = YES;
        _photoView.layer.cornerRadius = 6;
        _photoView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_photoView];
    }
    return _photoView;
}

- (UILabel*)nameTagLabel
{
    if(_nameTagLabel == nil){
        _nameTagLabel = [[UILabel alloc] init];
        _nameTagLabel.textAlignment = NSTextAlignmentLeft;
        _nameTagLabel.textColor = [UIColor c_323232];
        _nameTagLabel.font = [UIFont systemFontOfSize:18.0f];
        _nameTagLabel.text = @"NAME:";
        [_nameTagLabel sizeToFit];
        _nameTagLabel.frame = CGRectIntegral(_nameTagLabel.frame);
        [self addSubview:_nameTagLabel];
    }
    return _nameTagLabel;
}

- (UILabel*)nameLabel
{
    if(_nameLabel == nil){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor c_323232];
        _nameLabel.font = [UIFont systemFontOfSize:18.0f];
        _nameLabel.numberOfLines = 0;
        _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}


- (UILabel*)workloadTagLabel
{
    if(_workloadTagLabel == nil){
        _workloadTagLabel = [[UILabel alloc] init];
        _workloadTagLabel.textAlignment = NSTextAlignmentLeft;
        _workloadTagLabel.textColor = [UIColor c_323232];
        _workloadTagLabel.font = [UIFont systemFontOfSize:18.0f];
        _workloadTagLabel.text = @"WORKLOAD:";
        [_workloadTagLabel sizeToFit];
        _workloadTagLabel.frame = CGRectIntegral(_workloadTagLabel.frame);
        [self addSubview:_workloadTagLabel];
    }
    return _workloadTagLabel;
}

- (UILabel*)workloadLabel
{
    if(_workloadLabel == nil){
        _workloadLabel = [[UILabel alloc] init];
        _workloadLabel.textAlignment = NSTextAlignmentLeft;
        _workloadLabel.textColor = [UIColor c_323232];
        _workloadLabel.font = [UIFont systemFontOfSize:18.0f];
        _workloadLabel.numberOfLines = 0;
        _workloadLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_workloadLabel];
    }
    return _workloadLabel;
}

- (UILabel*)languageTagLabel
{
    if(_languageTagLabel == nil){
        _languageTagLabel = [[UILabel alloc] init];
        _languageTagLabel.textAlignment = NSTextAlignmentLeft;
        _languageTagLabel.textColor = [UIColor c_323232];
        _languageTagLabel.font = [UIFont systemFontOfSize:18.0f];
        _languageTagLabel.text = @"LANGUAGE:";
        [_languageTagLabel sizeToFit];
        _languageTagLabel.frame = CGRectIntegral(_languageTagLabel.frame);
        [self addSubview:_languageTagLabel];
    }
    return _languageTagLabel;
}

- (UILabel*)languageLabel
{
    if(_languageLabel == nil){
        _languageLabel = [[UILabel alloc] init];
        _languageLabel.textAlignment = NSTextAlignmentLeft;
        _languageLabel.textColor = [UIColor c_323232];
        _languageLabel.font = [UIFont systemFontOfSize:18.0f];
        _languageLabel.numberOfLines = 0;
        _languageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_languageLabel];
    }
    return _languageLabel;
}

+ (CGFloat)cellheigthForCoursera:(WXFCourses*)coursera width:(CGFloat)width
{
    CGFloat heigth = 0;
    
    //photoView
    heigth += (5 + 190 + 5);
    
    //name
    NSString* name = [NSString stringWithFormat:@"%@ ",coursera.name];
    CGSize nameSize = [name sizeForFont:[UIFont systemFontOfSize:18.0f] size:CGSizeMake(width - 10 - kLeftPadding, 9999) mode:NSLineBreakByWordWrapping];
    heigth += nameSize.height + 5;
    
    //workloadLabel
    NSString* workLoad = [NSString stringWithFormat:@"%@ ",coursera.workload];
    CGSize workLoadSize = [workLoad sizeForFont:[UIFont systemFontOfSize:18.0f] size:CGSizeMake(width - 10 - kLeftPadding, 9999) mode:NSLineBreakByWordWrapping];
    heigth += workLoadSize.height + 5;
    
    NSString* language = [coursera.primaryLanguages componentsJoinedByString:@","];
    language = [NSString stringWithFormat:@"%@ ",language];
    CGSize languageSize = [workLoad sizeForFont:[UIFont systemFontOfSize:18.0f] size:CGSizeMake(width - 10 - kLeftPadding, 9999) mode:NSLineBreakByWordWrapping];
    heigth += languageSize.height + 5;
    
    heigth += 5;
    
    return heigth;
}

@end



