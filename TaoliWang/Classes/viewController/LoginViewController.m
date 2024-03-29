//
//  LoginViewController.m
//  TaoliWang
//
//  Created by zdqk on 14-1-8.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ForgetPwdViewController.h"
#import "RegistViewController.h"
#import "UserLogRequest.h"
#import "DistributionLoginRequest.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"
#import "ThreeLoginDataRequest.h"
#import "ShareCommon.h"

@interface LoginViewController ()
/**
 *  用户切换按钮
 */
@property (weak, nonatomic) IBOutlet UIButton            *UserChangeButton;
@property (weak, nonatomic) IBOutlet UILabel             *UserChangeLable;
@property (weak, nonatomic) IBOutlet UILabel             *DistrubitorChangeLable;
@property (weak, nonatomic) IBOutlet UIButton            *DistrubitorChangeButton;
/**
 *  用户切换界面元素
 */
@property (weak, nonatomic) IBOutlet UIView              *NomalUserInformationView;
@property (weak, nonatomic) IBOutlet UIView              *DistrubitorUserInfomationView;
/**
 *  不同用户的textField
 */
@property (weak, nonatomic) IBOutlet UIButton             *RegistBUtton;
@property (weak, nonatomic) IBOutlet UITextField          *NomalUserTextField;
@property (weak, nonatomic) IBOutlet UITextField          *NomalPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField          *DistrubitorUserTextField;
@property (weak, nonatomic) IBOutlet UITextField          *DistrubitorPwdTextField;
/**
 *  用户信息model
 */
@property (nonatomic, strong) UserInfomationModel         *UserModel;
@property (nonatomic, strong) DistributionInfoModel       *DisModel;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.UserModel = [[UserInfomationModel alloc]init];
        self.DisModel = [[DistributionInfoModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma  mark -
#pragma mark LoginRequestData
/**
 *  普通用户登录接口请求
 *
 *  @param  NSDictionary
 *
 *  @return
 */
-(void)startLoginRequestData
{
    if ([_NomalUserTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:0 title:@"提示" message:@"请输入您的帐号,谢谢合作!"];
        return;
    }
//    if (![PhoneCode isNumberiCalWithString:_NomalUserTextField.text]) {
//        [UIAlertView popupAlertByDelegate:self andTag:0 title:@"提示" message:@"您输入的帐号有非法字符~"];
//        return;
//    }
    if ([_NomalPwdTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:0 title:@"提示" message:@"请输入您的密码,谢谢合作"];
        return;
    }
    if (![PhoneCode isNumberiCalWithString:_NomalPwdTextField.text]) {
        [UIAlertView popupAlertByDelegate:self andTag:0 title:@"提示" message:@"您输入的密码有非法字符~"];
        return;
    }

    NSDictionary *param = @{@"userName":_NomalUserTextField.text,
                            @"password":_NomalPwdTextField.text};
    [UserLogRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        [self setDataDic:request.handleredResult toManager:nil];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
- (void)setDataDic:(NSDictionary *)resultDic toManager:(NSMutableArray *)baseManager
{
    if ([[resultDic[@"code"]stringValue] isEqualToString:@"1"]) {
        /**
         *  保存用户信息
         */
        NSDictionary *dict = [resultDic objectForKey:@"result"];
        self.UserModel.Point = dict[@"jfye"];
        self.UserModel.UserName = dict[@"username"];
        self.UserModel.UserId = dict[@"yhid"];
        [SaveAndGetUserInformation saveUserDefaultsWithTheUserInformation:self.UserModel];
        [self dismissViewControllerAnimated:YES completion:^{}];
        [SharedApp showViewController:HOME_VIEW_CONTROLLER andIndex:0];
        return ;
    }
    [UIAlertView popupAlertByDelegate:self andTag:0 title:@"提示" message:@"您输入的密码或者帐号有误!"];
}
/**
 *  经销商登录接口请求
 *
 *  @param  NSDictionary
 *
 *  @return
 */
-(void)StartDistributionLoginRequest
{
    if ([_DistrubitorUserTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:0 title:@"提示" message:@"请输入您的帐号,谢谢合作!"];
        return;
    }
    if ([_DistrubitorPwdTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:0 title:@"提示" message:@"请输入您的密码,谢谢合作"];
        return;
    }
    NSDictionary *param = @{@"userName":_DistrubitorUserTextField.text,
                            @"password":_DistrubitorPwdTextField.text};
    [DistributionLoginRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        [self setDataDic:request.handleredResult];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];


}
- (void)setDataDic:(NSDictionary *)resultDic
{
    if ([[resultDic[@"code"]stringValue] isEqualToString:@"1"]) {
        /**
         *  保存用户信息
         */
        NSDictionary *dict = [resultDic objectForKey:@"result"];
        self.DisModel.DistributionId = dict[@"id"];
        self.DisModel.Phone = dict[@"sjh"];
        self.DisModel.mc = dict[@"mc"];
        self.DisModel.UserName = _DistrubitorUserTextField.text;
        [SaveAndGetUserInformation SaveDistributionInfo:self.DisModel];
        [self dismissViewControllerAnimated:YES completion:^{}];
        [SharedApp showViewController:DISTRIBUTOR_VIEW_CONTROLLER andIndex:0];
        return ;
    }
    [UIAlertView popupAlertByDelegate:self andTag:0 title:@"提示" message:@"您输入的密码或者帐号有误!"];
}

#pragma  mark -
#pragma mark UserNomalButtonAction
/**
 *  用户登录切换
 */
- (IBAction)NomalUserButtonClick:(id)sender {
    _UserChangeLable.textColor = [UIColor colorWithRed:245/255.0 green:126/255.0 blue:77/255.0 alpha:1.0];
    _DistrubitorChangeLable.textColor = [UIColor lightGrayColor];
    [_RegistBUtton setHidden:NO];
    [_NomalUserInformationView setHidden:NO];
    [_DistrubitorUserInfomationView setHidden:YES];
    _UserChangeButton.enabled = NO;
    _DistrubitorChangeButton.enabled = YES;
}
- (IBAction)DistrubitorUserButtonClick:(id)sender {
    _DistrubitorChangeLable.textColor = [UIColor colorWithRed:245/255.0 green:126/255.0 blue:77/255.0 alpha:1.0];
    _UserChangeLable.textColor = [UIColor lightGrayColor];
    [_RegistBUtton setHidden:YES];
    [_NomalUserInformationView setHidden:YES];
    [_DistrubitorUserInfomationView setHidden:NO];
    _UserChangeButton.enabled = YES;
    _DistrubitorChangeButton.enabled =NO;
}
#pragma  mark -
#pragma mark LoginForgetRegistBtnClick

/**
 *  登录注册忘记密码事件
 */
- (IBAction)ForgetPwdButtonClick:(id)sender {
    ForgetPwdViewController *fvc = [[ForgetPwdViewController alloc]initWithNibName:@"ForgetPwdViewController" bundle:nil];
    [self.navigationController pushViewController:fvc animated:YES];
    
}
- (IBAction)RegistButtonClick:(id)sender {
    RegistViewController *rvc = [[RegistViewController alloc]initWithNibName:@"RegistViewController" bundle:nil];
    [self.navigationController pushViewController:rvc animated:YES];
}
- (IBAction)LoginButtonClick:(id)sender {
    if (!isReachability){
        [UIAlertView popupAlertByDelegate:self andTag:0 title:@"提示" message:@"请先连接网络,谢谢合作!"];
        return;
    }
    [self startLoginRequestData];
}

#pragma  mark -
#pragma mark WeiboQQLoginBtnClick
/**
 *  微博和QQ登录
 */
- (IBAction)WeiBoLoginButtonClick:(id)sender {
    [ShareCommon SinaLoginWithDelegate:self];
}
- (IBAction)QQLoginButtonClick:(id)sender {
    [ShareCommon QQSpaceLoginWithDelegate:self];
}
- (IBAction)BackHomeButtonClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [SharedApp showViewController:HOME_VIEW_CONTROLLER andIndex:0];
}

#pragma  mark -
#pragma mark UserDistrubitorButtonAction

/**
 *  分销商登录
 */
- (IBAction)DitrubitorLoginButtonClick:(id)sender {
    if (!isReachability){
        [UIAlertView popupAlertByDelegate:self andTag:0 title:@"提示" message:@"请先连接网络,谢谢合作!"];
        return;
    }
    [self StartDistributionLoginRequest];
}
- (IBAction)DistrubitorForget:(id)sender {
    ForgetPwdViewController *fvc = [[ForgetPwdViewController alloc]initWithNibName:@"ForgetPwdViewController" bundle:nil];
    [self.navigationController pushViewController:fvc animated:YES];
}
/**
 *  键盘降落
 */
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
@end
