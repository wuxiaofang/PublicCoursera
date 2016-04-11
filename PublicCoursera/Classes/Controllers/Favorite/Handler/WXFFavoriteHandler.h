//
//  WXFFavoriteHandler.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/10.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXFCourses.h"

@interface WXFFavoriteHandler : NSObject

+(WXFFavoriteHandler*)instance;

@property (nonatomic, strong, readonly) NSMutableArray* courseraList;

@property (nonatomic, strong, readonly)NSMutableArray* coursesIds;

@property (nonatomic, assign) BOOL needrefreshFavCourseraList;

- (void)getCourseraList:(void(^)(BOOL isSuccess))completeBlock;


- (void)addCoursesToFavoriteList:(NSString*)c_id;

- (void)removeCoursesFromFavoriteList:(NSString*)c_id;

- (void)removeCourses:(WXFCourses*)courses;

- (BOOL)isFavorite:(NSString*)c_id;

@end
