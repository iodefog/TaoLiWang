//
//  MySubscriptionModel.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MySubscriptionModel.h"

@implementation MySubscriptionModel
-(NSDictionary *)attributeMapDictionary
{
    return @{@"ActivityId":@"id",
             @"tp":@"tp",
             @"wzbt":@"wzbt",
             @"bt":@"bt"};
}
@end
