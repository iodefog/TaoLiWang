//
//  PersonCenterViewController.m
//  TaoliWang
//
//  Created by zdqk on 14-1-8.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "AppDelegate.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"

#import "MyPayCountViewController.h"
#import "SearchPointViewController.h"
#import "MySpaceViewController.h"
#import "YaoYiYaoViewController.h"
#import "PersonInformationViewController.h"
#import "EditorAddressViewController.h"
#import "MyOffersViewController.h"
#import "FeedBackViewController.h"
#import "AboutOursViewController.h"
#import "DeviecInfoDataRequest.h"
#import <ShareSDK/ShareSDK.h>

@interface PersonCenterViewController ()
/**
 *  UinaVigation
 */
@property (weak, nonatomic) IBOutlet UIButton       *LoginBtn;
@property (weak, nonatomic) IBOutlet UIScrollView   *BackScrollView;
@property (strong, nonatomic)ITTTabBarController    *TabBarControl;
@property (strong, nonatomic)UserInfomationModel    *UserModel;
@property (nonatomic, copy) NSString                *UpdateUrl;
@end



@implementation PersonCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark -
#pragma mark StartRequest
-(void)startRequest
{
    NSDictionary *param = @{@"yhid": self.UserModel.UserId,
                            @"bbxx": SoftWare_Info};
    [DeviecInfoDataRequest requestWithParameters:param
                               withIndicatorView:self.view
                               withCancelSubject:nil
                                  onRequestStart:
     ^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            self.UpdateUrl = [request.handleredResult[@"result"] objectForKey:@"xzlj"];
            [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"提示" message:request.handleredResult[@"msg"] cancel:@"下次再说" others:@"立即更新"];
        }else{
            [UIAlertView popupAlertByDelegate:self andTag:1003 title:@"提示" message:@"您现在正在使用最新版本"];
        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}

#pragma mark -
#pragma mark ViewDidLoad
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.UserModel.UserId length] == 0) {
        [_LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
        
    }else
    {
        [_LoginBtn setTitle:@"退出" forState:UIControlStateNormal];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!iPhone5) {
        _BackScrollView.contentSize = CGSizeMake(320, 594);
    }
    self.UserModel = [SaveAndGetUserInformation readUserDefaults];
}

#pragma mark -
#pragma mark BtnAction
-(void)mgsShow
{
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    [ITTMessageView showMessage01:@"您还没有登录哦~" disappearAfterTime:1.0 andView:view];
}
- (IBAction)MyDisCountButtonClick:(id)sender {

    if ([self.UserModel.UserId length] == 0) {
        [self mgsShow];
        return;
    }
    _TabBarControl = (ITTTabBarController*)self.tabBarController;
    _TabBarControl.tabBarHidden = YES;
    MyPayCountViewController *mvc= [[MyPayCountViewController alloc]initWithNibName:@"MyPayCountViewController" bundle:nil];
    mvc.UserId = self.UserModel.UserId;
    [self.navigationController pushViewController:mvc animated:YES];
}
- (IBAction)MyOffers:(id)sender {
    if ([self.UserModel.UserId length] == 0) {
        [self mgsShow];
        return;
    }
    _TabBarControl = (ITTTabBarController*)self.tabBarController;
    _TabBarControl.tabBarHidden = YES;
    MyOffersViewController *mvc = [[MyOffersViewController alloc]initWithNibName:@"MyOffersViewController" bundle:nil];
    mvc.UserId = self.UserModel.UserId;
    [self.navigationController pushViewController:mvc animated:YES];
}
- (IBAction)MyPointSearch:(id)sender {
    if ([self.UserModel.UserId length] == 0) {
        [self mgsShow];
        return;
    }
    _TabBarControl = (ITTTabBarController *)self.tabBarController;
    _TabBarControl.tabBarHidden = YES;
    SearchPointViewController *svc = [[SearchPointViewController alloc]initWithNibName:@"SearchPointViewController" bundle:nil];
    svc.UserID = self.UserModel.UserId;
    [self.navigationController pushViewController:svc animated:YES];
}

- (IBAction)MySpaceButtonClick:(id)sender {
    if ([self.UserModel.UserId length] == 0) {
        [self mgsShow];
        return;
    }
    _TabBarControl = (ITTTabBarController*)self.tabBarController;
    _TabBarControl.tabBarHidden = YES;
    MySpaceViewController *mvc= [[MySpaceViewController alloc]initWithNibName:@"MySpaceViewController" bundle:nil];
    mvc.UserId = self.UserModel.UserId;
    mvc.userName = self.UserModel.UserName;
    [self.navigationController pushViewController:mvc animated:YES];
}
- (IBAction)YaoyiyaoButtonClick:(id)sender {
    if ([self.UserModel.UserId length] == 0) {
        [self mgsShow];
        return;
    }
    _TabBarControl = (ITTTabBarController*)self.tabBarController;
    _TabBarControl.tabBarHidden = YES;
    YaoYiYaoViewController *mvc= [[YaoYiYaoViewController alloc]initWithNibName:@"YaoYiYaoViewController" bundle:nil];
    mvc.isHiddenTabBar = YES;
    mvc.UserId = self.UserModel.UserId;
    [self.navigationController pushViewController:mvc animated:YES];
}
- (IBAction)InformationGetButtonClick:(id)sender {
    if ([self.UserModel.UserId length] == 0) {
        [self mgsShow];
        return;
    }
    _TabBarControl = (ITTTabBarController*)self.tabBarController;
    _TabBarControl.tabBarHidden = YES;
    PersonInformationViewController *pvc = [[PersonInformationViewController alloc]initWithNibName:@"PersonInformationViewController" bundle:nil];
    pvc.isRegistPush = NO;
    [self.navigationController pushViewController:pvc animated:YES];
    
}
- (IBAction)sendInfomationButtonClick:(id)sender {
    if ([self.UserModel.UserId length] == 0) {
        [self mgsShow];
        return;
    }
    _TabBarControl = (ITTTabBarController*)self.tabBarController;
    _TabBarControl.tabBarHidden = YES;
    EditorAddressViewController *pvc = [[EditorAddressViewController alloc]initWithNibName:@"EditorAddressViewController" bundle:nil];
    pvc.isPerson = YES;
    [self.navigationController pushViewController:pvc animated:YES];
}
- (IBAction)feedbackButtonClick:(id)sender {
    if ([self.UserModel.UserId length] == 0) {
        [self mgsShow];
        return;
    }
    _TabBarControl = (ITTTabBarController*)self.tabBarController;
    _TabBarControl.tabBarHidden = YES;
    FeedBackViewController *fvc = [[FeedBackViewController alloc]initWithNibName:@"FeedBackViewController" bundle:nil];
    fvc.UserId = self.UserModel.UserId;
    [self.navigationController pushViewController:fvc animated:YES];
}
- (IBAction)RuanjianButtonClick:(id)sender {
    if ([self.UserModel.UserId length] == 0) {
        [self mgsShow];
        return;
    }
    [self startRequest];
}
- (IBAction)AboutsUsButtonClick:(id)sender {
    _TabBarControl = (ITTTabBarController*)self.tabBarController;
    _TabBarControl.tabBarHidden = YES;
    AboutOursViewController *fvc = [[AboutOursViewController alloc]initWithNibName:@"AboutOursViewController" bundle:nil];
    [self.navigationController pushViewController:fvc animated:YES];
}
#pragma mark -
#pragma mark PopViewController
- (IBAction)PopViewControllerButtonClick:(id)sender {
    
    if ([self.UserModel.UserId length] == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [SharedApp showViewController:LOGIN_VIEW_CONTROLLER andIndex:0];
    }else
    {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"确定要退出吗？" cancel:@"取消" others:@"确定"];
    }

}

#pragma mark -
#pragma mark UIAlerteViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
        if (buttonIndex == 1) {
            self.UserModel.UserId = @"";
            self.UserModel.UserName = @"";
            self.UserModel.Password = @"";
            self.UserModel.Point = @"";
            self.UserModel.Phone = @"";
            self.UserModel.Email = @"";
            [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
            [ShareSDK cancelAuthWithType:ShareTypeQQ];
            [SaveAndGetUserInformation saveUserDefaultsWithTheUserInformation:self.UserModel];
            [self.navigationController popToRootViewControllerAnimated:NO];
            [SharedApp showViewController:LOGIN_VIEW_CONTROLLER andIndex:0];
        }
    }
    if (alertView.tag == 1002) {
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.UpdateUrl]];
        }
    }
}

@end
