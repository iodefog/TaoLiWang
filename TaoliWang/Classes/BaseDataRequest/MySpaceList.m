//
//  MySpaceList.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MySpaceList.h"
#import "MySpaceModel.h"
@implementation MySpaceList
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = PERSON_MYSPACE_LIST_DATAREQUEST;
    return url;
}


- (void)processResult
{
    [super processResult];
    NSMutableArray *resultArr = [NSMutableArray array];
    NSMutableArray *Arr = [self.handleredResult objectForKey:@"result"];
    if (![Arr isEqual:[NSNull null]]) {
        for (id ob in Arr) {
            MySpaceModel *model = [[MySpaceModel alloc]initWithDataDic:ob];
            NSArray *arr = [self GetDayAndMouth:model.fbsj];
            model.Mouth = [PhoneCode NumberChangeForChinese:[arr objectAtIndex:1]];
            model.Day = [arr objectAtIndex:2];
            [resultArr addObject:model];
        }
    }
    [self.handleredResult setObject:resultArr forKey:@"MySpaceModel"];
}
-(NSArray *)GetDayAndMouth:(NSString *)str
{
    NSArray *arr;
    NSArray *arr01;
    arr = [str componentsSeparatedByString:@" "];
    arr01 = [[arr objectAtIndex:0] componentsSeparatedByString:@"-"];
    return arr01;
}
@end
