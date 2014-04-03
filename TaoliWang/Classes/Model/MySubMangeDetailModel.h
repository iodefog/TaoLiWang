//
//  MySubMangeDetailModel.h
//  TaoliWang
//
//  Created by Mac OS X on 14-2-20.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MySubMangeDetailModel : ITTBaseModelObject
@property (nonatomic, copy) NSString            *wzlr;              //内容
@property (nonatomic, copy) NSString            *tp;                //图片
@property (nonatomic, copy) NSString            *wzbt;              //标题
@property (nonatomic, copy) NSString            *sfyyhj;            //是否有优惠劵
@property (nonatomic, copy) NSString            *yhjpch;            //优惠劵批次号
@end
