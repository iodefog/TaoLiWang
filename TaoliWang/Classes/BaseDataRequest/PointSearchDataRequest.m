//
//  PointSearchDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-14.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "PointSearchDataRequest.h"
#import "PointSearchModel.h"
@implementation PointSearchDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
- (NSString*)getRequestUrl
{
    NSString *url = SEARCH_POINT_DATAREQUEST;
    return url;
}
-(void)processResult
{
    [super processResult];
    NSMutableArray *resultArr = [NSMutableArray array];
    NSMutableArray *Arr = [self.handleredResult objectForKey:@"result"];
    NSLog(@"sss == %@",self.handleredResult);
    if (![Arr isEqual:[NSNull null]]) {
        for (id ob in Arr) {
            PointSearchModel *model = [[PointSearchModel alloc]initWithDataDic:ob];
            [resultArr addObject:model];
        }
    }
    [self.handleredResult setObject:resultArr forKey:@"PointSearchModel"];
}
@end
