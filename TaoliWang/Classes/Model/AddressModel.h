//
//  AddressModel.h
//  TaoliWang
//
//  Created by Mac OS X on 14-2-18.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface AddressModel : ITTBaseModelObject
@property (nonatomic, copy) NSString            *Name;          //姓名
@property (nonatomic, copy) NSString            *AddressId;     //地址id
@property (nonatomic, copy) NSString            *Address;       //地址
@property (nonatomic, copy) NSString            *Province;      //省份代码
@property (nonatomic, copy) NSString            *Phone;         //手机号码
@property (nonatomic, copy) NSString            *ZipCode;       //邮编
@property (nonatomic, copy) NSString            *type;          //是否首选地址
@property (nonatomic, copy) NSString            *city;          //地区代码
@end
