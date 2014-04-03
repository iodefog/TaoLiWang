//
//  SetViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-6.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "SetViewController.h"
#import "FeedBackViewController.h"
#import "AboutOursViewController.h"
#import "SaveAndGetUserInformation.h"
#import "DistributionInfoModel.h"
#import "AppDelegate.h"
#import "DeviecInfoDataRequest.h"
#import "FeedBackViewController.h"
#import "AboutOursViewController.h"

@interface SetViewController ()
@property (nonatomic, strong)DistributionInfoModel          *DisModel;
@property (nonatomic, copy) NSString                        *UpdateUrl;
@end

@implementation SetViewController

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
    NSDictionary *param = @{@"yhid": self.DisModel.DistributionId,
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

#pragma mark
#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.DisModel = [SaveAndGetUserInformation readDistributionDefaults];
}
- (IBAction)BackBtnClick:(id)sender {
    [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"确定要退出吗？" cancel:@"取消" others:@"确定"];
}

- (IBAction)popViewControllerClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)FeedbackBtnClick:(id)sender {
    FeedBackViewController *fvc = [[FeedBackViewController alloc]initWithNibName:@"FeedBackViewController" bundle:nil];
    fvc.UserId = self.DisModel.DistributionId;
    [self.navigationController pushViewController:fvc animated:YES];
    
}

- (IBAction)SoftWareBtnClick:(id)sender {
    [self startRequest];
}

- (IBAction)AboutOursBtnClick:(id)sender {
    AboutOursViewController *fvc = [[AboutOursViewController alloc]initWithNibName:@"AboutOursViewController" bundle:nil];
    [self.navigationController pushViewController:fvc animated:YES];
}
#pragma mark -
#pragma mark UIAlerteViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
        if (buttonIndex == 1) {
            self.DisModel.DistributionId = @"";
            self.DisModel.UserName = @"";
            self.DisModel.Password = @"";
            self.DisModel.mc = @"";
            self.DisModel.Phone = @"";
            [SaveAndGetUserInformation SaveDistributionInfo:self.DisModel];
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
