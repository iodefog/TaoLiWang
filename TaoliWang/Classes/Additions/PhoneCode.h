//
//  PhoneCode.h
//  ANgene
//
//  Created by Mac on 13-12-25.
//  Copyright (c) 2013年 lilinkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneCode : NSObject
+(BOOL)isMobileNumber:(NSString *)mobileNum;
+(BOOL)isEmailNumber:(NSString *)emailNum;
+(int)isDayNumberWithYear:(NSString*)year andMouth:(NSString *)mouth;
+(BOOL)isNumberiCalWithString:(NSString *)string;
+(NSString *)NumberChangeForChinese:(NSString *)str;
+(BOOL)isZipCodeWithString:(NSString *)str;
@end
