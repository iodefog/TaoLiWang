//
//  YaoyiyaoListModel.h
//  TaoliWang
//
//  Created by Mac OS X on 14-3-3.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface YaoyiyaoListModel : ITTBaseModelObject
@property (nonatomic, copy) NSString    *BusinessID;  //商家id
@property (nonatomic, copy) NSString    *Businesslogo;//商家图片
@property (nonatomic, copy) NSString    *BusinessMC; //商家名称
@property (nonatomic, copy) NSString    *BusinessDH; //商家电话
@property (nonatomic, copy) NSString    *BusinessDZ; //商家地址
@property (nonatomic, copy) NSString    *BusinessJYLX; //商家类型
@property (nonatomic, copy) NSString    *BusinessJL; //商家距离
@property (nonatomic, copy) NSString    *BusinessHDTP; //商家详情用到的广告图片
@property (nonatomic, copy) NSString    *BusinessBZ; //商家详情用到的描述
@end
