//
//  MySubscriptionsDetailtDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MySubscriptionsDetailtDataRequest.h"
#import "MySubMangeDetailModel.h"

@implementation MySubscriptionsDetailtDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = MY_SUBSCRIPTIONS_DETAIL_DATAQUEST;
    return url;
}


- (void)processResult
{
    [super processResult];
    NSDictionary *dict = [self.handleredResult objectForKey:@"result"];
    if (![dict isEqual:[NSNull null]]) {
        MySubMangeDetailModel *model = [[MySubMangeDetailModel alloc]initWithDataDic:dict];
        [self.handleredResult setObject:model forKey:@"MySubMangeDetailModel"];
    }
}
@end
