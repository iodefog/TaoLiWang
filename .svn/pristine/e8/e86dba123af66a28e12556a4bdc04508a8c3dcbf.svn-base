//
//  MyAwardDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-27.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MyAwardDataRequest.h"
#import "AwardDeatilModel.h"
@implementation MyAwardDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
-(NSString*)getRequestUrl
{
    NSString *url = Myaward_Detail_DataRequest;
    return url;
}
-(void)processResult
{
    [super processResult];
    NSDictionary *dict = [self.handleredResult objectForKey:@"result"];
    if (![dict isEqual:[NSNull null]]) {
        AwardDeatilModel *model = [[AwardDeatilModel alloc]initWithDataDic:dict];
        [self.handleredResult setObject:model forKey:@"AwardDeatilModel"];
        
    }
}
@end
