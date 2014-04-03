//
//  FeedBackViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-6.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "FeedBackViewController.h"
#import "FeedBackRequest.h"

#define DefautText @"请输入您对我们的建议..."

@interface FeedBackViewController ()
@property (strong, nonatomic)ITTTabBarController    *TabBarControl;
@end

@implementation FeedBackViewController
{

    __weak IBOutlet UITextView *ContentTextView;
}
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
    NSString *str = [ContentTextView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ||[ContentTextView.text isEqualToString:DefautText]) {
        ContentTextView.text = DefautText;
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息" message:@"请输入您的建议!"];
        return;
    }
    
    NSDictionary *param = @{@"yhid":self.UserId,
                            @"wzlr":str};
    
    [FeedBackRequest requestWithParameters:param
                         withIndicatorView:self.view withCancelSubject:nil onRequestStart:
     ^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"提示" message:@"非常感谢您提供的宝贵意见"];
        }else{
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息" message:request.handleredResult[@"msg"]];
        }
        
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}

- (IBAction)SendInfoButtonClick:(id)sender {
    if (!isReachability) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息" message:@"请检查您的网络~"];
    }else{
        [self startRequest];
    }
}
- (IBAction)TapGestureAction:(id)sender {
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([ContentTextView.text isEqualToString:DefautText]) {
        ContentTextView.text = @"";
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([[ContentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
        if (ContentTextView.text.length > 0) {
            [UIAlertView popupAlertByDelegate:nil andTag:1001 title:@"温馨提示" message:@"意见反馈不能为空或全空格"];
        }
        ContentTextView.text = DefautText;
    }else if([ContentTextView.text isEqualToString:DefautText]) {
        ContentTextView.text = DefautText;
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (IBAction)popViewControllerClick:(id)sender {
    _TabBarControl = (ITTTabBarController*)self.tabBarController;
    _TabBarControl.tabBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1002) {
        _TabBarControl = (ITTTabBarController*)self.tabBarController;
        _TabBarControl.tabBarHidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
