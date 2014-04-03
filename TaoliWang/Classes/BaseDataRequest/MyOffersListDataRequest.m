//
//  MyOffersListDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-25.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MyOffersListDataRequest.h"
#import "MyOffersListModel.h"
@implementation MyOffersListDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = MyOffers_List_DataRequest;
    return url;
}


- (void)processResult
{
    [super processResult];
    NSMutableArray *resultArr = [NSMutableArray array];
    NSMutableArray *Arr = [self.handleredResult objectForKey:@"result"];
    if (![Arr isEqual:[NSNull null]]) {
        for (id ob in Arr) {
            MyOffersListModel *model = [[MyOffersListModel alloc]initWithDataDic:ob];
            [resultArr addObject:model];
        }
    }
    [self.handleredResult setObject:resultArr forKey:@"MyOffersListModel"];
}
@end
