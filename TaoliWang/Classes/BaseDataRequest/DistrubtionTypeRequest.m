//
//  DistrubtionTypeRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-6.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "DistrubtionTypeRequest.h"

@implementation DistrubtionTypeRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
-(NSString*)getRequestUrl
{
    NSString *url = Distribution_Code_DataRequest;
    return url;
}
-(void)processResult
{
    [super processResult];
}
@end
