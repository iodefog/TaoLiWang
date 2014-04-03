//
//  DistributionInfoModel.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-6.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "DistributionInfoModel.h"

@implementation DistributionInfoModel
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.UserName forKey:@"member_UserName"];
    [aCoder encodeObject:self.Password forKey:@"member_Password"];
    [aCoder encodeObject:self.DistributionId forKey:@"member_DistributionId"];
    [aCoder encodeObject:self.Phone forKey:@"member_Phone"];
    [aCoder encodeObject:self.mc forKey:@"member_mc"];
}

/**
 *  反序列化
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.UserName = [aDecoder decodeObjectForKey:@"member_UserName"];
        self.Password = [aDecoder decodeObjectForKey:@"member_Password"];
        self.DistributionId = [aDecoder decodeObjectForKey:@"member_DistributionId"];
        self.Phone = [aDecoder decodeObjectForKey:@"member_Phone"];
        self.mc = [aDecoder decodeObjectForKey:@"member_mc"];
    }
    return self;
}

@end
