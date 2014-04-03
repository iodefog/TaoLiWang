//
//  YaoyiyaoListViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-3.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "YaoyiyaoListViewController.h"
#import "YaoyiyaoDetailViewController.h"
#import "YaoyiyaoListCell.h"
#import "YaoyiyaoListDataRequest.h"
#import "YaoyiyaoListModel.h"

@interface YaoyiyaoListViewController ()
@property(nonatomic, strong) NSMutableArray             *DataArray;
@property (nonatomic, assign) int                        CurrentPage;
@property (nonatomic, strong)ITTBaseManager              *applicationManager;
@end

@implementation YaoyiyaoListViewController
{
    __weak IBOutlet ITTPullTableView *ContentTableView;

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
    NSDictionary *param = @{@"yhid": self.UserId,
                            @"lng": self.jindu,
                            @"lat": self.weidu,
                            @"pageSize": @"6",
                            @"pageNo": page};
    [YaoyiyaoListDataRequest requestWithParameters:param
                            withIndicatorView:self.view
                            withCancelSubject:nil
                               onRequestStart:
     ^(ITTBaseDataRequest *request) {
         
     } onRequestFinished:^(ITTBaseDataRequest *request) {
         [self setResultDict:request.handleredResult[@"YaoyiyaoListModel"]];
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
#pragma mark ViewDidload
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initIphone4or5];
    [self startRequest:@"1"];
}
-(void)initIphone4or5
{
    self.DataArray = [[NSMutableArray alloc]initWithCapacity:100];
    self.applicationManager = [[ITTBaseManager alloc]init];
    self.CurrentPage = 1;
    if (Screen_height == 480) {
        ContentTableView.frame  = CGRectMake(0, 0, 320, 410);
    }else{
        ContentTableView.frame  = CGRectMake(0, 0, 320, 504);
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
#pragma mark
#pragma mark TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifyCell = @"cell";
    YaoyiyaoListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifyCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"YaoyiyaoListCell" owner:self options:nil]lastObject];
    }
    ///数据加载
    YaoyiyaoListModel *model = [self.DataArray objectAtIndex:indexPath.row];
    [cell.photoImageView loadImage:model.Businesslogo];
    cell.titelLable.text = model.BusinessMC;
    cell.typeLable.text = model.BusinessJYLX;
    cell.distanceLable.text = [NSString stringWithFormat:@"<%dkm",[model.BusinessJL intValue]];
    cell.phoneLable.text = model.BusinessDH;
    cell.addressLable.text = model.BusinessDZ;
    return cell;
    
    
}
#pragma mark
#pragma mark TableViewDatesource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    YaoyiyaoListModel *model = [self.DataArray objectAtIndex:indexPath.row];
    YaoyiyaoDetailViewController *yvc = [[YaoyiyaoDetailViewController alloc]initWithNibName:@"YaoyiyaoDetailViewController" bundle:nil];
    yvc.UserId =self.UserId;
    yvc.BusinessId = model.BusinessID;
    [self.navigationController pushViewController:yvc animated:YES];
    
}
#pragma mark
#pragma mark ButtonAction
- (IBAction)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
