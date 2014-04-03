//
//  FavourableActivityViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "FavourableActivityViewController.h"
#import "FavourableCell.h"
#import "PromotionAdvertViewController.h"
#import "PromotionModel.h"
#import "PromotionListDataRequest.h"

@interface FavourableActivityViewController ()
@property (nonatomic, strong)ITTTabBarController        *ITTTabBarController;


/**
 *  上下拉刷新
 */
@property (strong, nonatomic)MJRefreshHeaderView                *headview;
@property (strong, nonatomic)MJRefreshFooterView                *footView;
@property (assign, nonatomic) int                               indexpage;
@property (nonatomic, strong)NSMutableArray                     *DataArray;
@property (weak, nonatomic) IBOutlet UITableView                *ContentTableView;

@end

@implementation FavourableActivityViewController

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
    NSDictionary *param = @{@"pageNo":page,@"pageSize":@"7"};
    [PromotionListDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
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
        [self.DataArray addObjectsFromArray:resultDic[@"PromotionModel"]];
    }else if (refresh == _footView){
        [self.DataArray addObjectsFromArray:resultDic[@"PromotionModel"]];
    }else{
        [self.DataArray removeAllObjects];
        [self.DataArray addObjectsFromArray:resultDic[@"PromotionModel"]];
        [self performSelector:@selector(doneWithView:) withObject:refresh afterDelay:0.5];
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initIphone4OrIphone5];
    if (!isReachability) {
        
    }else{
        [self GetEgoRefreshView];
        [self startListRequestDataWithRefrsh:nil andPageNo:[NSString stringWithFormat:@"%d",self.indexpage]];
    }

}
-(void)initIphone4OrIphone5
{
    self.indexpage = 1;
    self.DataArray = [[NSMutableArray alloc]initWithCapacity:1000];
    if (Screen_height == 480) {
        _ContentTableView.frame = CGRectMake(0, 0, 320, 414);
    }else{
        _ContentTableView.frame = CGRectMake(0, 0, 320, 504);
    }
}
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
    PromotionModel *model = [self.DataArray objectAtIndex:indexPath.row];
    [cell.FavourPhotoImage loadImage:model.tp];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.NameLable.text = model.wzbt;
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    PromotionAdvertViewController *gvc = [[PromotionAdvertViewController alloc]initWithNibName:@"PromotionAdvertViewController" bundle:nil];
    gvc.isRootViewController = NO;
    PromotionModel *model = [self.DataArray objectAtIndex:indexPath.row];
    gvc.ActivityId = model.PromotionId;
    [self.navigationController pushViewController:gvc animated:YES];
}

#pragma mark -
#pragma mark NaviGationBarButton
- (IBAction)PopViewButtonClick:(id)sender {
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
