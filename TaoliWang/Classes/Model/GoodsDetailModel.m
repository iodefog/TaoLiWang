//
//  GoodsDetailModel.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-16.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "GoodsDetailModel.h"

@implementation GoodsDetailModel

//@property (nonatomic, copy) NSString                    *chmc;    //名称
//@property (nonatomic, copy) NSString                    *tlscj;   //交易价格
//@property (nonatomic, copy) NSString                    *scj;     //市场价格
//@property (nonatomic, strong) NSArray                   *tp;      //图片浏览


-(NSDictionary *)attributeMapDictionary
{
    return @{@"chmc":@"chmc"
            ,@"tlscj":@"tlscj"
            ,@"scj":@"scj"
            ,@"cklsj":@"cklsj"
            ,@"tpmc":@"array"
            ,@"xq":@"xq"};
}
@end
