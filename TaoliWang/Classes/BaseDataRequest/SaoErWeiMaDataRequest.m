//
//  SaoErWeiMaDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-16.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "SaoErWeiMaDataRequest.h"

@implementation SaoErWeiMaDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
- (NSString*)getRequestUrl
{
    NSString *url = Home_SaoErWeiMa_DataRequest;
    return url;
}
-(void)processResult
{
    [super processResult];
    
}
@end
