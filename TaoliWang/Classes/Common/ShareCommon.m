//
//  ShareCommon.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-10.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ShareCommon.h"
#import "ThreeLoginDataRequest.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <SinaWeiboConnection/SinaWeiboConnection.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import <QZoneConnection/QZoneConnection.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@implementation ShareCommon
//初始化
+(void)initializePlat
{
    //sina
    [ShareSDK connectSinaWeiboWithAppKey:SinaAppKey appSecret:SinaAPPSecret redirectUri:SinaUrl];
    
    //微信
    [ShareSDK connectWeChatTimelineWithAppId:WXAppID wechatCls:[WXApi class]];
    
    //QQ空间
    [ShareSDK connectQZoneWithAppKey:QQAppKey appSecret:QQAppSecret qqApiInterfaceCls:[QQApiImageObject class] tencentOAuthCls:[TencentOAuth class]];
}
+(void)initializePlatForTrusteeship{
    
    //微信
    [ShareSDK importWeChatClass:[WXApi class]];
    
    //QQ空间
    [ShareSDK importQQClass:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
}


//分享
+(void)SinaShareWithContent:(NSString *)content
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon_80x80" ofType:@"png"];

    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:content
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"淘礼网,你的选择"
                                                  url:@"http://www.taoli.com.cn"
                                          description:content
                                            mediaType:SSPublishContentMediaTypeNews];
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:NO scopes:nil powerByHidden:YES followAccounts:nil authViewStyle:SSAuthViewStyleFullScreenPopup viewDelegate:nil authManagerViewDelegate:nil];
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeSinaWeibo
               authOptions:authOptions
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        NSString *msg = nil;
                        if (state == SSResponseStateSuccess)
                        {
                            msg = @"分享成功";
                        }
                        else if (state == SSResponseStateFail)
                        {
                            NSLog(@"sss == %d",[error errorCode]);
                            switch ([error errorCode])
                            {
                                    
                                case 20019:
                                    msg = @"已分享";
                                    break;
                                    
                                default:
                                    msg = [NSString stringWithFormat:@"分享失败:%@", error.errorDescription];
                                    break;
                            }
                        }
                        if (msg)
                        {
                            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:msg];
                        }
    }];
    
}


+(void)WeixinShareWithContent:(NSString *)content
{
    if (![WXApi isWXAppInstalled]) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"您还没有安装微信客服端~"];
        return;
    }
    //构造分享内容
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon_80x80" ofType:@"png"];
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:content
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:content
                                                  url:@"http://www.taoli.com.cn"
                                          description:content
                                            mediaType:SSPublishContentMediaTypeNews];
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:NO scopes:nil powerByHidden:YES followAccounts:nil authViewStyle:SSAuthViewStyleFullScreenPopup viewDelegate:nil authManagerViewDelegate:nil];
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeWeixiTimeline
               authOptions:authOptions statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        NSString *msg = nil;
                        if (state == SSResponseStateSuccess)
                        {
                            msg = @"分享成功";
                        }
                        else if (state == SSResponseStateFail)
                        {
                            msg = [NSString stringWithFormat:@"分享失败:%@", error.errorDescription];
                        }
                        if (msg)
                        {
                            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:msg];
                        }
    }];
    

}

+(void)QQSpaceShareWithContent:(NSString *)content
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon_80x80" ofType:@"png"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:content
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"淘礼网,你的选择"
                                                  url:@"http://www.taoli.com.cn"
                                          description:content
                                           mediaType:SSPublishContentMediaTypeNews];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:NO scopes:nil powerByHidden:YES followAccounts:nil authViewStyle:SSAuthViewStyleFullScreenPopup viewDelegate:nil authManagerViewDelegate:nil];
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeQQSpace
               authOptions:authOptions statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        NSString *msg = nil;
                        if (state == SSResponseStateSuccess)
                        {
                            msg = @"分享成功";
                        }
                        else if (state == SSResponseStateFail)
                        {
                            msg = [NSString stringWithFormat:@"分享失败:%@", error.errorDescription];
                        }
                        if (msg)
                        {
                            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:msg];
                        }
                    }];
    

}


+(void)SinaLoginWithDelegate:(id)delegate
{
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:NO scopes:nil powerByHidden:YES followAccounts:nil authViewStyle:SSAuthViewStyleFullScreenPopup viewDelegate:nil authManagerViewDelegate:nil];
    
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
                      authOptions:authOptions
                           result:
     ^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
         if (result) {
             NSDictionary *param = @{@"userName":[userInfo uid],
                                         @"type":@"006",
                                     @"nickName":[userInfo nickname]};
             [ThreeLoginDataRequest requestWithParameters:param
                                        withIndicatorView:nil
                                        withCancelSubject:nil
                                           onRequestStart:
              ^(ITTBaseDataRequest *request) {
                 
             } onRequestFinished:^(ITTBaseDataRequest *request) {
                 
                 /**
                  *  保存用户信息
                  */
                 if (delegate) {
                     if ([delegate isKindOfClass:[LoginViewController class]]) {
                         [(LoginViewController *)delegate setDataDic:request.handleredResult toManager:nil];
                     }
                 }

//                 if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]){
//                     UserInfomationModel *model = [SaveAndGetUserInformation readUserDefaults];
//                     NSDictionary *dict = [request.handleredResult objectForKey:@"result"];
//                     model.Point = dict[@"jfye"];
//                     model.UserName = dict[@"username"];
//                     model.UserId = dict[@"yhid"];
//                     [SaveAndGetUserInformation saveUserDefaultsWithTheUserInformation:model];
//                     [SharedApp showViewController:HOME_VIEW_CONTROLLER andIndex:0];
//
//                 }
             } onRequestCanceled:^(ITTBaseDataRequest *request) {
                 
             } onRequestFailed:^(ITTBaseDataRequest *request) {
                 
             }];
             
             
             
         }
         else{
             NSString *str = [NSString stringWithFormat:@"登录失败:%@",error.errorDescription];
             [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"温馨提示" message:str];
             [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
         }
        
    }];
}

+(void)QQSpaceLoginWithDelegate:(id)delegate{

    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:NO scopes:nil powerByHidden:YES followAccounts:nil authViewStyle:SSAuthViewStyleFullScreenPopup viewDelegate:nil authManagerViewDelegate:nil];
    
    [ShareSDK getUserInfoWithType:ShareTypeQQSpace
                      authOptions:authOptions
                           result:
     ^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
         if (result) {
             NSDictionary *param = @{@"userName":[userInfo uid],
                                     @"type":@"005",
                                     @"nickName":[userInfo nickname]};
             [ThreeLoginDataRequest requestWithParameters:param
                                        withIndicatorView:nil
                                        withCancelSubject:nil
                                           onRequestStart:
              ^(ITTBaseDataRequest *request) {
                  
              } onRequestFinished:^(ITTBaseDataRequest *request) {
                  
                  /**
                   *  保存用户信息
                   */
                  if (delegate) {
                      if ([delegate isKindOfClass:[LoginViewController class]]) {
                          [(LoginViewController *)delegate setDataDic:request.handleredResult toManager:nil];
                      }
                  }
                  
//                  if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]){
//                      UserInfomationModel *model = [SaveAndGetUserInformation readUserDefaults];
//                      NSDictionary *dict = [request.handleredResult objectForKey:@"result"];
//                      model.Point = dict[@"jfye"];
//                      model.UserName = dict[@"username"];
//                      model.UserId = dict[@"yhid"];
//                      [SaveAndGetUserInformation saveUserDefaultsWithTheUserInformation:model];
//                      [SharedApp showViewController:HOME_VIEW_CONTROLLER andIndex:0];
//                  }
              } onRequestCanceled:^(ITTBaseDataRequest *request) {
                  
              } onRequestFailed:^(ITTBaseDataRequest *request) {
                  
              }];
             
             
             
         }
         else{
             NSString *str = [NSString stringWithFormat:@"登录失败:%@",error.errorDescription];
             [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:str];
             [ShareSDK cancelAuthWithType:ShareTypeQQ];
         }
         
     }];
}
@end
