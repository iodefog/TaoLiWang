//
//  DisDetailViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-6.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "DisDetailViewController.h"
#import "DisHomeDetailRequest.h"
#import "DisDetailModel.h"
@interface DisDetailViewController ()
@property (nonatomic ,strong)DisDetailModel         *DisModel;
@end

@implementation DisDetailViewController
{

    __weak IBOutlet UIScrollView *BackScrollView;
    __weak IBOutlet ITTImageView *TietleImageview;
    __weak IBOutlet UILabel *titelLable;
    __weak IBOutlet UIWebView *ContentWebView;

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
-(void)StartRequest
{
    NSDictionary *param = @{@"id": self.AdID};
    [DisHomeDetailRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        self.DisModel = request.handleredResult[@"DisDetailModel"];
        [self initUI];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
-(void)initUI
{
    [TietleImageview loadImage:self.DisModel.tp];
    [titelLable setText:self.DisModel.bt];
    [ContentWebView setHidden:NO];
    //webView的背景颜色设置为透明
    [ContentWebView setOpaque:NO];
    [self WebViewLoading:self.DisModel.jj];
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

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //webView的高度
    NSString *string = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGRect frame = [webView frame];
    frame.size.height = [string floatValue]+10;
    [webView setFrame:frame];
    if (iPhone5) {
        BackScrollView.contentSize = CGSizeMake(320, frame.size.height+200);
        
    }else{
        BackScrollView.contentSize = CGSizeMake(320, frame.size.height+200+90);
    }

}


#pragma mark
#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    ContentWebView.scrollView.scrollEnabled = NO;
    [self StartRequest];
}
- (IBAction)PopViewControllerClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
