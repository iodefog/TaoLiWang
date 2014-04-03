//
//  ModifyEmailViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-20.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ModifyEmailViewController.h"
#import "PersonUpDateEmailRequest.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"

@interface ModifyEmailViewController ()
@property (nonatomic, strong)UserInfomationModel        *UserModel;
@end

@implementation ModifyEmailViewController
{

    __weak IBOutlet UITextField *EmailTextField;
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
    if ([EmailTextField.text length] == 0 ) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息提示" message:@"邮箱不能为空"];
        return;
    }
    if (![PhoneCode isEmailNumber:EmailTextField.text]) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息提示" message:@"邮箱格式不正确"];
        return;
    }
    self.UserModel = [SaveAndGetUserInformation readUserDefaults];
    NSDictionary    *param = @{@"yhid": self.UserModel.UserId,
                               @"email": EmailTextField.text};
    [PersonUpDateEmailRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            self.UserModel.Email = EmailTextField.text;
            [SaveAndGetUserInformation saveUserDefaultsWithTheUserInformation:self.UserModel];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息提示" message:request.handleredResult[@"msg"]];
        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)ConformButtonclik:(id)sender {
    [self startRequestData];
}
- (IBAction)PopViewControllerClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)UITapGestureRecognizerClick:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
