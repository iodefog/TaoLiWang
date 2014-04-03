//
//  MySubscriptionsConformDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MySubscriptionsConformDataRequest.h"
#import "subManageModel.h"
@implementation MySubscriptionsConformDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = MY_SUBSCRIPTIONS_Comform_DATAQUEST;
    return url;
}


- (void)processResult
{
    [super processResult];
    NSMutableArray *resultArr = [NSMutableArray array];
    NSMutableArray *Arr = [self.handleredResult objectForKey:@"result"];
    if (![Arr isEqual:[NSNull null]]) {
        for (NSDictionary *ob in Arr) {
            subManageModel *model = [[subManageModel alloc]initWithDataDic:ob];
            [resultArr addObject:model];
        }
    }
    [self.handleredResult setObject:resultArr forKey:@"subManageModel"];
}
@end
