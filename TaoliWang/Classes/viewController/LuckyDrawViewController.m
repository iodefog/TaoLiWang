//
//  LuckyDrawViewController.m
//  TaoliWang
//
//  Created by zdqk on 14-1-8.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "LuckyDrawViewController.h"
#import "MyAwardDataRequest.h"
#import "JionAwardDataRequest.h"
#import "AwardDeatilModel.h"
#import "SaveAndGetUserInformation.h"
#import "UserInfomationModel.h"

@interface LuckyDrawViewController ()
@property (strong, nonatomic) AwardDeatilModel    *DataModel;
@end

@implementation LuckyDrawViewController
{
    __weak IBOutlet UIScrollView *BackScrollView;
    __weak IBOutlet ITTImageView *PhotoImageView;
    __weak IBOutlet UILabel *TitielLable;
    __weak IBOutlet UIWebView *ContentWebView;
    __weak IBOutlet UIButton *JionBtn;
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
#pragma mark StartViewRequest
-(void)StartRequest
{
    [MyAwardDataRequest requestWithParameters:nil withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        self.DataModel = request.handleredResult[@"AwardDeatilModel"];
        [self initUI];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
-(void)StartRequesJoin
{
    UserInfomationModel *model = [SaveAndGetUserInformation readUserDefaults];
    NSDictionary *param = @{@"yhid": model.UserId,
                            @"id":self.DataModel.awardID};
    [JionAwardDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            NSString *str = [NSString stringWithFormat:@"参加成功\n扣除积分:-%@",self.DataModel.awardjf];
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:nil message:str];
            [JionBtn setSelected:YES];
            [JionBtn setUserInteractionEnabled:NO];
        }
        if ([request.handleredResult[@"msg"] isEqualToString:@"已参与！"]) {
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"已参加"];
            [JionBtn setSelected:YES];
            [JionBtn setUserInteractionEnabled:NO];
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
    [self StartRequest];
}
-(void)initUI
{
    JionBtn.hidden = NO;
    ContentWebView.scrollView.scrollEnabled = NO;
    [PhotoImageView loadImage:self.DataModel.awardtp];
    TitielLable.text = self.DataModel.awardMc;
    [ContentWebView setHidden:NO];
    [ContentWebView setOpaque:NO];
    [self WebViewLoading:self.DataModel.awardxq];
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
    [ContentWebView loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:htmlPath]];
}
- (IBAction)JionButtonClik:(id)sender {
     UserInfomationModel *model = [SaveAndGetUserInformation readUserDefaults];
    if (model.UserId.length == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:@"您还没有登录"];
    }
    else if ([model.Point intValue] <= 100) {
        [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"温馨提示" message:@"您的积分不够!"];
    }else{
        [self StartRequesJoin];
    }
}



-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //webView的高度
    NSString *string = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGRect frame = [webView frame];
    frame.size.height = [string floatValue]+10;
    [webView setFrame:frame];
    
    if ([self.DataModel.awardsfykj isEqualToString:@"0"]) {
        JionBtn.selected = NO;
    }else{
        JionBtn.selected = YES;
    }
    if (iPhone5) {
        BackScrollView.contentSize = CGSizeMake(320, frame.size.height+260);
        
    }else{
        BackScrollView.contentSize = CGSizeMake(320, frame.size.height+350);
    }
    JionBtn.frame = CGRectMake(10, frame.size.height+170, 300, 35);
}
@end
