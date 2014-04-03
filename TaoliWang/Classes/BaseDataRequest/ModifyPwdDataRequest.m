//
//  ModifyPwdDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-11.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ModifyPwdDataRequest.h"

@implementation ModifyPwdDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
-(NSString *)getRequestUrl
{
    _requestUrl = Modify_Pwd_NotOldPwd_DataRequest;
    return _requestUrl;
}

-(void)processResult
{
    [super processResult];
}
@end
