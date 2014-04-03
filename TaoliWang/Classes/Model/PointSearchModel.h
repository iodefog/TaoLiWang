//
//  SearchModel.h
//  TaoliWang
//
//  Created by Mac OS X on 14-2-12.
//  Copyright (c) 2014年 Custom. All rights reserved.
//
//  首页积分查询Model
#import "ITTBaseModelObject.h"

@interface PointSearchModel : ITTBaseModelObject
@property (nonatomic, copy) NSString            *sj;      //时间
@property (nonatomic, copy) NSString            *jf;      //积分
@property (nonatomic, copy) NSString            *type;    //类型
@end
