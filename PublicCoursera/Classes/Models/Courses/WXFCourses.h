//
//  WXFCourses.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXFPartners.h"

@interface WXFCourses : NSObject

@property (nonatomic, copy) NSString* c_id;

@property (nonatomic, copy) NSString* slug;

@property (nonatomic, copy) NSString* courseType;

@property (nonatomic, copy) NSString* name;

@property (nonatomic, strong) NSArray* primaryLanguages;

@property (nonatomic, strong) NSArray* subtitleLanguages;

@property (nonatomic, copy) NSString* partnerLogo;

@property (nonatomic, strong) NSArray* instructors;

@property (nonatomic, strong) NSArray* partners;

@property (nonatomic, copy) NSString* photoUrl;

@property (nonatomic, strong) NSArray* certificates;

@property (nonatomic, copy) NSString* c_description;

@property (nonatomic, assign) NSTimeInterval startDate;

@property (nonatomic, copy) NSString* workload;

@property (nonatomic, copy) NSString* previewLink;

@property (nonatomic, strong) NSArray* specializations;

@property (nonatomic, strong) NSArray* s12nIds;

@property (nonatomic, strong) NSArray* domainTypes;

@property (nonatomic, strong) NSArray* categories;

@property (nonatomic, copy) NSString* university;

- (void)parseResponseDictionary:(NSDictionary*)response
                 instructors_v1:(NSArray*)instructors_v1
                    partners_v1:(NSArray*)partners_v1;

@end
