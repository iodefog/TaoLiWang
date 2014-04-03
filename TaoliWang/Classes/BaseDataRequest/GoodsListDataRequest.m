//
//  GoodsListDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "GoodsListDataRequest.h"
#import "GoodsListModel.h"
@implementation GoodsListDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
- (NSString*)getRequestUrl
{
    NSString *url = GOODS_LIST_DATAREQUEST;
    return url;
}
-(void)processResult
{
    [super processResult];
    NSMutableArray *resultArr = [NSMutableArray array];
    NSMutableArray *Arr = [self.handleredResult objectForKey:@"result"];
    if (![Arr isEqual:[NSNull null]]) {
        for (id ob in Arr) {
            GoodsListModel *model = [[GoodsListModel alloc]initWithDataDic:ob];
            model.GoodsNumber = @"1";
            [resultArr addObject:model];
        }
    }
    [self.handleredResult setObject:resultArr forKey:@"GoodsListModel"];
}
@end
