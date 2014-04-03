//
//  TimeObject.h
//  FBSecond
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 hong. All rights reserved.
//



typedef NS_ENUM(NSInteger, CarHaveSameGoods) {
    CarHaveSameGoodsNomal = 0,
    CarHaveSameGoodsPoint,
    CarHaveSameGoodsMoney
};
#import <Foundation/Foundation.h>
@interface TimeObject : NSObject

/**
 *  从时间转换为时间戳
 */
+(NSString *)currentTime;

/**
 *  从时间戳转换为时间
 */
+(NSString *)fromTimeChuoTotime:(NSString *)timeChuo;

/**
 *  判断是否包含两种商品
 *
 *  @return 是否包含两种商品
 */
+(CarHaveSameGoods)isHaveTwoClassOfInCar:(NSString *)type;
@end
