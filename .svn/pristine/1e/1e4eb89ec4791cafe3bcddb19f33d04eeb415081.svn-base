//
//  YaoyiyaoListDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-3.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "YaoyiyaoListDataRequest.h"
#import "YaoyiyaoListModel.h"
@implementation YaoyiyaoListDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = Yaoyiyao_List_DataRequest;
    return url;
}


- (void)processResult
{
    [super processResult];
    NSMutableArray *resultArr = [NSMutableArray array];
    NSMutableArray *Arr = [self.handleredResult objectForKey:@"result"];
    if (![Arr isEqual:[NSNull null]]) {
        for (id ob in Arr) {
            YaoyiyaoListModel *model = [[YaoyiyaoListModel alloc]initWithDataDic:ob];
            [resultArr addObject:model];
        }
    }
    [self.handleredResult setObject:resultArr forKey:@"YaoyiyaoListModel"];
}
@end
