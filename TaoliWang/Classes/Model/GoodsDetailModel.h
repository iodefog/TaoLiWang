//
//  GoodsDetailModel.h
//  TaoliWang
//
//  Created by Mac OS X on 14-1-16.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface GoodsDetailModel : ITTBaseModelObject
@property (nonatomic, copy) NSString                    *chmc;    //名称
@property (nonatomic, copy) NSString                    *tlscj;   //市场价格
@property (nonatomic, copy) NSString                    *scj;     //交易价格
@property (nonatomic, copy) NSString                    *cklsj;   //积分价格
@property (nonatomic, strong) NSArray                   *tpmc;    //图片浏览
@property (nonatomic, copy) NSString                    *xq;      //图示详解
@end
