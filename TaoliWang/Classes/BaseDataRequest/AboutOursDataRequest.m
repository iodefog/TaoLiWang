//
//  AboutOursDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-6.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "AboutOursDataRequest.h"

@implementation AboutOursDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = About_Ours_DataRequest;
    return url;
}


- (void)processResult
{
    [super processResult];
}
@end
