//
//  JionAwardDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-27.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "JionAwardDataRequest.h"

@implementation JionAwardDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
-(NSString*)getRequestUrl
{
    NSString *url = Join_Award_DataRequest;
    return url;
}
-(void)processResult
{
    [super processResult];
    
}
@end
