//
//  AppDelegate.m
//  TaoliWang
//
//  Created by zdqk on 14-1-6.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "AppDelegate.h"
#import "NavViewController.h"
#import "ITTTabBarController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "ShopingCarViewController.h"
#import "MyDiscountViewController.h"
#import "PersonCenterViewController.h"
#import "LuckyDrawViewController.h"
#import "DistributorsViewController.h"
#import "BootPageViewController.h"
/**
 *  不同用户的model
*/
#import "DistributionInfoModel.h"
#import "SaveAndGetUserInformation.h"

///支付宝
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "PartnerConfig.h"

//分享
#import <ShareSDK/ShareSDK.h>
#import "ShareCommon.h"
#import "TimeObject.h"


@implementation AppDelegate

#pragma mark - public methods

/**
 *  出现的不同界面
 *
 *  @param BOOL
 *
 *  @return
 */
-(void)showViewController:(NSInteger)type andIndex:(int)index
{
    switch (type) {
        case LOGIN_VIEW_CONTROLLER:
        {
            LoginViewController *lvc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            NavViewController *nav = [[NavViewController alloc]initWithRootViewController:lvc];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
        }
            break;
        case HOME_VIEW_CONTROLLER:
        {
            NSMutableArray *viewControllers = [NSMutableArray array];
            
            HomeViewController *onevc = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
            NavViewController *oneav = [[NavViewController alloc] initWithRootViewController:onevc];
            oneav.navigationBarHidden = YES;
            [viewControllers addObject:oneav];
            
            ShopingCarViewController *twovc = [[ShopingCarViewController alloc] initWithNibName:@"ShopingCarViewController" bundle:nil];
            NavViewController *twoav = [[NavViewController alloc] initWithRootViewController:twovc];
            twoav.navigationBarHidden = YES;
            [viewControllers addObject:twoav];
            
            MyDiscountViewController *threevc = [[MyDiscountViewController alloc] initWithNibName:@"MyDiscountViewController" bundle:nil];
            NavViewController *threeav = [[NavViewController alloc] initWithRootViewController:threevc];
            threeav.navigationBarHidden = YES;
            [viewControllers addObject:threeav];
            
            PersonCenterViewController *fourvc = [[PersonCenterViewController alloc] initWithNibName:@"PersonCenterViewController" bundle:nil];
            NavViewController *fourav = [[NavViewController alloc] initWithRootViewController:fourvc];            fourav.navigationBarHidden = YES;
            [viewControllers addObject:fourav];
            
            LuckyDrawViewController *fivevc = [[LuckyDrawViewController alloc] initWithNibName:@"LuckyDrawViewController" bundle:nil];
            NavViewController *fiveav = [[NavViewController alloc] initWithRootViewController:fivevc];
            fiveav.navigationBarHidden = YES;
            [viewControllers addObject:fiveav];
            
            _tabBarController = [[ITTTabBarController alloc]init];
            _tabBarController.viewControllers = viewControllers;
            _tabBarController.selectedIndex = index;
            self.window.rootViewController = _tabBarController;

        }
            break;
        case DISTRIBUTOR_VIEW_CONTROLLER:
        {
            DistributorsViewController *dvc = [[DistributorsViewController alloc]initWithNibName:@"DistributorsViewController" bundle:nil];
            NavViewController *nav = [[NavViewController alloc]initWithRootViewController:dvc];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
        }
            break;
        default:
            break;
    }

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    

//    //打包事件
//    if (![self SenderlimitTime]) {
//        return NO;
//    }
    
    //注册SharSDK
    [ShareSDK registerApp:ShareSDKID];
    [ShareCommon initializePlat];
    [ShareCommon initializePlatForTrusteeship];
    
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"BootPage_key"]){
        //加载引导页
        if (iPhone5) {
            BootPageViewController *bvc = [[BootPageViewController alloc]initWithNibName:@"BootPageViewController01" bundle:nil];
            self.window.rootViewController = bvc;
        }else{
            BootPageViewController *bvc = [[BootPageViewController alloc]initWithNibName:@"BootPageViewController02" bundle:nil];
            self.window.rootViewController = bvc;
        }
    }else{
        //加载首页
        DistributionInfoModel *disModel = [SaveAndGetUserInformation readDistributionDefaults];
        if (disModel.DistributionId.length != 0) {
            [self showViewController:DISTRIBUTOR_VIEW_CONTROLLER andIndex:0];
        }else{
            [self showViewController:HOME_VIEW_CONTROLLER andIndex:0];
        }
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}


//打包使用期限限制
- (BOOL)SenderlimitTime{
    int timeDay5 = 7 * 24 * 60 * 60;
    NSString * strNewTime = [TimeObject currentTime];
    NSString * strTime = @"1396278345";
    NSLog(@"预计开始时间===%@",[TimeObject fromTimeChuoTotime:strTime]);
    NSLog(@"当前时间====%@",[TimeObject currentTime]);
    if ([strTime intValue] + timeDay5 <= [strNewTime intValue]) {
        [UIAlertView popupAlertByDelegate:self andTag:7000 title:@"温馨提示" message:@"超出有效期  不再正常使用"];
        NSLog(@"strNew超出有效期  不再正常使用");
        return NO;
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//淘宝独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([[url scheme] isEqualToString:@"TaoliWang"]) {
        [self parse:url
        application:application];;
    }else{
        [ShareSDK handleOpenURL:url
                     wxDelegate:self];
    }
	return YES;
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url scheme] isEqualToString:@"TaoliWang"]) {
        [self parse:url
        application:application];;
    }else{
        [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
    }
	return YES;
}


- (void)parse:(NSURL *)url application:(UIApplication *)application
{
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    NSLog(@"sss ==== %@",result);
	if (result)
    {
		if (result.statusCode == 9000)
        {
            //交易成功
            NSString* key = AlipayPubKey;
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            ///小额支付 无法验证 支付宝公钥
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccess"
                              object:nil
                            userInfo:nil];
            
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccess"
                                  object:nil
                                userInfo:nil];
			}
            
        }
        else
        {
            //交易失败
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PayFaild"
                              object:nil
                            userInfo:nil];
        }
    }
    else
    {
        //交易失败
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PayFaild"
                          object:nil
                        userInfo:nil];
    }
    
}
- (AlixPayResult *)resultFromURL:(NSURL *)url {
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return [[AlixPayResult alloc] initWithString:query];
}
- (AlixPayResult *)handleOpenURL:(NSURL *)url {
	AlixPayResult * result = nil;
	
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    
	return result;
}

@end
