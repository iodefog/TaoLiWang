//
//  GetCodeDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-11.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "GetCodeDataRequest.h"

@implementation GetCodeDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
-(NSString *)getRequestUrl
{
    _requestUrl = Person_Infomation_phoneCode_DataRequest;
    return _requestUrl;
}

-(void)processResult
{
    [super processResult];
}
@end
