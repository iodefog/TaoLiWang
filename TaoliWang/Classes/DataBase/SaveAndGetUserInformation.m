//
//  SaveAndGetUserInformation.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-16.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "SaveAndGetUserInformation.h"

@implementation SaveAndGetUserInformation
+(void)saveUserDefaultsWithTheUserInformation:(UserInfomationModel *)userModel{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userModel];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"userModel"];
    [defaults synchronize];
}
+(UserInfomationModel *)readUserDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"userModel"];
    UserInfomationModel *personal = (UserInfomationModel *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return personal;
}

+(void)SaveDistributionInfo:(DistributionInfoModel *)DisModel
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:DisModel];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"DisModel"];
    [defaults synchronize];
}

+(DistributionInfoModel *)readDistributionDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"DisModel"];
    DistributionInfoModel *personal = (DistributionInfoModel *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return personal;
}
@end
