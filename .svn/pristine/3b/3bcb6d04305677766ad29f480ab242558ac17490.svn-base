//
//  YaoyiyaoDetailViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-3.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "YaoyiyaoDetailViewController.h"
#import "YaoyiyaoListModel.h"
#import "YaoyiyaoDetailDataRequest.h"

@interface YaoyiyaoDetailViewController ()
@property(nonatomic, strong) NSMutableArray             *DataArray;
@property(nonatomic, strong) YaoyiyaoListModel          *DetailModel;
@end

@implementation YaoyiyaoDetailViewController
{

    __weak IBOutlet ITTImageView *hdtpImageView;
    __weak IBOutlet ITTImageView *logoImageView;
    __weak IBOutlet UILabel *phoneLable;
    __weak IBOutlet UILabel *nameLable;
    __weak IBOutlet UILabel *typelable;
    __weak IBOutlet UILabel *addresslable;
    __weak IBOutlet UITextView *contentTextView;
    __weak IBOutlet UIScrollView *ContentScrollView;
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
#pragma mark DataRequest
-(void)startRequest
{
    NSDictionary *param = @{@"yhid": self.UserId,
                            @"cid": self.BusinessId};
    [YaoyiyaoDetailDataRequest requestWithParameters:param
                                 withIndicatorView:self.view
                                 withCancelSubject:nil
                                    onRequestStart:
     ^(ITTBaseDataRequest *request) {
         
     } onRequestFinished:^(ITTBaseDataRequest *request) {
         self.DetailModel = request.handleredResult[@"YaoyiyaoListModel"];
         [hdtpImageView loadImage:self.DetailModel.BusinessHDTP];
         [logoImageView loadImage:self.DetailModel.Businesslogo];
         phoneLable.text = self.DetailModel.BusinessDH;
         nameLable.text = self.DetailModel.BusinessMC;
         typelable.text = self.DetailModel.BusinessJYLX;
         addresslable.text = self.DetailModel.BusinessDZ;
         contentTextView.text = self.DetailModel.BusinessBZ;
     } onRequestCanceled:^(ITTBaseDataRequest *request) {
         
     } onRequestFailed:^(ITTBaseDataRequest *request) {
         
     }];
    
}
#pragma mark
#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initIphone4or5];
    [self startRequest];
}
-(void)initIphone4or5
{
    if (Screen_height == 480) {
        ContentScrollView.contentSize  = CGSizeMake(320, 600);
    }else{
        ContentScrollView.contentSize  = CGSizeMake(0, 504);
    }
}
#pragma mark
#pragma mark PopButtonAction
- (IBAction)PopViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
