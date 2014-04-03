//
//  PromotionListDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-11.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "PromotionListDataRequest.h"
#import "PromotionModel.h"
@implementation PromotionListDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
- (NSString*)getRequestUrl
{
    NSString *url = PROMOTION_LIST_DATAREQUEST;
    return url;
}
-(void)processResult
{
    [super processResult];
    NSMutableArray *resultArr = [NSMutableArray array];
    NSMutableArray *Arr = [self.handleredResult objectForKey:@"result"];
    if (![Arr isEqual:[NSNull null]]) {
        for (id ob in Arr) {
            PromotionModel *model = [[PromotionModel alloc]initWithDataDic:ob];
            [resultArr addObject:model];
        }
    }
    [self.handleredResult setObject:resultArr forKey:@"PromotionModel"];
}
@end
