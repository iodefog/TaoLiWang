//
//  ForgetPwdViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "ForgetPwdByEmailDataRequest.h"
#import "ForgetPwdByPhoneDataRequest.h"
#import "GetPwdViewController.h"

@interface ForgetPwdViewController ()
/**
 *  通过不同方式找回密码
 */
@property (weak, nonatomic) IBOutlet UIButton *BySMSButton;
@property (weak, nonatomic) IBOutlet UIButton *ByEmailButton;
@property (weak, nonatomic) IBOutlet UILabel *ByPhoneLable;
@property (weak, nonatomic) IBOutlet UILabel *BySMSLable;


/**
 *  邮箱手机界面
 */
@property (weak, nonatomic) IBOutlet UIView *BySMSGetView;
@property (weak, nonatomic) IBOutlet UIView *ByEmailGetView;

/**
 *  邮箱验证码手机号输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *PhoneTetxField;
@property (weak, nonatomic) IBOutlet UITextField *CodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;

@property (copy, nonatomic)NSString              *PhoneCode;
@property (copy, nonatomic)NSString              *phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton    *CodeBtn;
@end

@implementation ForgetPwdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark
#pragma mark StartRquest
-(void)StartPwdPhoneDataRequest
{
    if ([_PhoneTetxField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请输入您的手机号码~"];
        return;
    }
    
    if (![PhoneCode isMobileNumber:_PhoneTetxField.text]) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请输入正确的手机号"];
        return;
    }
    NSDictionary *param = @{@"bdsjh": _PhoneTetxField.text};
    _phoneNumber = _PhoneTetxField.text;
    
    [ForgetPwdByPhoneDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
         [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"温馨提示" message:request.handleredResult[@"msg"]];
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            _PhoneCode = [request.handleredResult[@"result"]stringValue];
            [self getCountDown];
        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
-(void)StartPwdEmailDataRequest
{
    if ([_EmailTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请输入您的手机号码~"];
        return;
    }
    
    if (![PhoneCode isEmailNumber:_EmailTextField.text]) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请输入正确的邮箱"];
        return;
    }
    NSDictionary *param = @{@"email": _EmailTextField.text};
    [ForgetPwdByEmailDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
       
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
        [UIAlertView popupAlertByDelegate:self andTag:1003 title:@"温馨提示" message:@"发送成功,请到您的邮箱里面查收密码~"];
        }else{
             [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"温馨提示" message:request.handleredResult[@"msg"]];
        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
#pragma mark -
#pragma mark ByDifferent type GetPwd Button
- (IBAction)BySMSButtonClick:(id)sender {
    _ByPhoneLable.textColor = [UIColor colorWithRed:245/255.0 green:126/255.0 blue:77/255.0 alpha:1.0];
    _BySMSLable.textColor = [UIColor lightGrayColor];
    [_BySMSButton setEnabled:NO];
    [_ByEmailButton setEnabled:YES];
    [_BySMSGetView setHidden:NO];
    [_ByEmailGetView setHidden:YES];
    
}
- (IBAction)ByEmailButtonClick:(id)sender {
    _BySMSLable.textColor = [UIColor colorWithRed:245/255.0 green:126/255.0 blue:77/255.0 alpha:1.0];
    _ByPhoneLable.textColor = [UIColor lightGrayColor];
    [_BySMSButton setEnabled:YES];
    [_ByEmailButton setEnabled:NO];
    [_BySMSGetView setHidden:YES];
    [_ByEmailGetView setHidden:NO];
}

#pragma mark -
#pragma mark BySMSGetInformation
- (IBAction)GetCodeButtonClick:(id)sender {
    [self StartPwdPhoneDataRequest];
}
- (IBAction)SubmitSMSInfomation:(id)sender {
    if (_PhoneTetxField.text.length == 0) {
         [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请输入您的手机号"];
        return;
    }
    if (![PhoneCode isMobileNumber:_PhoneTetxField.text]) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请输入正确的手机号"];
        return;
    }
    if ([_PhoneCode isEqualToString:_CodeTextField.text] && [_PhoneTetxField.text isEqualToString:_phoneNumber]) {
        GetPwdViewController *gvc = [[GetPwdViewController alloc]initWithNibName:@"GetPwdViewController" bundle:nil];
        gvc.Phone = _phoneNumber;
        [self.navigationController pushViewController:gvc animated:YES];
    }else{
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"您输入的验证码不匹配"];
    }
    
}
- (IBAction)HiddenKeyboradClick:(id)sender {
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark -
#pragma mark ByEmailGetInformation
- (IBAction)SendEmailBtnClick:(id)sender {
    [self StartPwdEmailDataRequest];
}
#pragma mark -
#pragma mark AlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1003) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark -
#pragma mark PopViewController
/**
 *  跳转到登录界面
 */
- (IBAction)PopLoginViewControllerClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getCountDown
{
    __block int timeOut = 60;
    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER , 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeOut <= 0)
        {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_CodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _CodeBtn.userInteractionEnabled = YES;
                _PhoneCode = @"";
            });
        }
        else
        {
            int seconds = timeOut % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_CodeBtn setTitle:[NSString stringWithFormat:@"%ds后重新发送",seconds] forState:UIControlStateNormal];
                _CodeBtn.userInteractionEnabled = NO;
            });
            
        }
        timeOut --;
        
    });
    dispatch_resume(_timer);
    
}
@end
