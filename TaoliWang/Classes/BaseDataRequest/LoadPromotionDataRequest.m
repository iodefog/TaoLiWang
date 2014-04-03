//
//  LoadPromotionDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-14.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "LoadPromotionDataRequest.h"

@implementation LoadPromotionDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
- (NSString*)getRequestUrl
{
    NSString *url = PROMOTION_LOAD_COUPON;
    return url;
}
-(void)processResult
{
    [super processResult];
    
}
@end
