//
//  AppDelegate.h
//  TaoliWang
//
//  Created by zdqk on 14-1-6.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ITTTabBarController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow              *window;
-(void)showViewController:(NSInteger)type andIndex:(int)index;
@property (nonatomic, strong) ITTTabBarController   *tabBarController;
@end
