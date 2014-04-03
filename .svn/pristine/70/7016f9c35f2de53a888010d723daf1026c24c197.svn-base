//
//  YaoyiyaoDetailDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-3.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "YaoyiyaoDetailDataRequest.h"
#import "YaoyiyaoListModel.h"
@implementation YaoyiyaoDetailDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = Yaoyiyao_Detail_DataRequest;
    return url;
}


- (void)processResult
{
    [super processResult];
    NSDictionary *dict = [self.handleredResult objectForKey:@"result"];
    if (![dict isEqual:[NSNull null]]) {
            YaoyiyaoListModel *model = [[YaoyiyaoListModel alloc]initWithDataDic:dict];
        [self.handleredResult setObject:model forKey:@"YaoyiyaoListModel"];

    }
}
@end
