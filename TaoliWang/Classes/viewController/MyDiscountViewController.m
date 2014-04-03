//
//  MyDiscountViewController.m
//  TaoliWang
//
//  Created by zdqk on 14-1-8.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MyDiscountViewController.h"
#import "MySubscriptionsListDataRequest.h"
#import "FavourableCell.h"
#import "MySubscriptionModel.h"
#import "SaveAndGetUserInformation.h"
#import "UserInfomationModel.h"
#import "SubManagerViewController.h"
#import "MySubListViewController.h"

@interface MyDiscountViewController ()
@property (nonatomic, strong)ITTTabBarController        *ITTTabBarController;
@property (nonatomic, strong)UserInfomationModel        *UserModel;

/**
 *  上下拉刷新
 */
@property (strong, nonatomic)MJRefreshHeaderView                *headview;
@property (strong, nonatomic)MJRefreshFooterView                *footView;
@property (assign, nonatomic) int                               indexpage;
@property (nonatomic, strong)NSMutableArray                     *DataArray;
@property (weak, nonatomic) IBOutlet UIView                     *TableBackView;
@property (weak, nonatomic) IBOutlet UITableView                *ContentTableView;

@property (strong, nonatomic) IBOutlet UIView *emptyView;


@end

@implementation MyDiscountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark
#pragma mark StartRequestData
-(void)startListRequestDataWithRefrsh:(MJRefreshBaseView *)fresh andPageNo:(NSString *)page
{
    NSDictionary *param = @{@"pageNo": page,
                            @"pageSize": @"7",
                            @"yhid": self.UserModel.UserId};
    [MySubscriptionsListDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
    } onRequestFinished:^(ITTBaseDataRequest *request) {
         [self setDataDic:request.handleredResult toManager:self.DataArray andRefresh:fresh];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
    
}
-(void)setDataDic:(NSDictionary *)resultDic toManager:(NSMutableArray *)baseManage andRefresh:(MJRefreshBaseView *)refresh
{
    if (refresh == _headview) {
        [self.DataArray removeAllObjects];
        [self.DataArray addObjectsFromArray:resultDic[@"MySubscriptionModel"]];
    }else if (refresh == _footView){
        [self.DataArray addObjectsFromArray:resultDic[@"MySubscriptionModel"]];
    }else{
        [self.DataArray removeAllObjects];
        [self.DataArray addObjectsFromArray:resultDic[@"MySubscriptionModel"]];
        [self performSelector:@selector(doneWithView:) withObject:refresh afterDelay:0.5];
    }
    if (self.DataArray.count == 0) {
        _TableBackView.hidden = YES;
        self.emptyView.hidden = NO;
    }else{
        _TableBackView.hidden = NO;
        self.emptyView.hidden = YES;
    }
    
}

#pragma mark
#pragma mark ViewDidLoad
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (!isReachability) {
            [_TableBackView setHidden:YES];
        }else{
            [self startListRequestDataWithRefrsh:nil andPageNo:[NSString stringWithFormat:@"%d",self.indexpage]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
        });
    });


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self GetEgoRefreshView];
    [self initIphone4OrIphone5];
}
-(void)initIphone4OrIphone5
{
    self.indexpage = 1;
    self.DataArray = [[NSMutableArray alloc]initWithCapacity:1000];
    self.UserModel = [SaveAndGetUserInformation readUserDefaults];
    if (Screen_height == 480) {
        self.ContentTableView.frame = CGRectMake(0, 0, 320, 384);
    }else{
        self.ContentTableView.frame = CGRectMake(0, 0, 320, 457);
    }

}

#pragma mark 
#pragma mark MjRefreshDelegate
#pragma mark -
#pragma mark RefreshViewAndLoadMoreView

/**
 *  上下拉刷新界面
 *
 *  @param arr
 */
-(void)GetEgoRefreshView
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.ContentTableView;
    header.delegate = self;
    _headview = header;
    
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.ContentTableView;
    footer.delegate = self;;
    _footView = footer;
    
}
/**
 *  上下拉刷新方法
 */
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _footView) {
        self.indexpage ++;
    }else{
        self.indexpage = 1;
    }
    [self startListRequestDataWithRefrsh:refreshView andPageNo:[NSString stringWithFormat:@"%d",self.indexpage]];
    [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0.5];

}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.ContentTableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.NameLable.text = model.wzbt;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = YES;
    MySubscriptionModel *model = [self.DataArray objectAtIndex:indexPath.row];
    SubManagerViewController *gvc = [[SubManagerViewController alloc]initWithNibName:@"SubManagerViewController" bundle:nil];
    gvc.SubScriptionId = model.ActivityId;
    [self.navigationController pushViewController:gvc animated:YES];
}
#pragma mark
#pragma mark BtnAction
- (IBAction)SubScriptionsButtonClick:(id)sender {
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = YES;
    MySubListViewController *svc = [[MySubListViewController alloc]initWithNibName:@"MySubListViewController" bundle:nil];
    [self.navigationController pushViewController:svc animated:YES];
}
@end
