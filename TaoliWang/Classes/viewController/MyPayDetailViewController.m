//
//  MyPayDetailViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-8.
//  Copyright (c) 2014年 Custom. All rights reserved.
//


#import "MyPayDetailViewController.h"
#import "MyPayDetailCell.h"
#import "MyPay01Cell.h"
#import "MyPay02Cell.h"
#import "MyCountDetailRequest.h"
#import "GoodsDetailsViewController.h"
#import "myOrderDetailModel.h"
#import "MyOrderGoodsListModel.h"

@interface MyPayDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView    *DetailTableView;
@property (strong, nonatomic) myOrderDetailModel    *detailModel;
@property (weak, nonatomic) IBOutlet UIView *ContentBackView;
@property (strong, nonatomic) NSMutableArray        *OrderArray;
@end

@implementation MyPayDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)startRequest
{
    NSDictionary *param = @{@"yhid": self.userID,
                            @"ddbh": self.GoodsId};
    [MyCountDetailRequest requestWithParameters:param
                              withIndicatorView:self.view
                              withCancelSubject:nil
                                 onRequestStart:
     ^(ITTBaseDataRequest *request) {
    
     } onRequestFinished:^(ITTBaseDataRequest *request) {
         self.detailModel = request.handleredResult[@"myOrderDetailModel"];
         self.OrderArray = request.handleredResult[@"MyOrderGoodsListModel"];
         [self.DetailTableView reloadData];
     } onRequestCanceled:^(ITTBaseDataRequest *request) {
    
     } onRequestFailed:^(ITTBaseDataRequest *request) {
    
     }];
}
#pragma mark
#pragma mark LoadingUI
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initIphone4Or5];
    [self startRequest];
}
-(void)initIphone4Or5
{
    self.OrderArray = [[NSMutableArray alloc]initWithCapacity:100];
    //加载headView
    CGRect frame = self.DetailTableView.tableHeaderView.frame;
    frame.size.height = 10;
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    [self.DetailTableView setTableHeaderView:headerView];

    if (Screen_height == 480) {
        if (isIOS7) {
            self.DetailTableView.frame = CGRectMake(0, 0, 320, 410);
        }else{
            self.DetailTableView.frame = CGRectMake(0, 0, 320, 410);
            self.ContentBackView.frame = CGRectMake(0, 44, 300, 410);
        }
    }else
    {
        if (isIOS7) {
            self.DetailTableView.frame = CGRectMake(0, 0, 320, 504);
        }else{
            self.ContentBackView.frame = CGRectMake(0, 44, 320, 504);
            self.DetailTableView.frame = CGRectMake(0, 0, 320, 504);
        }
    }
}
#pragma mark
#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    if(section == 1){
        return [self.OrderArray count];
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 115;
    }else{
        return 70;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /**
     *  不同cell上的背景图片
     */
    static NSString *indentify = @"cell";
    if (indexPath.section == 0) {
        MyPay01Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MyPay01Cell" owner:self options:nil]lastObject];
        }
        cell.OrderBHLable.text = self.detailModel.OrderBH;
        cell.OrderTimeLable.text = self.detailModel.OrderSJ;
        
        return cell;
    }else if (indexPath.section == 1){
        MyPayDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MyPayDetailCell" owner:self options:nil]lastObject];
        }
        if (indexPath.row == 0) {
            if (self.OrderArray.count == 1) {
                [cell.BackButton setImage:[UIImage imageNamed:@"Input"] forState:UIControlStateNormal];
                [cell.BackButton setImage:[UIImage imageNamed:@"输入框-单条-选中"] forState:UIControlStateHighlighted];
            }else{
                [cell.BackButton setImage:[UIImage imageNamed:@"订单详情-大文本框-上-默认"] forState:UIControlStateNormal];
                [cell.BackButton setImage:[UIImage imageNamed:@"订单详情-大文本框-上-选中"] forState:UIControlStateHighlighted];
            }
        }else if (indexPath.row == [self.OrderArray count]-1){
            [cell.BackButton setImage:[UIImage imageNamed:@"订单详情-大文本框-下-默认"] forState:UIControlStateNormal];
            [cell.BackButton setImage:[UIImage imageNamed:@"订单详情-大文本框-下-选中"] forState:UIControlStateHighlighted];
        }else{
            [cell.BackButton setImage:[UIImage imageNamed:@"订单详情-大文本框-中-默认"] forState:UIControlStateNormal];
            [cell.BackButton setImage:[UIImage imageNamed:@"订单详情-大文本框-中-选中"] forState:UIControlStateHighlighted];
        }
        MyOrderGoodsListModel *model = [self.OrderArray objectAtIndex:indexPath.row];;
        [cell.PhotoImageView loadImage:model.tp];
        cell.NameLable.text = model.hpmc;
        if ([model.dhjf isEqualToString:@"0"]) {
            cell.PriceLable.text = [NSString stringWithFormat:@"%@元",model.dhdj];
        }else{
            cell.PriceLable.text = [NSString stringWithFormat:@"%@积分",model.dhjf];
        }
        cell.NumberLable.text = [NSString stringWithFormat:@"x%@",model.sl];
        [cell.BackButton addTarget:self action:@selector(BackButtonClcik:) forControlEvents:UIControlEventTouchUpInside];
        cell.BackButton.tag = indexPath.row +100;
        return cell;

    }else{
        MyPay02Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MyPay02Cell" owner:self options:nil]lastObject];
        }
        
        float price = 0 ;
        int point  = 0;
        for (MyOrderGoodsListModel *model in self.OrderArray) {
            price = price + [model.dhje floatValue]*[model.sl intValue];
            point = point + [model.dhjf intValue]*[model.sl intValue];
            
            if ([model.dhjf isEqualToString:@"0"]) {
                cell.MoneyLable.text = [NSString stringWithFormat:@"%.2f元",price];
            }else{
                cell.MoneyLable.text = [NSString stringWithFormat:@"%d积分",point];
            }
        }
        cell.NameLable.text = self.detailModel.Name;
        cell.PhoneLable.text = self.detailModel.phone;
        cell.AddressLable.text = self.detailModel.Address;
        return cell;
    }
}
#pragma mark
#pragma mark TableViewDataSource
-(void)BackButtonClcik:(UIButton *)sender{
    UIButton *btn = (UIButton *)sender;
    GoodsDetailsViewController *gvc = [[GoodsDetailsViewController alloc]initWithNibName:@"GoodsDetailsViewController" bundle:nil];
    MyOrderGoodsListModel *model = [self.OrderArray objectAtIndex:btn.tag -100];;
    gvc.GoodsId = model.hpid;
    if ([model.dhjf isEqualToString:@"0"]) {
        gvc.GoodsType = isGoodsTypeMoney;
    }else{
        gvc.GoodsType = isGoodsTypePoint;
    }
    [self.navigationController pushViewController:gvc animated:YES];
}
#pragma mark
#pragma mark PopViewControlerButtonAction
- (IBAction)popViewBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
