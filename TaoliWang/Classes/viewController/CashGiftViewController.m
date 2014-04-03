//
//  CashGiftViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "CashGiftViewController.h"
#import "SearchViewController.h"
#import "GoodsListDataRequest.h"
#import "CrashGiftCell.h"
#import "GoodsListModel.h"
#import "GoodsDetailsViewController.h"
#import "GoodsDetailDataBase.h"
#import "MyPointDataRequest.h"
#import "TimeObject.h"
#import "AppDelegate.h"

@interface CashGiftViewController ()
@property (nonatomic, strong) ITTTabBarController               *ITTTabBarController;
@property (weak, nonatomic) IBOutlet UIView                     *NowPointView;
@property (weak, nonatomic) IBOutlet UILabel                    *NowPointLable;
@property (weak, nonatomic) IBOutlet UILabel                    *NaviTitleLable;

@property (weak, nonatomic) IBOutlet ITTPullTableView           *PointTableView;
@property (strong, nonatomic) ITTBaseManager                     *Manager;
@property (assign, nonatomic) int                               indexpage;
@property (strong, nonatomic) NSMutableArray                    *DataArray;
@property (strong, nonatomic) PopCarView                         *Carview;

@end

@implementation CashGiftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}



#pragma mark -
#pragma mark GoosListRequest
/**
 *  我的积分显示
 */
-(void)StartMyPointRequest
{
    
    NSDictionary *param = @{@"yhid": self.UserId};
    [MyPointDataRequest requestWithParameters:param withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        _NowPointLable.text = [NSString stringWithFormat:@"%@积分",[request.handleredResult[@"result"]stringValue]];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}

/**
 *  商品显示
 *
 *  @param page 页数
 */
-(void)StartRequest:(NSString *)page
{
    NSDictionary *param = @{@"pageNo":page,
                            @"pageSize":@"10",
                            @"productType":self.Type};
    
    [GoodsListDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        [self ResultData:request.handleredResult[@"GoodsListModel"]];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
-(void)ResultData:(NSMutableArray *)array
{
    if (self.indexpage == 1) {
        [self.DataArray removeAllObjects];
        [self.DataArray addObjectsFromArray:array];
        [self refreshDataDone];
    }else{
        [self.DataArray  addObjectsFromArray:array];
        [self loadMoreDataDone];
    }
}

#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self StartRequest:@"1"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initIPhone4OrIphone5];
            [self InitUI];
        });
    });

}
- (void)InitUI
{
    self.Carview = [[PopCarView alloc]init];
    if (isIOS7) {
        self.Carview.top = Screen_height - 50;
    }else{
        self.Carview.top = Screen_height - 70;
    }
    self.Carview.left = Screen_width - 50;
    self.Carview.delegate = self;
    [self.Carview SetCarNumber];
    [self.view addSubview:self.Carview];
}

-(void)JoinCarButtonClick:(id)sender{
    [SharedApp showViewController:HOME_VIEW_CONTROLLER andIndex:1];
}
-(void)initIPhone4OrIphone5
{
    self.Manager = [[ITTBaseManager alloc]init];
    self.DataArray = [[NSMutableArray alloc]init];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    view.backgroundColor = [UIColor whiteColor];
    self.PointTableView.tableFooterView = view;
    self.indexpage = 1;
    if ([self.Type isEqualToString:isGoodsTypePoint]) {
        _NaviTitleLable.text = @"积分兑换";
    }else{
        _NaviTitleLable.text = @"现金商品";
    }
    
    if ([self.Type isEqualToString:isGoodsTypePoint] && self.UserId.length != 0) {
         [self StartMyPointRequest];
        if (iPhone5) {
            _PointTableView.frame = CGRectMake(0, 38, 320, 466);
        }else{
            _PointTableView.frame = CGRectMake(0, 38, 320, 370);
        }
    }else{
        _NowPointView.hidden = YES;
       
        if (iPhone5) {
            _PointTableView.frame = CGRectMake(0, 0, 320, 504);
        }else{
            _PointTableView.frame = CGRectMake(0, 0, 320, 370+38);
        }
    }
   
}
#pragma mark -
#pragma mark ITTPullTableViewDelegate

-(void)pullTableViewDidTriggerRefresh:(ITTPullTableView *)pullTableView{
    self.indexpage = 1;
    [_PointTableView setRefreshViewHidden:NO];
    [self StartRequest:@"1"];
}
-(void)pullTableViewDidTriggerLoadMore:(ITTPullTableView *)pullTableView{
    self.indexpage++;
    [_PointTableView setLoadMoreViewHidden:NO];
    [self StartRequest:[NSString stringWithFormat:@"%d",self.indexpage]];
}

- (void)loadMoreDataDone
{
    [_PointTableView reloadData];
    _PointTableView.pullTableIsLoadingMore = NO;
    self.Manager.kRefreshType = kRefreshTypeNone;
}

- (void)refreshDataDone
{
    [_PointTableView reloadData];
    self.Manager.kRefreshType = kRefreshTypeNone;
    _PointTableView.pullLastRefreshDate = [NSDate date];
    _PointTableView.pullTableIsRefreshing = NO;
}
/**
 *  tableview代理
 *
 *  @param tableView
 *  @param section
 *
 *  @return cell
 */
#pragma mark - 
#pragma tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    CrashGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CrashGiftCell" owner:self options:nil]lastObject];
    }
    GoodsListModel *model = [self.DataArray objectAtIndex:indexPath.row];
    cell.GoodsNameLable.text = model.chmc;
    [cell.GoodsPhotoImageView loadImage:model.tpmc];
    cell.JoinCarButton.tag = indexPath.row;
    [cell.JoinCarButton addTarget:self action:@selector(CellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.Type isEqualToString:isGoodsTypePoint]) {
        cell.JifenLable.text = @"积分:";
        cell.GoodsPointLable.text = [NSString stringWithFormat:@"%@",model.cklsj];
        cell.GoodsPriceLable.text =[NSString stringWithFormat:@"原价:%@元",model.scj];
       
    }else{
        cell.JifenLable.text = @"售价:";
        cell.GoodsPointLable.text = [NSString stringWithFormat:@"%@元",model.tlscj];
        cell.GoodsPriceLable.text = [NSString stringWithFormat:@"原价:%@元",model.scj];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    GoodsListModel *model = [self.DataArray objectAtIndex:indexPath.row];
    GoodsDetailsViewController *gvc = [[GoodsDetailsViewController alloc]initWithNibName:@"GoodsDetailsViewController" bundle:nil];
    gvc.GoodsId = model.GoodsId;
    if ([self.Type isEqualToString:isGoodsTypePoint]) {
        gvc.GoodsType = isGoodsTypePoint;
    }else{
        gvc.GoodsType = isGoodsTypeMoney;
    }
    [self.navigationController pushViewController:gvc animated:YES];
}
-(void)CellBtnClick:(UIButton *)sender
{
    
    UIButton * btn = (UIButton *)sender;
    GoodsListModel *model = [self.DataArray objectAtIndex:btn.tag];
    model.Type = self.Type;
    //判断是否存在相同类型的商品
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
     view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    CarHaveSameGoods oneSuc = [TimeObject isHaveTwoClassOfInCar:model.Type];
    if (oneSuc == CarHaveSameGoodsNomal) {
        
        BOOL success = [[GoodsDetailDataBase shareDataBase]insertItem:model];
        if (success == YES) {
            [ITTMessageView showMessage:@"已加入购物车" disappearAfterTime:0.3f andView:view];
        }else{
            [ITTMessageView showMessage:@"该商品已存在" disappearAfterTime:0.3f andView:view];
        }
    }
    else
    {
        if (oneSuc == CarHaveSameGoodsPoint) {
             [ITTMessageView showMessage:@"购物中已车存在积分商品,不能添加,请清空购物车后添加" disappearAfterTime:0.3 andView:view];
        }else{
             [ITTMessageView showMessage:@"购物车中已存在现金商品,不能添加,请清空购物车后添加" disappearAfterTime:0.3 andView:view];
        }
     
    }
    
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    [_ITTTabBarController setNumberlable];
    [self.Carview SetCarNumber];

}
#pragma mark -
#pragma mark NavigationBtnAction
/**
 *  导航栏按钮事件
 */
- (IBAction)SearchButtonClick:(id)sender {
    SearchViewController *svc = [[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];
    [self.navigationController pushViewController:svc animated:YES];
}
- (IBAction)PopViewButtonClick:(id)sender {
    if (_isTabBarHidden == NO) {
        _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
        _ITTTabBarController.tabBarHidden = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
