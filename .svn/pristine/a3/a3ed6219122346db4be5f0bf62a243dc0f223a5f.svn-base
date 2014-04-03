//
//  MyCountDetailRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-3.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MyCountDetailRequest.h"
#import "myOrderDetailModel.h"
#import "MyOrderGoodsListModel.h"

@implementation MyCountDetailRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = MyCount_Detail_DataRequest;
    return url;
}


- (void)processResult
{
    [super processResult];
    NSMutableArray *resultArr = [NSMutableArray array];

    NSDictionary *dict = [self.handleredResult objectForKey:@"result"];
    if (![dict isEqual:[NSNull null]]) {
        
        
        myOrderDetailModel *model = [[myOrderDetailModel alloc]initWithDataDic:dict];
        [self.handleredResult setObject:model forKey:@"myOrderDetailModel"];
        
        NSMutableArray *arr = [dict objectForKey:@"orderSubList"];
        if (![arr isEqual:[NSNull null]]) {
            for (id ob in arr) {
                MyOrderGoodsListModel *model = [[MyOrderGoodsListModel alloc]initWithDataDic:ob];
                [resultArr addObject:model];
            }
        }

    }
    [self.handleredResult setObject:resultArr forKey:@"MyOrderGoodsListModel"];
    
}
@end
