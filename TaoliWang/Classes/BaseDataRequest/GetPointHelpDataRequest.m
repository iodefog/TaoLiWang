//
//  GetPointHelpDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-6.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "GetPointHelpDataRequest.h"

@implementation GetPointHelpDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
- (NSString*)getRequestUrl
{
    NSString *url = Get_Point_Help_DataRequest;
    return url;
}
-(void)processResult
{
    [super processResult];
    
}
@end
