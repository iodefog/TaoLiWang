//
//  UserInfomationModel.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-16.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "UserInfomationModel.h"

@implementation UserInfomationModel
//-(NSDictionary *)attributeMapDictionary
//{
//    return @{@"":@""};
//}

/**
 *  序列化
 */

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.UserName forKey:@"member_UserName"];
    [aCoder encodeObject:self.Password forKey:@"member_Password"];
    [aCoder encodeObject:self.UserId forKey:@"member_UserId"];
    [aCoder encodeObject:self.Email forKey:@"member_Email"];
    [aCoder encodeObject:self.Point forKey:@"member_Point"];
    [aCoder encodeObject:self.Phone forKey:@"member_Phone"];
}

/**
 *  反序列化
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.UserName = [aDecoder decodeObjectForKey:@"member_UserName"];
        self.Password = [aDecoder decodeObjectForKey:@"member_Password"];
        self.UserId = [aDecoder decodeObjectForKey:@"member_UserId"];
        self.Email = [aDecoder decodeObjectForKey:@"member_Email"];
        self.Point = [aDecoder decodeObjectForKey:@"member_Point"];
        self.Phone = [aDecoder decodeObjectForKey:@"member_Phone"];
    }
    return self;
}
@end
