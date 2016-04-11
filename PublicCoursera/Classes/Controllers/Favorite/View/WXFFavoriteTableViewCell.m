//
//  WXFFavoriteTableViewCell.m
//  PublicCoursera
//
//  Created by yongche_w on 16/4/10.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFFavoriteTableViewCell.h"


#import "WXFCourses.h"
#import "WXFFavoriteHandler.h"

@interface WXFFavoriteTableViewCell()

@property (nonatomic, strong) UIImageView* photoView;

@property (nonatomic, strong) UILabel* nameLabel;

@property (nonatomic, strong) UILabel* universityLabel;

@property (nonatomic, strong) WXFCourses* courses;

@property (nonatomic, strong) UIButton* favoriteButton;

@property (nonatomic, strong) UIView* bottomSeperateLine;

@end

@implementation WXFFavoriteTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor c_e1e1e1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}



- (void)reloadDataWithCourses:(WXFCourses*)courses
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
    self.nameLabel.text = [NSString stringWithFormat:@"%@",self.courses.slug];
    
    [self.nameLabel sizeToFit];
    self.nameLabel.frame = CGRectIntegral(self.nameLabel.frame);
    
    self.universityLabel.text = [NSString stringWithFormat:@"University: UCLA"];
    [self.universityLabel sizeToFit];
    self.universityLabel.frame = CGRectIntegral(self.universityLabel.frame);
    self.favoriteButton.selected = [[WXFFavoriteHandler instance] isFavorite:self.courses.c_id];
}

- (UIImageView*)photoView
{
    if(_photoView == nil){
        _photoView = [[UIImageView alloc] init];
        _photoView.backgroundColor = [UIColor c_ffffff];
        
        _photoView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_photoView];
    }
    return _photoView;
}

- (UILabel*)nameLabel
{
    if(_nameLabel == nil){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor c_323232];
        _nameLabel.font = [UIFont systemFontOfSize:26.0f];
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
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
    if(self.cancelFavoriteBlock){
        self.cancelFavoriteBlock(self.courses);
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.photoView.v_left = 10;
    self.photoView.v_top = 10;
    self.photoView.v_width = self.photoView.v_height = (self.v_height - 20);
    
    self.nameLabel.v_left = self.photoView.v_right + 5;
    self.nameLabel.v_top = 10;
    self.nameLabel.v_width = self.v_width - self.nameLabel.v_left - 10;
    

    self.universityLabel.v_left = self.nameLabel.v_left;
    self.universityLabel.v_top = self.nameLabel.v_bottom + 5;
    self.universityLabel.v_width = self.nameLabel.v_width;

    self.favoriteButton.v_left = self.v_width - self.favoriteButton.v_width - 5;
    self.favoriteButton.v_top = self.v_height - self.favoriteButton.v_height - 10;
    
    self.bottomSeperateLine.v_left = 10;
    self.bottomSeperateLine.v_top = self.v_height - 0.5;
    self.bottomSeperateLine.v_width = self.v_width - 10;
    self.bottomSeperateLine.v_height = 0.5;
}

- (UIView*)bottomSeperateLine
{
    if(_bottomSeperateLine == nil){
        _bottomSeperateLine = [[UIView alloc] init];
        _bottomSeperateLine.backgroundColor = [UIColor c_323232];
        [self addSubview:_bottomSeperateLine];
    }
    return _bottomSeperateLine;
}

@end
