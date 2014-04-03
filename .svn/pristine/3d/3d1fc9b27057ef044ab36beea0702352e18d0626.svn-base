//
//  GetPointViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "GetPointViewController.h"
#import "ITTTabBarController.h"
#import "ScanningViewController.h"
#import "GetPointHelpViewController.h"
#import "GetPointTypeDataRequest.h"
#import "GetPointDataRequest.h"
#import "SaveAndGetUserInformation.h"
#import "UserInfomationModel.h"
#import "AppDelegate.h"

@interface GetPointViewController ()

@property (nonatomic, strong)ITTTabBarController        *ITTTabBarController;
@property (weak, nonatomic) IBOutlet UITextField        *CardPwdTextField;
@property (strong, nonatomic) UserInfomationModel       *UserModel;
@end

@implementation GetPointViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma amrk - 
#pragma mark DataRequest
//验证积分卡密
-(void)StartRequestPointType
{
    if ([_CardPwdTextField.text length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"请输入您的充值卡密码!"];
        return;
    }
    if ([_CardPwdTextField.text length]!= 16) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"您输入的充值密码格式有误!"];
        return;
    }
    NSDictionary *param = @{@"type":@"0",@"km":_CardPwdTextField.text};
    [GetPointTypeDataRequest requestWithParameters:param
                                 withIndicatorView:self.view
                                 withCancelSubject:nil
    onRequestStart:^(ITTBaseDataRequest *request) {

    } onRequestFinished:^(ITTBaseDataRequest *request) {
        NSDictionary *dict = request.handleredResult[@"result"];
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            
            [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"温馨提示" message:[NSString stringWithFormat:@"卡号:%@    \n积分:%@",dict[@"kh"],dict[@"jf"]] cancel:@"取消" others:request.handleredResult[@"msg"]];
            
        }else{
            
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:request.handleredResult[@"msg"] cancel:@"确认" others:nil];
        }

    } onRequestCanceled:^(ITTBaseDataRequest *request) {
    
    } onRequestFailed:^(ITTBaseDataRequest *request) {
    
    }];
}

//充值积分
-(void)startRequestPoint
{
    self.UserModel = [SaveAndGetUserInformation readUserDefaults];
    if ([self.UserModel.UserId length] == 0) {
        return;
    }
      NSDictionary *param = @{@"yhid":self.UserModel.UserId,@"km":_CardPwdTextField.text};
    [GetPointDataRequest requestWithParameters:param
                             withIndicatorView:self.view
                             withCancelSubject:nil
    onRequestStart:^(ITTBaseDataRequest *request) {
                                    
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]){
            [UIAlertView popupAlertByDelegate:self andTag:1003 title:@"温馨提示" message:request.handleredResult[@"msg"] cancel:@"返回" others:@"继续充值"];
        }else{
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:request.handleredResult[@"msg"]];
        }
       
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {

    }];
}
#pragma mark -
#pragma mark Submit
/**
 *  提交
 *
 *  @param sender
 */
- (IBAction)SubmitButtonClick:(id)sender {
    [self StartRequestPointType];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
#pragma mark -
#pragma mark Different top-up
/**
 *  充值方式
 */
- (IBAction)ScanningButoonClick:(id)sender {
    
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    ScanningViewController *svc = [[ScanningViewController alloc]initWithNibName:@"ScanningViewController" bundle:nil];
    svc.Scanning = isGetpoint;
    svc.TitleStr = @"积分扫码";
    [self.navigationController pushViewController:svc animated:YES];
}
#pragma mark - 
#pragma mark UialertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1002) {
        if (buttonIndex == 1) {
            [self startRequestPoint];
        }
    }
    else if (alertView.tag == 1003){
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
            [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        }
        if (buttonIndex == 1) {
            _CardPwdTextField.text = @"";
        }
    }
}

#pragma mark -
#pragma mark popViewController
- (IBAction)popHomeButtonClick:(id)sender {
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = NO;
    if (self.isHomePopToHere == YES) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (IBAction)GetPointHelpButtonCLick:(id)sender {
    GetPointHelpViewController *gvc = [[GetPointHelpViewController alloc]initWithNibName:@"GetPointHelpViewController" bundle:nil];
    [self.navigationController pushViewController:gvc animated:YES];
}
@end
