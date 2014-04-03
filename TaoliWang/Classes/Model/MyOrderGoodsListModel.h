//
//  MyOrderGoodsListModel.h
//  TaoliWang
//
//  Created by Mac OS X on 14-3-3.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MyOrderGoodsListModel : ITTBaseModelObject
@property (nonatomic, copy)NSString     *tp;   //商品图片
@property (nonatomic, copy)NSString     *sl;   //商品数量
@property (nonatomic, copy)NSString     *hpmc; //商品名称
@property (nonatomic, copy)NSString     *hpid; //商品id
@property (nonatomic, copy)NSString     *xq;   //商品详情
@property (nonatomic, copy)NSString     *dhjf; //兑换积分
@property (nonatomic, copy)NSString     *dhdj; //兑换价格
@property (nonatomic, copy)NSString     *dhje; //价格合计
@property (nonatomic, copy)NSString     *jfhj; //积分合计
@end
