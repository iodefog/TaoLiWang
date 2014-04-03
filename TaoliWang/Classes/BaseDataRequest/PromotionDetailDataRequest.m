//
//  PromotionDetailDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-14.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "PromotionDetailDataRequest.h"
#import "PromotionDetaileModel.h"
@implementation PromotionDetailDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
- (NSString*)getRequestUrl
{
    NSString *url = PROMOTION_DETAIL_DATAREQUEST;
    return url;
}
-(void)processResult{
    [super processResult];
    NSDictionary *dict = [self.handleredResult objectForKey:@"result"];
    if (![dict isEqual:[NSNull null]]) {
            PromotionDetaileModel *model = [[PromotionDetaileModel alloc]initWithDataDic:dict];
        [self.handleredResult setObject:model forKey:@"PromotionDetaileModel"];
    }
    
}
@end
