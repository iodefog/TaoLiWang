//
//  YaoyiyaoListModel.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-3.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "YaoyiyaoListModel.h"

@implementation YaoyiyaoListModel
-(NSDictionary *)attributeMapDictionary{
    return @{@"BusinessID":@"id",
             @"Businesslogo":@"logo",
             @"BusinessMC":@"mc",
             @"BusinessDH":@"dh",
             @"BusinessDZ":@"dz",
             @"BusinessJYLX":@"jylx",
             @"BusinessJL":@"jl",
             @"BusinessHDTP":@"hdtp",
             @"BusinessBZ":@"bz"};
}
@end
