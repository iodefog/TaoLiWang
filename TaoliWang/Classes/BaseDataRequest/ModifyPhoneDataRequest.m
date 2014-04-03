//
//  ModifyPhoneDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-12.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ModifyPhoneDataRequest.h"

@implementation ModifyPhoneDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
-(NSString *)getRequestUrl
{
    _requestUrl = Person_Information_PhoneChange_DataRequest;
    return _requestUrl;
}

-(void)processResult
{
    [super processResult];
}
@end
