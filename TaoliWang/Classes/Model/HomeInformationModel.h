//
//  HomeInformationModel.h
//  TaoliWang
//
//  Created by Mac OS X on 14-1-16.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface HomeInformationModel : ITTBaseModelObject
@property (nonatomic, copy) NSString            *type;    //图片类型*图片放置的地方*
@property (nonatomic, copy) NSString            *tpmc;    //图片名称
@property (nonatomic, copy) NSString            *lxdz;    //商品id;
@property (nonatomic, copy) NSString            *wzjs;    //商品介绍
@end
