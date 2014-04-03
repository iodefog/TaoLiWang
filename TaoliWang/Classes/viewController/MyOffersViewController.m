//
//  MyOffersViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-24.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MyOffersViewController.h"
#import "MyOffersCell.h"
#import "MyOffersListModel.h"
#import "MyOffersListDataRequest.h"
#import "MyOffersDetailViewController.h"

@interface MyOffersViewController ()
@property (strong, nonatomic)ITTTabBarController    *TabBarControl;
@property (strong, nonatomic)NSMutableArray         *DataArray;
@property (strong, nonatomic) MyOffersDetailViewController *mvc;
@end

@implementation MyOffersViewController
{
    __weak IBOutlet UIButton *NowPointBtn;
    __weak IBOutlet UIButton *BeforePointBtn;
    __weak IBOutlet UILabel *NowTitleLable;
    __weak IBOutlet UILabel *BeforeTitleLable;
    __weak IBOutlet UITableView *ContentTableView;

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
-(void)startGoodsListRequestType:(NSString *)type
{

    NSDictionary *param = @{@"pageNo": @"1",
                            @"pageSize": @"1000",
                            @"type": type,
                            @"yhid": self.UserId};
    [MyOffersListDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        self.DataArray = request.handleredResult[@"MyOffersListModel"];
        [ContentTableView reloadData];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}

#pragma mark
#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initIphone4OrIphone5];
}
-(void)initIphone4OrIphone5
{
    self.DataArray = [[NSMutableArray alloc]initWithCapacity:100];
    self.mvc = [[MyOffersDetailViewController alloc]initWithNibName:@"MyOffersDetailViewController" bundle:nil];
    if (Screen_height == 480) {
        ContentTableView.frame = CGRectMake(0, 0, 320, 460);
    }else{
        ContentTableView.frame = CGRectMake(0, 0, 320, 400);
    }
    [self startGoodsListRequestType:@"0"];
}

#pragma mark -
#pragma tableViewDelegate
/**
 *  tableview代理
 *
 *  @param tableView
 *  @param section
 *
 *  @return cell
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.DataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    MyOffersCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyOffersCell" owner:self options:nil]lastObject];
    }
    MyOffersListModel *model = [self.DataArray objectAtIndex:indexPath.row];
    [cell.PhotoImageView loadImage:model.yhjtp];
    [cell.contentLable setText:model.yhjmc];
    [cell.DaysLable setText:model.yxq];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    MyOffersListModel *model = [self.DataArray objectAtIndex:indexPath.row];
    self.mvc.YhjId = model.mm;
    self.mvc.UserId = self.UserId;
    [self.navigationController pushViewController:self.mvc animated:YES];
}

#pragma mark
#pragma mark BtnAction
- (IBAction)NowBtnClick:(id)sender {
    NowTitleLable.textColor = [UIColor colorWithRed:245/255.0 green:126/255.0 blue:77/255.0 alpha:1.0];
    BeforeTitleLable.textColor = [UIColor grayColor];
    NowPointBtn.enabled = NO;
    BeforePointBtn.enabled = YES;
    [self startGoodsListRequestType:@"0"];
}
- (IBAction)BeforeBtnClick:(id)sender {
    NowTitleLable.textColor = [UIColor grayColor];
    BeforeTitleLable.textColor = [UIColor colorWithRed:245/255.0 green:126/255.0 blue:77/255.0 alpha:1.0];
    NowPointBtn.enabled = YES;
    BeforePointBtn.enabled = NO;
    [self startGoodsListRequestType:@"1"];
}

- (IBAction)PopViewControllerClick:(id)sender {
    _TabBarControl = (ITTTabBarController*)self.tabBarController;
    _TabBarControl.tabBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
