//
//  FeedBackRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-6.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "FeedBackRequest.h"

@implementation FeedBackRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = Feedback_Detail_DataRequest;
    return url;
}


- (void)processResult
{
    [super processResult];
}
@end
