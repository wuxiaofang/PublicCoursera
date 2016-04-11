//
//  WXFHTTPSessionManager.m
//  WXFCommonModule
//
//  Created by yongche_w on 16/4/8.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "WXFHTTPSessionManager.h"
#import "WXFJSONResponseSerializer.h"
@implementation WXFHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [WXFJSONResponseSerializer serializer];
    
    return self;
}

@end
