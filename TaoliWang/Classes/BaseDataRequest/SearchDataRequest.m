//
//  SearchDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-12.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "SearchDataRequest.h"
#import "GoodsListModel.h"

@implementation SearchDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
- (NSString*)getRequestUrl
{
    NSString *url = HOME_SEARCH_DATAREQUEST;
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
            [resultArr addObject:model];
        }
    }
    [self.handleredResult setObject:resultArr forKey:@"GoodsListModel"];
}
@end
