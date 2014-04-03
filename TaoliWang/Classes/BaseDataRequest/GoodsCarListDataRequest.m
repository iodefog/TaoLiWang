//
//  GoodsCarListDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-25.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "GoodsCarListDataRequest.h"

@implementation GoodsCarListDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}
-(NSString*)getRequestUrl
{
    NSString *url = GoodsCar_List_DataRequest;
    return url;
}
-(void)processResult
{
    [super processResult];
    
}
@end
