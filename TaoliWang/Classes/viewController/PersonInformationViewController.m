//
//  PersonInformationViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-20.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "PersonInformationViewController.h"
#import "PersonInformationDataRequest.h"
#import "ModifyEmailViewController.h"
#import "ModifyPhoneViewController.h"
#import "ModifyPwdViewController.h"
#import "AppDelegate.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"
@interface PersonInformationViewController ()
@property (strong, nonatomic)ITTTabBarController    *TabBarControl;
@property (strong, nonatomic)UserInfomationModel    *UserModel;
@end

@implementation PersonInformationViewController
{
    __weak IBOutlet UILabel *PhoneLable;
    __weak IBOutlet UILabel *EmailLable;
    __weak IBOutlet UILabel *UserNameLabel;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark
#pragma StartRequest
-(void)startRequestData
{
    self.UserModel = [SaveAndGetUserInformation readUserDefaults];
    NSDictionary    *param = @{@"yhid": self.UserModel.UserId};
    [PersonInformationDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        self.UserModel = request.handleredResult[@"UserInfomationModel"];
        [SaveAndGetUserInformation saveUserDefaultsWithTheUserInformation:self.UserModel];
        PhoneLable.text = self.UserModel.Phone;
        EmailLable.text = self.UserModel.Email;
        if ([request.handleredResult[@"result"] isKindOfClass:[NSDictionary class]]) {
            UserNameLabel.text = request.handleredResult[@"result"][@"username"];
        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.UserModel = [SaveAndGetUserInformation readUserDefaults];
    PhoneLable.text = self.UserModel.Phone;
    EmailLable.text = self.UserModel.Email;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startRequestData];

}
- (IBAction)PhoneButtonClick:(id)sender {
    ModifyPhoneViewController *pvc = [[ModifyPhoneViewController alloc]initWithNibName:@"ModifyPhoneViewController" bundle:nil];
    pvc.UserId = self.UserModel.UserId;
    [self.navigationController pushViewController:pvc animated:YES];
}
- (IBAction)emailButtonClick:(id)sender {
    ModifyEmailViewController *pvc = [[ModifyEmailViewController alloc]initWithNibName:@"ModifyEmailViewController" bundle:nil];
    [self.navigationController pushViewController:pvc animated:YES];
}
- (IBAction)pwdButtonClick:(id)sender {
    ModifyPwdViewController *pvc = [[ModifyPwdViewController alloc]initWithNibName:@"ModifyPwdViewController" bundle:nil];
    [self.navigationController pushViewController:pvc animated:YES];
}
- (IBAction)popViewControllerClick:(id)sender {
    if (_isRegistPush == NO) {
        _TabBarControl = (ITTTabBarController*)self.tabBarController;
        _TabBarControl.tabBarHidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
        [SharedApp showViewController:HOME_VIEW_CONTROLLER andIndex:0];
    }
}

@end
