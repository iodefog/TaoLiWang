//
//  PersonInformationDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-21.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "PersonInformationDataRequest.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"

@implementation PersonInformationDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = Person_Information_DataRequest;
    return url;
}


- (void)processResult
{
    [super processResult];
    NSDictionary *dict = self.handleredResult[@"result"];
    UserInfomationModel *model = [SaveAndGetUserInformation readUserDefaults];
    model.Point = dict[@"jfye"];
    model.UserId = dict[@"yhid"];
    model.UserName = dict[@"usernme"];
    model.Email = dict[@"email"];
    model.Phone = dict[@"bdsjh"];
    [self.handleredResult setObject:model forKey:@"UserInfomationModel"];
}
@end
