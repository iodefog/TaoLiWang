//
//  EditorAddressViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-18.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "EditorAddressViewController.h"
#import "AddAddressViewController.h"
#import "AddressCell.h"
#import "AddressModel.h"
#import "MyAddressDataBase.h"
#import "SendInformation.h"
#import "ModifyInformationDataRequest.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"

@interface EditorAddressViewController ()
@property (nonatomic, assign) int                       IndexPathRow;
@property (nonatomic, strong) NSMutableArray            *DataArray;
@property (nonatomic, strong) UserInfomationModel       *UserModel;
@property (strong, nonatomic)ITTTabBarController        *TabBarControl;
@end

@implementation EditorAddressViewController
{
    __weak IBOutlet UITableView *ContenTableView;
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
-(void)startModifyRequest:(AddressModel *)model andType:(NSString *)type andTag:(int)tag
{
    NSDictionary *param = @{@"dzid": model.AddressId,
                            @"yhid": self.UserModel.UserId,
                            @"shrmc": model.Name,
                            @"szsf": model.Province,
                            @"szdq": model.city,
                            @"shrsj": model.Phone,
                            @"shrdz": model.Address,
                            @"yzbm": model.ZipCode,
                            @"sfsxdz":type};
    [ModifyInformationDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            UITableViewCell *cell01 = [ContenTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_IndexPathRow inSection:0]];
            AddressCell *cell1 = (AddressCell *)cell01;
            
            UITableViewCell *cell02 = [ContenTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:tag-100 inSection:0]];
            AddressCell *cell2 = (AddressCell *)cell02;
            
            [cell1.SelectBtn setSelected:NO];
            [cell1.BackBtn setSelected:NO];
            [cell2.SelectBtn setSelected:YES];
            [cell2.BackBtn setSelected:YES];
            _IndexPathRow = tag - 100;
        }
        
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
    
}

-(void)startRequest
{
    NSDictionary *param = @{@"yhid": self.UserModel.UserId};
    [SendInformation requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        self.DataArray = request.handleredResult[@"AddressModel"];
        [[MyAddressDataBase shareDataBase]deleteTable:@"MyAddress"];
        [[MyAddressDataBase shareDataBase] insertItemArray:self.DataArray];
        [ContenTableView setHidden:NO];
        [ContenTableView reloadData];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}

#pragma mark
#pragma mark ViewDidload
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startRequest];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     self.UserModel = [SaveAndGetUserInformation readUserDefaults];
}

- (IBAction)popViewControllerButtonCLick:(id)sender {
    if (self.isPerson == YES) {
        _TabBarControl = (ITTTabBarController*)self.tabBarController;
        _TabBarControl.tabBarHidden = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark
#pragma mark UiTableVieDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentify = @"cell";
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AddressCell" owner:self options:nil]lastObject];
    }
    AddressModel *model = [self.DataArray objectAtIndex:indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@%@",model.Address,model.ZipCode];
    cell.contentLable.text = [NSString stringWithFormat:@"%@     %@\n%@",model.Name,model.Phone,str];
    if ([model.type isEqualToString:@"1"]) {
        _IndexPathRow = indexPath.row;
        [cell.SelectBtn setSelected:YES];
        [cell.BackBtn setSelected:YES];
    }
    [cell.SelectBtn addTarget:self action:@selector(SelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.SelectBtn.tag = indexPath.row + 100;
    [cell.editorBtn addTarget:self action:@selector(editorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.editorBtn.tag = indexPath.row + 100;
    return cell;
}
-(void)SelectBtnClick:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    if (_IndexPathRow != btn.tag - 100) {
        [self startModifyRequest:[self.DataArray objectAtIndex:btn.tag - 100] andType:@"1" andTag:btn.tag];
    }
}
-(void)editorBtnClick:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    AddAddressViewController *avc = [[AddAddressViewController alloc]initWithNibName:@"AddAddressViewController" bundle:nil];
    avc.NameStr = @"编辑信息";
    avc.isType = @"1";
    avc.selectIndexRow = btn.tag-100;
    [self.navigationController pushViewController:avc animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.DataArray.count == 3) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5,0, 310, 85)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5,0, 310, 85)];
        view.backgroundColor = [UIColor clearColor];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake(83, 20,145, 45);
        [btn setBackgroundImage:[UIImage imageNamed:@"选择收货地址ios_21"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"选择收货地址_03"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(getTheValueOfGoods:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(83, 30, 145, 25)];
        lable.text = @"+新增收货地址";
        lable.backgroundColor = [UIColor clearColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor blackColor];
        [view addSubview:btn];
        [view addSubview:lable];
        return view;
    }
}
-(void)getTheValueOfGoods:(UIButton *)sender
{
    AddAddressViewController *avc = [[AddAddressViewController alloc]initWithNibName:@"AddAddressViewController" bundle:nil];
    avc.NameStr = @"新增信息";
    avc.isType = @"1";
    [self.navigationController pushViewController:avc animated:YES];
}
@end
