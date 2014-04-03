//
//  MyOffersDetailViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-25.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MyOffersDetailViewController.h"
#import "MyOffersDetailDataRequest.h"
#import "MyOffersDetailModel.h"
@interface MyOffersDetailViewController ()
@property (nonatomic, strong)MyOffersDetailModel         *DetailModel;
@end

@implementation MyOffersDetailViewController
{

    __weak IBOutlet UIScrollView *BackScrollView;
    __weak IBOutlet ITTImageView *PhotoImageView;
    __weak IBOutlet UILabel *TitielLable;
    __weak IBOutlet UILabel *PinpaiLable;
    __weak IBOutlet UILabel *thjhmLable;
    __weak IBOutlet UILabel *qixianLable;
    __weak IBOutlet UILabel *dizLable;
    __weak IBOutlet UILabel *phoneNumberLable;
    __weak IBOutlet UITextView *ContentLable;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
#pragma mark
#pragma mark StartRequest
-(void)StartRequest
{
    NSDictionary *param = @{@"yhid":self.UserId,
                            @"id":self.YhjId};
    [MyOffersDetailDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        self.DetailModel = request.handleredResult[@"MyOffersDetailModel"];
        [self initUI];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
-(void)initUI
{
    [PhotoImageView loadImage:self.DetailModel.yhjtp];
    TitielLable.text = self.DetailModel.yhjmc;
    PinpaiLable.text = self.DetailModel.yhjpp;
    thjhmLable.text = self.DetailModel.mm;
    qixianLable.text = self.DetailModel.yxq;
    dizLable.text = self.DetailModel.yhjdz;
    phoneNumberLable.text = self.DetailModel.yhjdh;
    ContentLable.text = self.DetailModel.yhxq;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initIPhone5or4];
    [self StartRequest];
}
-(void)initIPhone5or4
{
    if (Screen_height == 480) {
        BackScrollView.contentSize = CGSizeMake(320, 590);
    }else{
        BackScrollView.contentSize = CGSizeMake(320, 510);
    }
}
- (IBAction)PopViewControllerClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
