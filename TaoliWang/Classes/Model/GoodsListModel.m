//
//  GoodsListModel.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "GoodsListModel.h"

@implementation GoodsListModel
-(NSDictionary *)attributeMapDictionary
{
    return @{@"chmc":@"chmc"
             ,@"tlscj":@"tlscj"
             ,@"scj":@"scj"
             ,@"cklsj":@"cklsj"
             ,@"tpmc":@"tpmc"
             ,@"GoodsId":@"id"
             ,@"GoodsNumber":@"GoodsNumber"
             ,@"Type":@"Type"};
}
@end
