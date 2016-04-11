//
//  WXFCourseraListHandler.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXFCourses.h"

@interface WXFCourseraListHandler : NSObject

@property (nonatomic, strong, readonly) NSMutableArray* courseraList;

@property (nonatomic, assign) NSInteger totalCoursera;

- (void)getCourseraList:(void(^)(BOOL isSuccess))completeBlock
                refresh:(BOOL)refresh;


@end
