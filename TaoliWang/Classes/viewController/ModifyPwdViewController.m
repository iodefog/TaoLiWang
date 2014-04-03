//
//  ModifyPwdViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-20.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ModifyPwdViewController.h"
#import "PersonUpDatePwdRequest.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"

@interface ModifyPwdViewController ()
@property (nonatomic, strong)UserInfomationModel        *UserModel;
@end

@implementation ModifyPwdViewController

{
    __weak IBOutlet UIScrollView *BackScrollView;
    __weak IBOutlet UITextField *OldPwdTextField;
    __weak IBOutlet UITextField *NewPwdTextField;
    __weak IBOutlet UITextField *ComformPwdTextField;
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
    if ([OldPwdTextField.text length] == 0 ) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请输入旧密码!"];
        return;
    }
    if ([NewPwdTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请输入新的密码!"];
        return;
    }
    if ([ComformPwdTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请在输一次密码!"];
        return;
    }
    if ([NewPwdTextField.text length] <6) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"密码过于简单,存在风险~"];
        return;
    }
    if (![NewPwdTextField.text isEqualToString:ComformPwdTextField.text]) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"两次输入的密码不一致!"];
        return;
    }
    if ([PhoneCode isNumberiCalWithString:NewPwdTextField.text] == NO) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"密码只能由数字、字母以及下划线组成,不包含其他格式的字符!"];
        return;
    }
    self.UserModel = [SaveAndGetUserInformation readUserDefaults];
    NSDictionary    *param = @{@"yhid": self.UserModel.UserId,
                               @"oldmm": OldPwdTextField.text,
                               @"newmm": NewPwdTextField.text};
    [PersonUpDatePwdRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
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
- (IBAction)ComfirmButtonClick:(id)sender {
    [self startRequestData];
}
- (IBAction)UITapGestureRecognizerClick:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
- (IBAction)PopViewControllerClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark
#pragma mark UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == ComformPwdTextField) {
        [UIView animateWithDuration:0.5 animations:^{
            BackScrollView.contentOffset = CGPointMake(0, 70);
        } completion:^(BOOL finished) {
            
        }];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == ComformPwdTextField) {
        [UIView animateWithDuration:0.5 animations:^{
            BackScrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1002) {
         [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
