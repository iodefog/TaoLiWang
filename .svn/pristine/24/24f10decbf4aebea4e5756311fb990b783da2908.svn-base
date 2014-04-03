//
//  PhoneCode.m
//  ANgene
//
//  Created by Mac on 13-12-25.
//  Copyright (c) 2013年 lilinkai. All rights reserved.
//

#import "PhoneCode.h"

@implementation PhoneCode
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[0-1])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
/**
 *  邮箱验证
 *
 *  @param emailNum 要验证的字符串
 *
 *  @return 格式是否正确
 */
+(BOOL)isEmailNumber:(NSString *)emailNum
{
    NSString *emailRegex = @"^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w+)+)$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailNum];
}
/**
 *  年月日关联
 *
 *  @param year  年
 *  @param mouth 月
 *
 *  @return 大写的年月
 */
+(int)isDayNumberWithYear:(NSString *)year andMouth:(NSString *)mouth
{
    int _year =  [year intValue];
    if([mouth isEqualToString: @"01"] || [mouth isEqualToString: @"03"] || [mouth isEqualToString: @"05"] || [mouth isEqualToString: @"07"] || [mouth isEqualToString: @"08"] || [mouth isEqualToString: @"10"] || [mouth isEqualToString: @"12"]){
        return 31;
    }
    else if([mouth isEqualToString: @"04"] || [mouth isEqualToString: @"06"] || [mouth isEqualToString: @"09"]|| [mouth isEqualToString: @"11"]){
        return 30;
    }
    else([mouth isEqualToString: @"2"]);{
        if((_year%4==0 && _year%100!=0) || _year%400==0){
            return 29;
        }
        else{
            return 28;
        }
    }
}
/**
 *  字符串是否又数字和字母和下划线组成
 *
 *  @param string 验证的字符串
 *
 *  @return 返回是否正确与否
 */
+(BOOL)isNumberiCalWithString:(NSString *)string
{

    NSString *regex = @"^[A-Za-z_/n0-9]{0,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:string] == YES)
    {
        return YES;
    }
    else{
        return NO;
    }
}
/**
 *  通过数字年月 获得大写年月
 *
 *  @return 大写的年月
 */
+(NSString *)NumberChangeForChinese:(NSString *)str
{
    if([str isEqualToString:@"01"]){
        return @"一月";
    }
    if ([str isEqualToString:@"02"]) {
        return @"二月";
    }
    if ([str isEqualToString:@"03"]) {
        return @"三月";
    }
    if ([str isEqualToString:@"04"]) {
        return @"四月";
    }
    if ([str isEqualToString:@"05"]) {
        return @"五月";
    }
    if ([str isEqualToString:@"06"]) {
        return @"六月";
    }
    if ([str isEqualToString:@"07"]) {
        return @"七月";
    }
    if ([str isEqualToString:@"08"]) {
        return @"八月";
    }
    if ([str isEqualToString:@"09"]) {
        return @"九月";
    }
    if ([str isEqualToString:@"10"]) {
        return @"十月";
    }
    if ([str isEqualToString:@"11"]) {
        return @"十一月";
    }
    if ([str isEqualToString:@"12"]) {
        return @"十二月";
    }
    return nil;
}
/**
 *  邮编验证
 *
 *  @param str 邮编字符串
 *
 *  @return 是否格式正确
 */
+(BOOL)isZipCodeWithString:(NSString *)str{
    NSString *emailRegex = @"^[1-9][0-9]{5}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
}
@end
