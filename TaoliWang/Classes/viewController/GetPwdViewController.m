//
//  GetPwdViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-11.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "GetPwdViewController.h"
#import "ModifyPwdDataRequest.h"
@interface GetPwdViewController ()

@end

@implementation GetPwdViewController
{
    __weak IBOutlet UITextField *PwdTextField;
    __weak IBOutlet UITextField *AgainPwdTextField;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)startRequest
{
    if ([PwdTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"密码不能为空~"];
        return;
    }
    if ([AgainPwdTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"再一次输入密码不能为空"];
        return;
    }
    if ([PwdTextField.text length] <6) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"密码过于简单,存在风险~"];
        return;
    }
    if ([PwdTextField.text isEqualToString:AgainPwdTextField.text] == NO) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"两次输入的密码不一致"];
        return;
    }
    if ([PhoneCode isNumberiCalWithString:PwdTextField.text] == NO && [PhoneCode isNumberiCalWithString:AgainPwdTextField.text] == NO) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"密码只能由数字、字母以及下划线组成,不包含其他格式的字符!"];
        return;
    }
    NSDictionary *param = @{@"bdsjh":self.Phone,
                            @"newmm":AgainPwdTextField.text};
    [ModifyPwdDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"温馨提示" message:request.handleredResult[@"msg"]];
        }else{
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:request.handleredResult[@"msg"]];
        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (IBAction)SendInfomationAction:(id)sender {
    [self startRequest];
}

- (IBAction)PopViewControllerAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1002) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (IBAction)KeyboardHiddenClick:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    return YES;
}
@end
