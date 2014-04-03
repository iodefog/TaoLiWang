//
//  MyOffersDetailDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-25.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MyOffersDetailDataRequest.h"
#import "MyOffersDetailModel.h"

@implementation MyOffersDetailDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = MyOffers_Detail_DataRequest;
    return url;
}


- (void)processResult
{
    [super processResult];
    NSDictionary *dict = [self.handleredResult objectForKey:@"result"];
    if (![dict isEqual:[NSNull null]]) {
            MyOffersDetailModel *model = [[MyOffersDetailModel alloc]initWithDataDic:dict];
        [self.handleredResult setObject:model forKey:@"MyOffersDetailModel"];

    }
}
@end
