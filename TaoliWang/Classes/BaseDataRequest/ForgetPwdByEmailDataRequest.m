//
//  ForgetPwdByEmailDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-11.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ForgetPwdByEmailDataRequest.h"

@implementation ForgetPwdByEmailDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
-(NSString *)getRequestUrl
{
    _requestUrl = Get_pwd_By_Email_DataRquest;
    return _requestUrl;
}

-(void)processResult
{
    [super processResult];
}
@end
