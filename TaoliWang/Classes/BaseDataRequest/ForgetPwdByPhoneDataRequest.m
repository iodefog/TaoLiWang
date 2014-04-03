//
//  ForgetPwdByPhoneDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-11.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ForgetPwdByPhoneDataRequest.h"

@implementation ForgetPwdByPhoneDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
-(NSString *)getRequestUrl
{
    _requestUrl = Get_PWd_By_Phone_DataRequest;
    return _requestUrl;
}

-(void)processResult
{
    [super processResult];
}
@end
