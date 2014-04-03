//
//  MySubListViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MySubListViewController.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"
#import "MySubscriptionsConformDataRequest.h"
#import "MySubscriptionsCancelDataRequest.h"
#import "SubManageCell.h"
#import "subManageModel.h"

@interface MySubListViewController ()
@property (nonatomic, strong)ITTTabBarController        *ITTTabBarController;
@property (nonatomic, strong) NSMutableArray            *DataArray;
@property (nonatomic, strong) UserInfomationModel       *UserModel;
@property (nonatomic, assign) BOOL                      isSumMange;
@property (nonatomic, copy)  NSString                   *isType;
@property (nonatomic, strong) UIButton                  *SuMangeBtn;
@end

@implementation MySubListViewController
{
    __weak IBOutlet UITableView *ContentTablView;

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)startRequestList{
    
    NSDictionary *param = @{@"yhid": self.UserModel.UserId};
    
    [MySubscriptionsConformDataRequest requestWithParameters:param
                                           withIndicatorView:self.view
                                           withCancelSubject:nil
                                              onRequestStart:
     ^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        self.DataArray = request.handleredResult[@"subManageModel"];
        [ContentTablView reloadData];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
-(void)StartRequestCancel:(NSString *)lmid
{
    
    NSDictionary *param = @{@"yhid": self.UserModel.UserId,
                            @"dyzt": self.isType,
                            @"lmid": lmid};
    NSLog(@"sss == %@",param);
    [MySubscriptionsCancelDataRequest requestWithParameters:param withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        if([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"])
        {
            if (self.SuMangeBtn.selected) {
                [self.SuMangeBtn setSelected:NO];
            }
            else{
                [self.SuMangeBtn setSelected:YES];
            }
        }
        else
        {
            return ;
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (!isReachability) {
            
        }else{
            [self initIphone4OrIphone5];
            [self startRequestList];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
   

    
}
-(void)initIphone4OrIphone5
{
    self.UserModel = [SaveAndGetUserInformation readUserDefaults];
    self.DataArray = [[NSMutableArray alloc]initWithCapacity:100];
    if (Screen_height == 480) {
        ContentTablView.frame = CGRectMake(0, 0, 320, 414);
    }else{
        ContentTablView.frame = CGRectMake(0, 0, 320, 504);
    }
}
#pragma mark -
#pragma tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    SubManageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SubManageCell" owner:self options:nil]lastObject];
    }
    subManageModel *model = [self.DataArray objectAtIndex:indexPath.row];
    cell.subManagLable.text = model.mc;
    [cell.SubMangePhotoImageView loadImage:model.tp];
    if ([model.sfdy isEqualToString:@"0"]) {
        [cell.SumMangeBtn setSelected:NO];

    }else{
        [cell.SumMangeBtn setSelected:YES];
    }
    [cell.SumMangeBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.SumMangeBtn.tag = 100 +indexPath.row;
    return cell;
}
#pragma mark
#pragma mark TableViewDelegate
-(void)BtnClick:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    self.SuMangeBtn = btn;
    subManageModel *model =[self.DataArray objectAtIndex:btn.tag - 100];
    if (!isReachability) {
        return;
    }else
    {
        if (self.SuMangeBtn.selected)
        {
            self.isType = @"0";
        }
        else
        {
            self.isType = @"1";
        }
    }
    [self StartRequestCancel:model.lmid];
}

#pragma mark
#pragma mark BtnAction
- (IBAction)PopViewControllerButtonClick:(id)sender {
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
