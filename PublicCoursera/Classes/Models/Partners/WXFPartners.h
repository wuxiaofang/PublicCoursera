//
//  WXFPartners.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXFPartners : NSObject

@property (nonatomic, copy) NSString* name;

@property (nonatomic, copy) NSString* c_id;

@property (nonatomic, copy) NSString* shortName;

@property (nonatomic, copy) NSString* c_description;

@property (nonatomic, copy) NSString* banner;

@property (nonatomic, strong) NSArray* courseIds;

@property (nonatomic, strong) NSString* primaryColor;

@property (nonatomic, strong) NSString* rectangularLogo;

@property (nonatomic, strong) NSString* logo;

@property (nonatomic, strong) NSString* squareLogo;

- (void)parseDataFromDic:(NSDictionary*)dic;

@end
