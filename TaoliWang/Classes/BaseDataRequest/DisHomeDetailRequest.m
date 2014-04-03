//
//  DisHomeDetailRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-6.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "DisHomeDetailRequest.h"
#import "DisDetailModel.h"

@implementation DisHomeDetailRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
-(NSString*)getRequestUrl
{
    NSString *url = Distribution_ADDetail_DataRequest;
    return url;
}
-(void)processResult
{
    [super processResult];
    NSDictionary *dict = [self.handleredResult objectForKey:@"result"];
    if (![dict isEqual:[NSNull null]]) {
        DisDetailModel *model = [[DisDetailModel alloc]initWithDataDic:dict];
        [self.handleredResult setObject:model forKey:@"DisDetailModel"];
    }

}
@end
