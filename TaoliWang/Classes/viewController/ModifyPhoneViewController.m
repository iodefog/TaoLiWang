//
//  ModifyPhoneViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-20.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ModifyPhoneViewController.h"
#import "GetCodeDataRequest.h"
#import "ModifyPhoneDataRequest.h"
#import "SaveAndGetUserInformation.h"
#import "UserInfomationModel.h"
@interface ModifyPhoneViewController ()

@end

@implementation ModifyPhoneViewController
{
    __weak IBOutlet UITextField *PhoneTextField;
    __weak IBOutlet UITextField *CodeTextFied;
    __weak IBOutlet UIButton *CodeBtn;
    NSString            *phoneCode;
    UserInfomationModel *UserModel;

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
#pragma mark StartRequest
-(void)StartGetCodeRequest
{
    if ([PhoneTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请输入您的手机号码~"];
    return;
    }
    
    if (![PhoneCode isMobileNumber:PhoneTextField.text]) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请输入正确的手机号"];
        return;
    }
    NSDictionary *param = @{@"yhid": self.UserId,
                            @"bdsjh": PhoneTextField.text};
    [GetCodeDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
         [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"温馨提示" message:request.handleredResult[@"msg"]];
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            phoneCode = [request.handleredResult[@"result"]stringValue];
            [self getCountDown];
        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
    
}

-(void)StartRequestModifyPhone
{
    if ([PhoneTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请输入您的手机号码~"];
        return;
    }
    if ([PhoneCode isMobileNumber:PhoneTextField.text] == NO) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请输入正确的手机号"];
        return;
    }
    if (CodeTextFied.text.length == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"请输入验证码"];
        return;
    }
    
    NSLog(@"sss === %d",[CodeTextFied.text isEqualToString:phoneCode]);
    if ([CodeTextFied.text isEqualToString:phoneCode] == NO) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"验证码不正确"];
        return;
    }
    
    UserModel = [SaveAndGetUserInformation readUserDefaults];
    NSDictionary *param = @{@"yhid": self.UserId,
                            @"bdsjh": PhoneTextField.text};
    [ModifyPhoneDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
       
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            [UIAlertView popupAlertByDelegate:self andTag:1003 title:@"温馨提示" message:request.handleredResult[@"msg"]];
            //数据保存
            UserModel.Phone = PhoneTextField.text;
            [SaveAndGetUserInformation saveUserDefaultsWithTheUserInformation:UserModel];
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
- (IBAction)PopViewControllerClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)GetCodeButtonClick:(id)sender {
    [self StartGetCodeRequest];
}
- (IBAction)UITapGestureRecognizerClick:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    return YES;
}
- (IBAction)ComformButtonClick:(id)sender {
    [self StartRequestModifyPhone];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1003) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
                [CodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                CodeBtn.userInteractionEnabled = YES;
            });
        }
        else
        {
            int seconds = timeOut % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                [CodeBtn setTitle:[NSString stringWithFormat:@"%ds后重新发送",seconds] forState:UIControlStateNormal];
                CodeBtn.userInteractionEnabled = NO;

            });
            
        }
        timeOut --;
        
    });
    dispatch_resume(_timer);
    
}
@end
