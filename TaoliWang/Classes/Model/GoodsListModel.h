//
//  GoodsListModel.h
//  TaoliWang
//
//  Created by Mac OS X on 14-1-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface GoodsListModel : ITTBaseModelObject
@property (nonatomic, copy) NSString                    *chmc;          //名称
@property (nonatomic, copy) NSString                    *tlscj;         //交易价格
@property (nonatomic, copy) NSString                    *scj;           //市场价格
@property (nonatomic, copy) NSString                    *cklsj;         //积分价格
@property (nonatomic, copy) NSString                    *tpmc;          //图片浏览
@property (nonatomic, copy) NSString                    *GoodsId;       //商品id
@property (nonatomic, copy) NSString                    *GoodsNumber;    //商品个数
@property (nonatomic, copy) NSString                    *Type;           //商品类型
@end
