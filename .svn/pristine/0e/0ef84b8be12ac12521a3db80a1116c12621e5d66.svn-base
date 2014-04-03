//
//  SearchPointViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//
/**
 *  按钮字体颜色选择
 */
#define FontColor01           [UIColor colorWithRed:247/255.0 green:120/255.0 blue:58/255.0 alpha:1]
#define FontColor02           [UIColor whiteColor]

#import "SearchPointViewController.h"
#import "PointRecordCell.h"
#import "MyPointDataRequest.h"
#import "PointSearchDataRequest.h"
#import "CashGiftViewController.h"
#import "PointSearchModel.h"
#import "TimeObject.h"

@interface SearchPointViewController ()
@property (nonatomic, strong)ITTTabBarController        *ITTTabBarController;
@property (nonatomic, strong)UIButton                   *selectButton;
@property (weak, nonatomic) IBOutlet UIButton           *GetPointBtn;
@property (weak, nonatomic) IBOutlet UIButton           *PayPointBtn;
@property (weak, nonatomic) IBOutlet UIButton           *HeBingBtn;
@property (weak, nonatomic) IBOutlet UITableView        *ContentTableView;
@property (weak, nonatomic) IBOutlet UILabel            *MyPointLable;
@property (strong, nonatomic) NSMutableArray            *DataArray;

@end


@implementation SearchPointViewController

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
-(void)StartMyPointRequest
{

    NSDictionary *param = @{@"yhid": self.UserID};
    [MyPointDataRequest requestWithParameters:param withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
       _MyPointLable.text = [request.handleredResult[@"result"]stringValue];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}

-(void)StartPointPayRequestWithType:(NSString *)str
{
    NSDictionary *Param = @{@"yhid": self.UserID,
                            @"type": str};
    [PointSearchDataRequest requestWithParameters:Param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        [self setDataDict:request.handleredResult AndBaseManger:self.DataArray andString:str];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
    

    }];
}
-(void)setDataDict:(NSDictionary *)ResultArr AndBaseManger:(NSMutableArray *)BaseManage andString:(NSString *)str
{
    [self.DataArray removeAllObjects];
    self.DataArray = ResultArr[@"PointSearchModel"];
    for (PointSearchModel *model in self.DataArray) {
        model.type = str;
    }
    if (self.DataArray.count == 0) {
        _ContentTableView.hidden = YES;
    }else{
        _ContentTableView.hidden = NO;
    }
    [_ContentTableView reloadData];
}
#pragma mark
#pragma mark LoadingUi
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self SetUILoading];
}
-(void)SetUILoading
{
    _selectButton = _GetPointBtn;
    if (iPhone5) {
        _ContentTableView.frame = CGRectMake(0, 60, 320, 403);
    }else{
        _ContentTableView.frame = CGRectMake(0, 60, 320, 312);
    }
    self.DataArray = [[NSMutableArray alloc]initWithCapacity:1000];
    [self StartMyPointRequest];
    [self StartPointPayRequestWithType:@"1"];
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
    PointRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PointRecordCell" owner:self options:nil]lastObject];
    }
    PointSearchModel *model = [self.DataArray objectAtIndex:indexPath.row];
    if ([model.type isEqualToString:@"1"]) {
        cell.NumberLable.textColor = [UIColor colorWithRed:247/255.0 green:120/255.0 blue:58/255.0 alpha:1.0];
        cell.TypeLable.text = @"充值";
        cell.DateLable.text = model.sj;
        cell.NumberLable.text = [NSString stringWithFormat:@"+%@",model.jf];
    }else if ([model.type isEqualToString:@"0"]){
        cell.NumberLable.textColor = [UIColor colorWithRed:45/255.0 green:135/255.0 blue:0/255.0 alpha:1.0];
        cell.TypeLable.text = @"消费";
        cell.DateLable.text = model.sj;
        cell.NumberLable.text = [NSString stringWithFormat:@"-%@",model.jf];;
    }else{
        cell.NumberLable.textColor = [UIColor colorWithRed:238/255.0 green:49/255.0 blue:102/255.0 alpha:1.0];
        cell.TypeLable.text = @"合并";
        cell.DateLable.text = model.sj;
        cell.NumberLable.text = model.jf;
    }
    
    return cell;
    
}

#pragma mark -
#pragma mark popviewController
/**
 *  跳转返回
 */
- (IBAction)popViewButtonClick:(id)sender {
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 
#pragma mark PointDetail
/**
 *  消费和充值记录
 */
- (IBAction)GetPointButtonLcick:(id)sender {
    [self StartPointPayRequestWithType:@"1"];
    [self setButtonState:0];
    [self setButtonTitelColor:FontColor02 andColorOne:FontColor01 andColorTwo:FontColor01];
}
- (IBAction)PayPointButtonClick:(id)sender {
    [self StartPointPayRequestWithType:@"0"];
    [self setButtonState:1];
    [self setButtonTitelColor:FontColor01 andColorOne:FontColor02 andColorTwo:FontColor01];

}
- (IBAction)HeBingButtonClick:(id)sender {
    [self StartPointPayRequestWithType:@"2"];
    [self setButtonState:2];
    [self setButtonTitelColor:FontColor01 andColorOne:FontColor01 andColorTwo:FontColor02];
}
-(void)setButtonTitelColor:(UIColor *)Color01 andColorOne:(UIColor *)color02 andColorTwo:(UIColor*)Color03
{
    [_GetPointBtn setTitleColor:Color01 forState:UIControlStateNormal];
    [_PayPointBtn setTitleColor:color02 forState:UIControlStateNormal];
    [_HeBingBtn setTitleColor:Color03 forState:UIControlStateNormal];
}
- (IBAction)DuiHuanJIfen:(id)sender {
    CashGiftViewController *cvc = [[CashGiftViewController alloc]initWithNibName:@"CashGiftViewController" bundle:nil];
    cvc.Type = isGoodsTypePoint;
    cvc.isTabBarHidden = YES;
    cvc.UserId =self.UserID;
    [self.navigationController pushViewController:cvc animated:YES];
}
-(void)setButtonState:(int)index
{
    _selectButton.enabled = YES;
    switch (index) {
        case 0:{
            _selectButton = _GetPointBtn;
            break;
        }
        case 1:{
            
            _selectButton = _PayPointBtn;
            break;
        }
        case 2:{
            _selectButton = _HeBingBtn;
            break;
        }
        default:
            break;
    }
    _selectButton.enabled = NO;
}
@end
