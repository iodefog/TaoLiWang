//
//  PromotionAdvertViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-14.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "PromotionAdvertViewController.h"
#import "PromotionDetailDataRequest.h"
#import "PromotionDetaileModel.h"
#import "LoadPromotionDataRequest.h"
#import "SaveAndGetUserInformation.h"
#import "UserInfomationModel.h"
#import "AppDelegate.h"

@interface PromotionAdvertViewController ()
@property (nonatomic, strong)ITTTabBarController                *ITTTabBarController;
@property (nonatomic, strong)PromotionDetaileModel              *ContentModel;
@property (nonatomic, strong)UserInfomationModel                *UserModel;
@property (nonatomic, strong)NSString                           *isComupCode;

@property (weak, nonatomic) IBOutlet ITTImageView               *ActivityImageView;
@property (weak, nonatomic) IBOutlet UILabel                    *ActivityLable;
@property (weak, nonatomic) IBOutlet UIButton                   *ActivityButton;
@property (weak, nonatomic) IBOutlet UIWebView                  *ActivityWebView;
@property (weak, nonatomic) IBOutlet UIScrollView               *BackScrollView;


@end

@implementation PromotionAdvertViewController

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
-(void)StartPromotionDetailRequest
{
    NSDictionary *param = @{@"id": self.ActivityId};
    [PromotionDetailDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        self.ContentModel = request.handleredResult[@"PromotionDetaileModel"];
        [self initView];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
-(void)StartLoadComup
{
    NSDictionary *param = @{@"id": self.ActivityId,
                            @"yhid": self.UserModel.UserId,
                            @"yhjpch": self.ContentModel.yhjpch};
    [LoadPromotionDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:request.handleredResult[@"msg"]];
        self.isComupCode = [request.handleredResult[@"code"]stringValue];
        
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
    
}
#pragma mark
#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.UserModel = [SaveAndGetUserInformation readUserDefaults];
    _ActivityWebView.scrollView.scrollEnabled = NO;
    [self StartPromotionDetailRequest];

}
#pragma mark
#pragma mark LoadingUI
-(void)initView
{
    [_ActivityImageView loadImage:self.ContentModel.tp];
    [_ActivityLable setText:self.ContentModel.wzbt];
    [_ActivityWebView setHidden:NO];
    //webView的背景颜色设置为透明
    [_ActivityWebView setOpaque:NO];
    [self WebViewLoading:self.ContentModel.wzlr];
}
-(void)WebViewLoading:(NSString *)str
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [path objectAtIndex:0];
    NSString *htmlPath = [filePath stringByAppendingPathComponent:@"test.html"];
    [fm createFileAtPath:htmlPath contents:nil attributes:nil];
    [str writeToFile:htmlPath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    NSString *htmlstring=[NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:NULL];
    [_ActivityWebView loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:htmlPath]];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //webView的高度
    NSString *string = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGRect frame = [webView frame];
    frame.size.height = [string floatValue]+10;
    [webView setFrame:frame];
    
    if ([self.ContentModel.sfyyhj isEqualToString:@"1"]) {
        if (iPhone5) {
            _BackScrollView.contentSize = CGSizeMake(320, frame.size.height+290);
            
        }else{
            _BackScrollView.contentSize = CGSizeMake(320, frame.size.height+380);
        }
        _ActivityButton.hidden = NO;
        _ActivityButton.frame = CGRectMake(10, frame.size.height+50, 300, 32);
    }
    else{
        if (iPhone5) {
            _BackScrollView.contentSize = CGSizeMake(320, frame.size.height+230);
            
        }else{
            _BackScrollView.contentSize = CGSizeMake(320, frame.size.height+325);
        }
        _ActivityButton.hidden = YES;
    }
}


#pragma mark
#pragma mark UIButtonCation
- (IBAction)popViewButtonClick:(id)sender {
    if (_isRootViewController == YES) {
        _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
        _ITTTabBarController.tabBarHidden = NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)DownLoadButtonClick:(id)sender {
    if ([self.UserModel.UserId length] == 0) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [SharedApp showViewController:LOGIN_VIEW_CONTROLLER andIndex:0];
        return;
    }
    [self StartLoadComup];
}
#pragma mark
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"ssss ===== %@",self.isComupCode);
    if ([self.isComupCode isEqualToString:@"1"]) {
        /**
         *  跳转到我的优惠
         */
        
    }
}
@end
