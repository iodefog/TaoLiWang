//
//  DistributorsViewController.m
//  TaoliWang
//
//  Created by zdqk on 14-1-8.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "DistributorsViewController.h"
#import "DisDetailViewController.h"
#import "FavourableCell.h"
#import "MySubscriptionModel.h"
#import "DisHomeRequest.h"
#import "DistributionInfoModel.h"
#import "SaveAndGetUserInformation.h"
#import "SetViewController.h"
#import "ScanningViewController.h"
@interface DistributorsViewController ()
@property (nonatomic, assign) int                           CurrentPage;
@property (nonatomic, strong)NSMutableArray                 *DataArray;
@property (nonatomic, strong)ITTBaseManager                 *applicationManager;
@property (nonatomic, strong)DistributionInfoModel          *disModel;
@end

@implementation DistributorsViewController
{
    __weak IBOutlet UIView *ScanningView;
    __weak IBOutlet ITTPullTableView *ContentTableView;

    __weak IBOutlet UILabel *TitelLable;
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
-(void)startRequest:(NSString *)page
{
    NSDictionary *param = @{@"pageSize": @"7",
                            @"pageNo": page};
    [DisHomeRequest requestWithParameters:param
                            withIndicatorView:self.view
                            withCancelSubject:nil
                               onRequestStart:
     ^(ITTBaseDataRequest *request) {
         
     } onRequestFinished:^(ITTBaseDataRequest *request) {
         
         [self setResultDict:request.handleredResult[@"MySubscriptionModel"]];
     } onRequestCanceled:^(ITTBaseDataRequest *request) {
         
     } onRequestFailed:^(ITTBaseDataRequest *request) {
         
     }];
    
}
-(void)setResultDict:(NSMutableArray *)array
{
    if (self.CurrentPage == 1) {
        [self.DataArray removeAllObjects];
        [self.DataArray addObjectsFromArray:array];
        [self refreshDataDone];
    }else{
        [self.DataArray  addObjectsFromArray:array];
        [self loadMoreDataDone];
    }
}
#pragma mark
#pragma ViewDidload
- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self startRequest:@"1"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self initIphone4Or5];
            
        });
    });
}
-(void)initIphone4Or5
{
    self.DataArray = [[NSMutableArray alloc]initWithCapacity:100];
    self.disModel = [SaveAndGetUserInformation readDistributionDefaults];
    TitelLable.text = self.disModel.mc;
    self.applicationManager = [[ITTBaseManager alloc]init];
    self.CurrentPage = 1;
    if (!iPhone5) {
        ContentTableView.frame = CGRectMake(0, 0, 320, 360);
        ScanningView.frame = CGRectMake(0, Screen_height-64-54, 320, 54);
    }
}
#pragma mark
#pragma mark PullTableViewDelegate
-(void)pullTableViewDidTriggerLoadMore:(ITTPullTableView *)pullTableView
{
    self.CurrentPage++;
    [ContentTableView setLoadMoreViewHidden:NO];
    [self startRequest:[NSString stringWithFormat:@"%d",self.CurrentPage]];
}
-(void)pullTableViewDidTriggerRefresh:(ITTPullTableView *)pullTableView
{
    self.CurrentPage = 1;
    [ContentTableView setRefreshViewHidden:NO];
    [self startRequest:[NSString stringWithFormat:@"%d",self.CurrentPage]];
}
- (void)loadMoreDataDone
{
    /*
     *Code to actually load more data goes here.
     */
    [ContentTableView reloadData];
    ContentTableView.pullTableIsLoadingMore = NO;
    self.applicationManager.kRefreshType = kRefreshTypeNone;
}

- (void)refreshDataDone
{
    /*
     *Code to actually refresh goes here.
     */
    [ContentTableView reloadData];
    self.applicationManager.kRefreshType = kRefreshTypeNone;
    ContentTableView.pullLastRefreshDate = [NSDate date];
    ContentTableView.pullTableIsRefreshing = NO;
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
    FavourableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FavourableCell" owner:self options:nil]lastObject];
    }
    MySubscriptionModel *model = [self.DataArray objectAtIndex:indexPath.row];
    [cell.FavourPhotoImage loadImage:model.tp];
    cell.NameLable.text = model.bt;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    MySubscriptionModel *model = [self.DataArray objectAtIndex:indexPath.row];
    DisDetailViewController *gvc = [[DisDetailViewController alloc]initWithNibName:@"DisDetailViewController" bundle:nil];
    gvc.AdID = model.ActivityId;
    [self.navigationController pushViewController:gvc animated:YES];
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
//    view.backgroundColor = [UIColor whiteColor];
//
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame =CGRectMake(5, 10, 310, 40);
//    [btn setTitle:@"商品扫码" forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"Login_Nomal"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"Login_Select"] forState:UIControlStateHighlighted];
//    [btn addTarget:self action:@selector(ScanerCodeClick:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:btn];
//
//    return view;
//}
- (IBAction)GoodsScanningBtnAction:(id)sender {
    ScanningViewController *svc = [[ScanningViewController alloc]initWithNibName:@"ScanningViewController" bundle:nil];
    svc.Scanning = isDistribution;
    svc.TitleStr = @"分销商扫码";
    [self.navigationController pushViewController:svc animated:YES];
}
- (IBAction)SetButtonClick:(id)sender {
    SetViewController *svc = [[SetViewController alloc]initWithNibName:@"SetViewController" bundle:nil];
    [self.navigationController pushViewController:svc animated:YES];
}
@end
