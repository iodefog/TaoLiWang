//
//  SearchViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "SearchViewController.h"
#import "ITTTabBarController.h"
#import "SearchScopeCell.h"
#import "GoodsListModel.h"
#import "GoodsDetailsViewController.h"
#import "CrashGiftCell.h"
#import "SearchDataRequest.h"
#import "GoodsDetailDataBase.h"
#import "TimeObject.h"
#import "AppDelegate.h"

@interface SearchViewController ()
@property (nonatomic, strong)ITTTabBarController        *ITTTabBarController;
/**
 *  搜索框
 */
@property (weak, nonatomic) IBOutlet UITextField        *SearchTextField;
@property (weak, nonatomic) IBOutlet UILabel            *TypeSlectLable;


/**
 *  选择积分和金额按钮
 */
@property (weak, nonatomic) IBOutlet UILabel            *SelectPointLable;
@property (weak, nonatomic) IBOutlet UILabel            *SelectMoneyLable;
@property (weak, nonatomic) IBOutlet UIView             *Onebackview;

//数据
@property (nonatomic, strong)NSMutableArray             *DataArray;
@property (nonatomic, assign)int                        IndexCurrent;
@property (nonatomic, strong)ITTBaseManager             *applicationManager;
@property (nonatomic, assign)BOOL                       productType;
@property (nonatomic, copy) NSString                    *pointAndMoney;
@property (nonatomic, copy) NSString                    *searchText;
@property (nonatomic, strong) PopCarView                *Carview;



@end

@implementation SearchViewController
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
#pragma mark startRequst
-(void)StartRequestWithPage:(NSString *)page andType:(GoodsType)type andKeyWords:(NSString *)keyWords andscore:(NSString *)scoreStr andMoney:(NSString *)moneyStr
{
    
    //数据
    NSString *Typestr = [NSString string];
    NSString *scoreMin = [NSString string];
    NSString *scoreMax = [NSString string];
    NSString *moneyMin = [NSString string];
    NSString *moneyMax = [NSString string];
    
    //类型
    if (type == isSearchMoney || type == isBtnMoney) {
        Typestr = @"11";
    }
    if (type == isSearchPoint || type == isBtnPoint) {
        Typestr = @"10";
    }
    //数值
    if ([scoreStr isEqualToString:@"不限"] || [moneyStr isEqualToString:@"不限"]) {
        return;
    }
    else if ([scoreStr isEqualToString:@"99000以上"]) {
        scoreMin = @"99000";
        scoreMax = @"";
        moneyMax = @"";
        moneyMin = @"";
    }
    else if ([moneyStr isEqualToString:@"1000以上"]) {
        scoreMin = @"";
        scoreMax = @"";
        moneyMin = @"1000";
        moneyMax = @"";
    }
    else if (scoreStr.length == 0 && moneyStr.length == 0){
        scoreMin = @"";
        scoreMax = @"";
        moneyMax = @"";
        moneyMin = @"";
    }
    else{
        if (scoreStr.length != 0) {
            NSArray *strScoreArray = [scoreStr componentsSeparatedByString:@"~"];
            scoreMin = [strScoreArray objectAtIndex:0];
            scoreMax = [strScoreArray objectAtIndex:1];
            moneyMin = @"";
            moneyMax = @"";
        }
        if (moneyStr.length != 0) {
            NSArray *strMoneyArray = [moneyStr componentsSeparatedByString:@"~"];
            moneyMin = [strMoneyArray objectAtIndex:0];
            moneyMax = [strMoneyArray objectAtIndex:1];
            scoreMin = @"";
            scoreMax = @"";
        }
    }
   
    
    
    
    NSDictionary *param = @{@"keyWords":keyWords,
                            @"productType":Typestr,
                            @"scoreMin":scoreMin,
                            @"scoreMax":scoreMax,
                            @"moneyMin":moneyMin,
                            @"moneyMax":moneyMax,
                            @"pageSize":@"10",
                            @"pageNo":page};
    [SearchDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        [self setResultDict:request.handleredResult[@"GoodsListModel"]];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
-(void)setResultDict:(NSMutableArray *)array
{
    if (self.IndexCurrent == 1) {
        [self.DataArray removeAllObjects];
        [self.DataArray addObjectsFromArray:array];
        
        //UI变换
        if (self.DataArray.count == 0) {
            UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
            view.backgroundColor = [UIColor clearColor];
            [self.view addSubview:view];
            [ITTMessageView showMessage01:@"没有找到你搜索的商品哦~" disappearAfterTime:0.5 andView:view];
            ContentTableView.hidden = YES;
        }
        else{
            ContentTableView.hidden = NO;
        }
        
        [ContentTableView reloadData];
        
    }else{
        [self.DataArray  addObjectsFromArray:array];
        [self loadMoreDataDone];
        
    }
    
}



#pragma mark -
#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initIPhone4OrIphone5];
    [self InitUI];
}

- (IBAction)gestureTapGestAction:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
-(void)initIPhone4OrIphone5
{
    //数据初始化
    self.DataArray = [[NSMutableArray alloc]initWithCapacity:0];
    //刷新控制器
    self.applicationManager = [[ITTBaseManager alloc]init];
    //初始化类型为现金商品
    self.gType = isSearchMoney;
    self.productType = YES;
    //初始化页面为第一页
    self.IndexCurrent = 1;
    //隐藏刷新功能
    [ContentTableView setRefreshViewHidden:YES];
    //适配tableview的高度
    if (Screen_height == 480) {
        ContentTableView.frame = CGRectMake(0, 0, 320, 385);
    }else{
        ContentTableView.frame = CGRectMake(0, 0, 320, 472);
    }
    //加个脚标
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    view.backgroundColor = [UIColor whiteColor];
    ContentTableView.tableFooterView = view;
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



#pragma mark
#pragma mark PullTableViewDelegate
-(void)pullTableViewDidTriggerLoadMore:(ITTPullTableView *)pullTableView
{
    self.IndexCurrent++;
    [ContentTableView setLoadMoreViewHidden:NO];
    if (self.gType == isSearchPoint || self.gType == isSearchMoney) {
        [self StartRequestWithPage:[NSString stringWithFormat:@"%d",self.IndexCurrent] andType:self.gType andKeyWords:self.searchText andscore:@"" andMoney:@""];
    }
    if (self.gType == isBtnMoney) {
        [self StartRequestWithPage:[NSString stringWithFormat:@"%d",self.IndexCurrent] andType:self.gType andKeyWords:@"" andscore:@"" andMoney:self.pointAndMoney];
    }
    if (self.gType == isBtnPoint) {
        [self StartRequestWithPage:[NSString stringWithFormat:@"%d",self.IndexCurrent] andType:self.gType andKeyWords:@"" andscore:self.pointAndMoney andMoney:@""];
    }

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

#pragma mark
#pragma mark TableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *identifyCell = @"cell";
        CrashGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:identifyCell ];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"CrashGiftCell" owner:self options:nil]lastObject];
        }
        GoodsListModel *model = [self.DataArray objectAtIndex:indexPath.row];
        cell.GoodsNameLable.text = model.chmc;
        [cell.GoodsPhotoImageView loadImage:model.tpmc];
        cell.JoinCarButton.tag = indexPath.row;
        cell.GoodsPriceLable.text =[NSString stringWithFormat:@"原价:%@元",model.scj];

        if (self.gType == isSearchPoint || self.gType == isBtnPoint) {
           [cell.JoinCarButton addTarget:self action:@selector(CellPonitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.JifenLable.text = @"积分:";
            cell.GoodsPointLable.text = [NSString stringWithFormat:@"%@",model.cklsj];

        }
        if (self.gType == isSearchMoney || self.gType ==isBtnMoney) {
            [cell.JoinCarButton addTarget:self action:@selector(CellMoneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.JifenLable.text = @"售价:";
            cell.GoodsPointLable.text = [NSString stringWithFormat:@"%@元",model.tlscj];
        }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
    
}

//由于出现情况比较多所以写两种相同的方法来存现金和积分的商品
-(void)CellPonitBtnClick:(UIButton *)sender
{
    UIButton * btn = (UIButton *)sender;
    GoodsListModel *model = [self.DataArray objectAtIndex:btn.tag];
    model.GoodsNumber = @"1";
    model.Type = @"10";
    
     //判断是佛存在相同类型的商品
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 580)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    CarHaveSameGoods oneSuc = [TimeObject isHaveTwoClassOfInCar:model.Type];
    if (oneSuc == CarHaveSameGoodsNomal) {
        
        BOOL success = [[GoodsDetailDataBase shareDataBase]insertItem:model];
        if (success == YES) {
            [ITTMessageView showMessage:@"已加入购物车" disappearAfterTime:0.3 andView:view];
        }else{
            [ITTMessageView showMessage:@"该商品已存在" disappearAfterTime:0.3 andView:view];
        }
    }
    else
    {
        if (oneSuc == CarHaveSameGoodsPoint) {
            [ITTMessageView showMessage:@"购物车中已存在积分商品,不能添加,请清空购物车后添加" disappearAfterTime:0.3 andView:view];
        }else{
            [ITTMessageView showMessage:@"购物车中已存在现金商品,不能添加,请清空购物车后添加" disappearAfterTime:0.3 andView:view];
        }
        
    }
     //设置tabbarlable显示
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    [_ITTTabBarController setNumberlable];
    [self.Carview SetCarNumber];
    
}
-(void)CellMoneyBtnClick:(UIButton *)sender
{
    UIButton * btn = (UIButton *)sender;
    GoodsListModel *model = [self.DataArray objectAtIndex:btn.tag];
    model.GoodsNumber = @"1";
    model.Type = @"11";
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 580)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    //判断是佛存在相同类型的商品
    CarHaveSameGoods oneSuc = [TimeObject isHaveTwoClassOfInCar:model.Type];
    if (oneSuc == CarHaveSameGoodsNomal) {
        
        BOOL success = [[GoodsDetailDataBase shareDataBase]insertItem:model];
        if (success == YES) {
            [ITTMessageView showMessage:@"已加入购物车" disappearAfterTime:1.0 andView:view];
        }else{
            [ITTMessageView showMessage:@"该商品已存在" disappearAfterTime:1.0 andView:view];
        }
    }
    else
    {
        if (oneSuc == CarHaveSameGoodsPoint) {
            [ITTMessageView showMessage:@"购物车中已存在积分商品,不能添加,请清空购物车后添加" disappearAfterTime:1.0 andView:view];
        }else{
            [ITTMessageView showMessage:@"购物车中已存在现金商品,不能添加,请清空购物车后添加" disappearAfterTime:1.0 andView:view];
        }
        
    }
     //  设置tabbarlable显示
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    [_ITTTabBarController setNumberlable];
     [self.Carview SetCarNumber];
}

#pragma mark
#pragma mark TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    GoodsListModel *model = [self.DataArray objectAtIndex:indexPath.row];
    GoodsDetailsViewController *gvc = [[GoodsDetailsViewController alloc]initWithNibName:@"GoodsDetailsViewController" bundle:nil];
    gvc.GoodsId = model.GoodsId;
    if (self.gType == isSearchPoint || self.gType == isBtnPoint) {
        gvc.GoodsType = isGoodsTypePoint;
    }
    if (self.gType == isSearchMoney || self.gType == isBtnMoney) {
        gvc.GoodsType = isGoodsTypeMoney;
    }
    [self.navigationController pushViewController:gvc animated:YES];
    
}
#pragma mark -
#pragma mark 积分和现金限制搜索
- (IBAction)SelectPointButtonClick:(id)sender {
    ITTTableView *view = [[ITTTableView alloc]init];
    view.delegate = self;
    [view ShowTableView:isloadPoint];
}
- (IBAction)SelectMoneyButtonClick:(id)sender {
    ITTTableView *view = [[ITTTableView alloc]init];
    view.delegate = self;
    [view ShowTableView:isloadMoney];
   
}
//代理
-(void)selectRangeData:(NSString *)NameStr andType:(loadType)type{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    self.IndexCurrent = 1;
    self.pointAndMoney = NameStr;
    self.SearchTextField.text = @"";
    if (type == isloadPoint) {
        [_SelectMoneyLable setText:@"现金(不限)"];
        self.gType = isBtnPoint;
        self.SelectPointLable.text = [NSString stringWithFormat:@"积分(%@)",NameStr];
        [self StartRequestWithPage:@"1" andType:self.gType andKeyWords:@"" andscore:NameStr andMoney:@""];
    }
    if (type == isloadMoney) {
        [_SelectPointLable setText:@"积分(不限)"];
        self.gType = isBtnMoney;
        self.SelectMoneyLable.text = [NSString stringWithFormat:@"现金(%@)",NameStr];
        [self StartRequestWithPage:@"1" andType:self.gType andKeyWords:@"" andscore:@"" andMoney:NameStr];
    }
}



#pragma mark
#pragma mark 现金和积分输入搜索
- (IBAction)PointOrMoneyAction:(id)sender {
    ITTSelectView *view = [[ITTSelectView alloc]init];
    view.delegate = self;
    [view showSelectView];
}
//代理
-(void)MoneyBtnAction:(UIButton *)sender
{
    self.productType = YES;
    _TypeSlectLable.text = @"现金";
}
-(void)PointBtnAction:(UIButton *)sender{
    self.productType = NO;
    _TypeSlectLable.text = @"积分";
}




#pragma mark
#pragma mark UiTextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    [_SelectMoneyLable setText:@"现金(不限)"];
    [_SelectPointLable setText:@"积分(不限)"];
    
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
        view.backgroundColor = [UIColor clearColor];
        [self.view addSubview:view];
        [ITTMessageView showMessage01:@"搜索内容不能为空!" disappearAfterTime:0.5 andView:view];
        return YES;
    }
    self.IndexCurrent = 1;
    //只有按下search的时候 才赋值给相应的type和text
    self.searchText = self.SearchTextField.text;
    if (self.productType == YES) {
        self.gType = isSearchMoney;
    }else{
        self.gType = isSearchPoint;
    }
    
    [self StartRequestWithPage:@"1" andType:self.gType andKeyWords:self.searchText andscore:@"" andMoney:@""];
    return YES;

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _Onebackview.hidden = NO;
    textField.text = @"";
    textField.enablesReturnKeyAutomatically = YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _Onebackview.hidden = YES;
}



#pragma mark -
#pragma mark NavigationBarAction
- (IBAction)PopHomeButtonClick:(id)sender {
    if (self.HomeToSearch == YES) {
        _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
        _ITTTabBarController.tabBarHidden = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
