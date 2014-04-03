//
//  UserRegistRequest.m
//  TaoliWang
//
//  Created by zdqk on 14-1-7.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "UserRegistRequest.h"

@implementation UserRegistRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
-(NSString *)getRequestUrl
{
    _requestUrl = USER_REGIST_DATAREQUEST;
    return _requestUrl;
}

-(void)processResult
{
    [super processResult];
}
@end
