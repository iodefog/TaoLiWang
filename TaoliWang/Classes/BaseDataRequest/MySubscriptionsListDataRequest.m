//
//  MySubscriptionsListDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MySubscriptionsListDataRequest.h"
#import "MySubscriptionModel.h"
@implementation MySubscriptionsListDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = MY_SUBSCRIPTIONS_LIST_DATAQUEST;
    return url;
}


- (void)processResult
{
    [super processResult];
    NSMutableArray *resultArr = [NSMutableArray array];
    NSMutableArray *Arr = [self.handleredResult objectForKey:@"result"];
    if (![Arr isEqual:[NSNull null]]) {
        for (id ob in Arr) {
            MySubscriptionModel *model = [[MySubscriptionModel alloc]initWithDataDic:ob];
            [resultArr addObject:model];
        }
    }
    [self.handleredResult setObject:resultArr forKey:@"MySubscriptionModel"];
}
@end
