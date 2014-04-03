//
//  DisHomeRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-6.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "DisHomeRequest.h"
#import "MySubscriptionModel.h"

@implementation DisHomeRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
-(NSString*)getRequestUrl
{
    NSString *url = Distribution_PromotionList_DataRequest;
    return url;
}
-(void)processResult
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
