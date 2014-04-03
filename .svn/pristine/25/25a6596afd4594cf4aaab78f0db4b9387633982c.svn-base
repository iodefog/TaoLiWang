//
//  HomeRequestData.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-15.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "HomeRequestData.h"
#import "HomeInformationModel.h"
@implementation HomeRequestData
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = HOME_DATAREQUEST;
    return url;
}


- (void)processResult
{
    [super processResult];
    NSMutableArray *resultArr = [NSMutableArray array];
    NSMutableArray *dataArr = [self.handleredResult objectForKey:@"result"];
    if (![dataArr isEqual:[NSNull null]]) {
        for (id obejec in dataArr) {
            HomeInformationModel *model = [[HomeInformationModel alloc]initWithDataDic:obejec];
            [resultArr addObject:model];
        }
    }
    [self.handleredResult setObject:resultArr forKey:@"HomeInformationModel"];
    
}
@end
