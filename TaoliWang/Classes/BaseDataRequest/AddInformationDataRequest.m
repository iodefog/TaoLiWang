//
//  AddInformationDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-19.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "AddInformationDataRequest.h"
#import "AddressModel.h"
@implementation AddInformationDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = Person_addInformation_DataReuquest;
    return url;
}


- (void)processResult
{
    [super processResult];
//    NSMutableArray *resultArr = [NSMutableArray array];
//    NSMutableArray *Arr = [self.handleredResult objectForKey:@"result"];
//    if (![Arr isEqual:[NSNull null]]) {
//        for (id ob in Arr) {
//            AddressModel *model = [[AddressModel alloc]initWithDataDic:ob];
//            [resultArr addObject:model];
//        }
//    }
//    [self.handleredResult setObject:resultArr forKey:@"AddressModel"];
}
@end
