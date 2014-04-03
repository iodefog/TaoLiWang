//
//  RegistViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "RegistViewController.h"
#import "UserRegistRequest.h"
#import "PersonInformationViewController.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"
#import "AppDelegate.h"

@interface RegistViewController ()
/**
 *  注册用户信息输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *UserInfomationTextfield;
@property (weak, nonatomic) IBOutlet UITextField *PwdInformationTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *BackScollView;
@property (weak, nonatomic) IBOutlet UITextField *againPwdTextField;
@end

@implementation RegistViewController

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
-(void)startRegistRequestData
{
    if ([_UserInfomationTextfield.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"用户名不能为空!"];
        return;
    }
    if ([_PwdInformationTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"密码不能为空!"];
        return;
    }
    if ([_PwdInformationTextField.text length] <6) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"密码过于简单,存在风险~"];
        return;
    }
    if ([_againPwdTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"请在一次输入密码!"];
        return;
    }
    if (![_againPwdTextField.text isEqualToString:_PwdInformationTextField.text]) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"两次输入的密码不一致!"];
        return;
    }
//    if ([PhoneCode isNumberiCalWithString:_UserInfomationTextfield.text] == NO) {
//        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"用户名只能由数字、字母以及下划线组成,不包含其他格式的字符!"];
//        return;
//    }
    if ([_UserInfomationTextfield.text length] <6 ) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"用户名应由至少6个字符组成!"];
        return;
    }
    if ([PhoneCode isNumberiCalWithString:_PwdInformationTextField.text] == NO) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"密码只能由数字、字母以及下划线组成,不包含其他格式的字符!"];
        return;
    }

    if ([_againPwdTextField.text length] < 6) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"密码过于简单!"];
        return;
    }
    NSDictionary *param = @{@"userName":_UserInfomationTextfield.text,@"password":_againPwdTextField.text};
    [UserRegistRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            
            UserInfomationModel *model = [[UserInfomationModel alloc]init];
            model.UserId = request.handleredResult[@"result"];
            model.Password = _againPwdTextField.text;
            model.UserName = _UserInfomationTextfield.text;
            [SaveAndGetUserInformation saveUserDefaultsWithTheUserInformation:model];
            
            [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"温馨提示" message:@"注册成功!请完善资料" cancel:@"下次再说" others:@"立即完善"];
        }else{
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:request.handleredResult[@"msg"]];
        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}

#pragma mark
#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initIphone4Oriphone5];
}
-(void)initIphone4Oriphone5
{
    if (Screen_height == 480) {
        _BackScollView.contentSize = CGSizeMake(320, 474);
    }else{
        _BackScollView.contentSize = CGSizeMake(320, 564);
    }
}
#pragma mark
#pragma mark RegistButtonClick
- (IBAction)RegistButtonClick:(id)sender {
    [self startRegistRequestData];
}
#pragma mark
#pragma mark PopViewController
/**
 *  跳转都登录界面
 */
- (IBAction)PopLoginViewController:(id)sender {
    if (_HomeBootPage == YES) {
        [SharedApp showViewController:HOME_VIEW_CONTROLLER andIndex:0];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1002) {
        if (buttonIndex == 0) {
            [self.navigationController popToRootViewControllerAnimated:NO];
            [SharedApp showViewController:HOME_VIEW_CONTROLLER andIndex:0];
        }
        if (buttonIndex == 1) {
            PersonInformationViewController *pvc = [[PersonInformationViewController alloc]initWithNibName:@"PersonInformationViewController" bundle:nil];
            pvc.isRegistPush = YES;
            [self.navigationController pushViewController:pvc animated:YES];
        }
    }
}
- (IBAction)KeyboardHiddenClick:(id)sender {
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
#pragma mark
#pragma mark UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _againPwdTextField) {
        [UIView animateWithDuration:0.5 animations:^{
             _BackScollView.contentOffset = CGPointMake(0, 70);
        } completion:^(BOOL finished) {
            
        }];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _againPwdTextField) {
        [UIView animateWithDuration:0.5 animations:^{
           _BackScollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
      [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    return YES;
}
@end
