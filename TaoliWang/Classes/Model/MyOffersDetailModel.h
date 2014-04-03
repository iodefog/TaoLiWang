//
//  MyOffersDetailModel.h
//  TaoliWang
//
//  Created by Mac OS X on 14-2-27.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MyOffersDetailModel : ITTBaseModelObject
@property (nonatomic, copy) NSString            *mm;            //优惠劵ID
@property (nonatomic, copy) NSString            *yhjtp;         //优惠劵图片
@property (nonatomic, copy) NSString            *yhjmc;         //优惠劵名称
@property (nonatomic, copy) NSString            *yhjpp;         //优惠劵品牌
@property (nonatomic, copy) NSString            *yxq;           //优惠到期时间
@property (nonatomic, copy) NSString            *hzs;           //商户名称
@property (nonatomic, copy) NSString            *yhjdz;         //商户地址
@property (nonatomic, copy) NSString            *yhjdh;         //商户电话
@property (nonatomic, copy) NSString            *yhxq;          //商户详情
@end
