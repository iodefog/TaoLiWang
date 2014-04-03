//
//  AboutOursViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-6.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "AboutOursViewController.h"
#import "AboutOursDataRequest.h"

@interface AboutOursViewController ()
@property (strong, nonatomic)ITTTabBarController    *TabBarControl;
@end

@implementation AboutOursViewController
{

    __weak IBOutlet UIScrollView    *ContentScrollView;
    __weak IBOutlet UIWebView       *ContentWebView;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)StartRequest
{
    [AboutOursDataRequest requestWithParameters:nil
                                 withIndicatorView:self.view
                                 withCancelSubject:nil
                                    onRequestStart:
     ^(ITTBaseDataRequest *request){
         
     } onRequestFinished:^(ITTBaseDataRequest *request) {
         [self initUI:request.handleredResult[@"result"]];
     } onRequestCanceled:^(ITTBaseDataRequest *request) {
         
     } onRequestFailed:^(ITTBaseDataRequest *request) {
         
     }];
}
-(void)initUI:(NSString *)html
{
    /**
     *  把xml格式字符串写入test.html 在用webview 展示
     */
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [path objectAtIndex:0];
    NSString *htmlPath = [filePath stringByAppendingPathComponent:@"test.html"];
    [fm createFileAtPath:htmlPath contents:nil attributes:nil];
    [html writeToFile:htmlPath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    NSString *htmlstring=[NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:NULL];
    [ContentWebView loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:htmlPath]];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    ContentWebView.scrollView.scrollEnabled = NO;
    [self StartRequest];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //webView的高度
    NSString *string = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGRect frame = [webView frame];
    frame.size.height = [string floatValue]+10;
    [webView setFrame:frame];
    if (iPhone5) {
        ContentScrollView.contentSize = CGSizeMake(320, frame.size.height+160);
        
    }else{
        ContentScrollView.contentSize = CGSizeMake(320, frame.size.height+160+90);
    }
}

- (IBAction)popViewController:(id)sender {
    _TabBarControl = (ITTTabBarController*)self.tabBarController;
    _TabBarControl.tabBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
@end
