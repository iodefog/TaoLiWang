//
//  MyPayCountViewController.m

//  TaoliWang
//
//  Created by Mac OS X on 14-2-8.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MyPayCountViewController.h"
#import "MyPayCountCell.h"
#import "MyOrderListModel.h"
#import "MyCountDataRequest.h"
#import "MyPayDetailViewController.h"
#import "UIImageView+WebCache.h"
@interface MyPayCountViewController ()
@property (strong, nonatomic)ITTTabBarController         *TabBarControl;
@property (weak, nonatomic) IBOutlet ITTPullTableView    *contentTableView;
@property (nonatomic, strong)ITTBaseManager              *applicationManager;

@property (nonatomic, strong) NSMutableArray             *DataArray;
@property (nonatomic, assign) int                         CurrentPage;
@end

@implementation MyPayCountViewController

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
                            @"pageSize": @"7",
                            @"pageNo": page};
    [MyCountDataRequest requestWithParameters:param
                            withIndicatorView:self.view
                            withCancelSubject:nil
                               onRequestStart:
     ^(ITTBaseDataRequest *request) {
    
     } onRequestFinished:^(ITTBaseDataRequest *request) {
        [self setResultDict:request.handleredResult[@"MyOrderListModel"]];
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
#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initIphone4Or5];
    [self startRequest:@"1"];
}
-(void)initIphone4Or5
{
    self.DataArray = [[NSMutableArray alloc]initWithCapacity:100];
    self.applicationManager = [[ITTBaseManager alloc]init];
    self.CurrentPage = 1;
    if (Screen_height == 480) {
        self.contentTableView.frame = CGRectMake(0, 0, 320, 410);
    }else
    {
        self.contentTableView.frame = CGRectMake(0, 0, 320, 500);
    }
}
#pragma mark
#pragma mark PullTableViewDelegate
-(void)pullTableViewDidTriggerLoadMore:(ITTPullTableView *)pullTableView
{
    self.CurrentPage++;
    [self.contentTableView setLoadMoreViewHidden:NO];
    [self startRequest:[NSString stringWithFormat:@"%d",self.CurrentPage]];
}
-(void)pullTableViewDidTriggerRefresh:(ITTPullTableView *)pullTableView
{
    self.CurrentPage = 1;
    [self.contentTableView setRefreshViewHidden:NO];
    [self startRequest:[NSString stringWithFormat:@"%d",self.CurrentPage]];
}
- (void)loadMoreDataDone
{
    /*
     *Code to actually load more data goes here.
     */
    [self.contentTableView reloadData];
    self.contentTableView.pullTableIsLoadingMore = NO;
    self.applicationManager.kRefreshType = kRefreshTypeNone;
}

- (void)refreshDataDone
{
    /*
     *Code to actually refresh goes here.
     */
    [self.contentTableView reloadData];
    self.applicationManager.kRefreshType = kRefreshTypeNone;
    self.contentTableView.pullLastRefreshDate = [NSDate date];
    self.contentTableView.pullTableIsRefreshing = NO;
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
    MyPayCountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifyCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyPayCountCell" owner:self options:nil]lastObject];
    }
    /**
     *  数据加载
     */
    MyOrderListModel *model  = [self.DataArray objectAtIndex:indexPath.row];
//    [cell.PhotoImageView loadImage:model.orderPic];
    if ([model.orderPic isKindOfClass:[NSString class]]) {
        [cell.PhotoImageView setImageWithURL:[NSURL URLWithString:model.orderPic]];
    }else if([model.orderPic isKindOfClass:[NSArray class]]){
        if (((NSArray *)model.orderPic).count > 0) {
            [cell.PhotoImageView setImageWithURL:[NSURL URLWithString:[(NSArray *)model.orderPic firstObject]]];
        }
    }
    cell.DiscountNumberLable.text = model.orderBH;
    cell.MoneyLable.text = model.orderJE;
    cell.PointLable.text = model.orderJF;
    cell.TimeLable.text = model.orderSJ;
    /**
     *  按钮事件
     */
    [cell.BackBtn addTarget:self action:@selector(DetailBtn01Click:) forControlEvents:UIControlEventTouchUpInside];
    cell.BackBtn.tag = indexPath.row + 100;
    return cell;

    
}
#pragma mark
#pragma mark ButtonAction
- (IBAction)PopViewControllerButtonClick:(id)sender {
    _TabBarControl = (ITTTabBarController*)self.tabBarController;
    _TabBarControl.tabBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)DetailBtn01Click:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    MyPayDetailViewController *mvc = [[MyPayDetailViewController alloc]initWithNibName:@"MyPayDetailViewController" bundle:nil];
    mvc.userID = self.UserId;
    MyOrderListModel *model = [self.DataArray objectAtIndex:btn.tag - 100];
    mvc.GoodsId = model.orderBH;
    [self.navigationController pushViewController:mvc animated:YES];
    
}
@end
