//
//  SubManagerViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-14.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "SubManagerViewController.h"
#import "MySubscriptionsDetailtDataRequest.h"
#import "MySubMangeDetailModel.h"

@interface SubManagerViewController ()
@property (nonatomic, strong)ITTTabBarController                *ITTTabBarController;
@property (weak, nonatomic) IBOutlet UIScrollView               *BackScrollview;
@property (weak, nonatomic) IBOutlet ITTImageView               *ActivityImageView;
@property (weak, nonatomic) IBOutlet UILabel                    *ActivityLable;
@property (weak, nonatomic) IBOutlet UIWebView                  *ActivityWebView;
@property (strong, nonatomic) MySubMangeDetailModel             *DataModel;

@end

@implementation SubManagerViewController

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
    NSDictionary *param = @{@"id": self.SubScriptionId};
    [MySubscriptionsDetailtDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        self.DataModel = request.handleredResult[@"MySubMangeDetailModel"];
        [self initUI];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
-(void)initUI
{
    [_ActivityImageView loadImage:self.DataModel.tp];
    [_ActivityLable setText:self.DataModel.wzbt];
    [_ActivityWebView setHidden:NO];
    [_ActivityWebView setOpaque: NO];
    [self WebViewLoading:self.DataModel.wzlr];
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
    
    if (iPhone5) {
        _BackScrollview.contentSize = CGSizeMake(320, frame.size.height+200);
        
    }else{
        _BackScrollview.contentSize = CGSizeMake(320, frame.size.height+200+90);
    }

}


#pragma mark
#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self StartRequest];
        dispatch_async(dispatch_get_main_queue(), ^{
            _ActivityWebView.scrollView.scrollEnabled = NO;
        });
    });
}
#pragma mark - 
#pragma mark NavigationButtonAction
- (IBAction)popViewButtonClick:(id)sender {
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}


@end
