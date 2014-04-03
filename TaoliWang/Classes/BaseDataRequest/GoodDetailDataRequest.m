//
//  GoodDetailDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-16.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "GoodDetailDataRequest.h"
#import "GoodsDetailModel.h"

@implementation GoodDetailDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = GOODS_DETAIL_DATAREQUEST;
    return url;
}


- (void)processResult
{
    [super processResult];
    NSDictionary *resultDic = [self.handleredResult objectForKey:@"result"];
    if (![resultDic isEqual:[NSNull null]]) {
        GoodsDetailModel *model = [[GoodsDetailModel alloc]initWithDataDic:resultDic];
        [self.handleredResult setObject:model forKey:@"GoodsDetailModel"];
    }
}
@end
