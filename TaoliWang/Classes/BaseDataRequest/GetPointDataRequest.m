//
//  GetPointDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-21.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "GetPointDataRequest.h"

@implementation GetPointDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
- (NSString*)getRequestUrl
{
    NSString *url = GET_POINT_DATAREQUEST;
    return url;
}
-(void)processResult
{
    [super processResult];
}
@end
