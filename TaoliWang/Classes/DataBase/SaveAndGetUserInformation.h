//
//  SaveAndGetUserInformation.h
//  TaoliWang
//
//  Created by Mac OS X on 14-1-16.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfomationModel.h"
#import "DistributionInfoModel.h"

@interface SaveAndGetUserInformation : NSObject
+(void)saveUserDefaultsWithTheUserInformation:(UserInfomationModel *)userModel;
+(UserInfomationModel *)readUserDefaults;

+(void)SaveDistributionInfo:(DistributionInfoModel*)DisModel;
+(DistributionInfoModel *)readDistributionDefaults;

@end
