//
//  ShopingCarViewController.m
//  TaoliWang
//
//  Created by zdqk on 14-1-8.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ShopingCarViewController.h"
#import "GoodsDetailsViewController.h"
#import "TopUpViewController.h"
#import "ShopingCarCell.h"
#import "GoodsListModel.h"
#import "GoodsDetailDataBase.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"
#import "GoodsCarListDataRequest.h"
#import "AppDelegate.h"

@interface ShopingCarViewController ()
@property (weak, nonatomic) IBOutlet UIView                 *CompleteView;
@property (weak, nonatomic) IBOutlet UILabel                *PriceLable;
@property (weak, nonatomic) IBOutlet UIButton               *editorBtn;
@property (nonatomic, strong) UserInfomationModel           *userModel;
@property (nonatomic, assign) int                           GoodsPrice;
@property (nonatomic, strong)ITTTabBarController            *ITTTabBarController;
@property (nonatomic, strong)TopUpViewController            *tvc;
@property (nonatomic, strong)GoodsListModel                 *detailModel;
@property (nonatomic, strong)NSMutableArray                 *dataArray;
@property (weak, nonatomic) IBOutlet UITableView            *CarTableView;
@property (nonatomic,assign)BOOL                            isShowDelete;
@property (nonatomic, assign)BOOL                           isShowDeleteYesOrNo;
@property (nonatomic, strong)NSMutableArray                 *cellArray;
@property (nonatomic, assign)float                          price;
@property (nonatomic, assign)int                            point;
@property (nonatomic, assign)int                            Number;
@property (nonatomic, strong)UIImageView                    *image;
@end

@implementation ShopingCarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark -
#pragma mark totalPriceAndViewWillAppear
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.dataArray = [[GoodsDetailDataBase shareDataBase] readTableName:@"CarsList"];
    if ([self.dataArray count] == 0) {
        [_CompleteView setHidden:NO];
        return;
    }else{
        [_CompleteView setHidden:YES];
    }
    [self setTotalPrice:self.dataArray];
    [_CarTableView reloadData];
}
-(void)setTotalPrice:(NSMutableArray *)array
{
    self.point = 0;
    self.price = 0;
    for (GoodsListModel *model in array) {
        self.point += [model.cklsj floatValue]*[model.GoodsNumber intValue];
        self.price += [model.tlscj floatValue]*[model.GoodsNumber intValue];
    }
    if (self.point == 0) {
        _PriceLable.text = [NSString stringWithFormat:@"总计: %.2f元",self.price];
    }else{
       _PriceLable.text = [NSString stringWithFormat:@"总计: %d积分",self.point];
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self iphone5Andiphone4];
}

- (void)iphone5Andiphone4
{
    self.detailModel = [[GoodsListModel alloc]init];
    self.dataArray = [[NSMutableArray alloc]init];
    _isShowDelete = NO;
    _isShowDeleteYesOrNo = NO;
    self.tvc = [[TopUpViewController alloc]initWithNibName:@"TopUpViewController" bundle:nil];
    self.userModel = [SaveAndGetUserInformation readUserDefaults];
    if (!iPhone5) {
        self.CarTableView.frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height - 64 - 49 - 41);
    }
    _CarTableView.tableFooterView = [self getFootView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _isShowDelete = NO;
    [_editorBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_CarTableView reloadData];
    _isShowDeleteYesOrNo =  NO;
    [_editorBtn setTitle:@"编辑" forState:UIControlStateNormal];
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
#pragma UITableViewDatasourse
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    ShopingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopingCarCell" owner:self options:nil]lastObject];
    }
    /**
     *  数据加载
     */
    GoodsListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell.ShopImageView loadImage:model.tpmc];
    cell.NameLable.text = model.chmc;
    cell.ProductId.text = model.GoodsId;
    cell.PriceLable.text = [NSString stringWithFormat:@"%@元",model.tlscj];
    if ([model.Type isEqualToString:@"10"]) {
        cell.PriceLable.text = [NSString stringWithFormat:@"%@积分",model.cklsj];
    }
    /**
     *  textField设置;
     */
    cell.NubmberTextField.text = model.GoodsNumber;
    cell.NubmberTextField.delegate = self;
    _image= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    _image.userInteractionEnabled = YES;
    [_image setImage:[UIImage imageNamed:@"TabBar_Bg.png"]];
    cell.NubmberTextField.inputAccessoryView = _image;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(260, 2, 50, 40);
    [btn addTarget:cell.NubmberTextField action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    [_image addSubview:btn];
    
    /**
     *  减少按钮
     */
    [cell.reduceBtn addTarget:self action:@selector(reduceClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.reduceBtn.tag = indexPath.row + 100;
    /**
     *  增加按钮
     */
    [cell.increaseBtn addTarget:self action:@selector(increaseClcik:) forControlEvents:UIControlEventTouchUpInside];
    cell.increaseBtn.tag = indexPath.row + 100;
    /**
     *  删除按钮
     */
    
    [cell.DeleteBtn addTarget:self action:@selector(deleteClcik:) forControlEvents:UIControlEventTouchUpInside];
    cell.DeleteBtn.tag = indexPath.row + 100;
    
    /**
     *  删除界面
     */
    cell.BackGrondView.frame = CGRectMake(0, 0, 380, 95);
    if (_isShowDelete == YES) {
        cell.BackGrondView.frame = CGRectMake(-60, 0, 380, 95);
    }
    /**
     *  删除事件
     */
    [cell.NubmberTextField addTarget:self action:@selector(getTheEndEditor:) forControlEvents:UIControlEventEditingDidEnd];
    cell.NubmberTextField.tag = indexPath.row + 100;
    return cell;
    
}

- (UIView *)getFootView{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(5, 10, 310, 35);
    [btn setTitle:@"去结算" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"Login_Nomal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"Login_Select"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(GetValuesClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    return view;
}
/**
 *  cell上的点击事件
 *
 *  @param sender
 */
#pragma mark -
#pragma mark CellButtonCLick
-(void)reduceClick:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    UITableViewCell *cell = [_CarTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag-100 inSection:0]];
    ShopingCarCell *cell1 = (ShopingCarCell *)cell;
    _Number = [cell1.NubmberTextField.text intValue];
    if (_Number <= 1) {
        return;
    }
    _Number--;
    
    cell1.NubmberTextField.text = [NSString stringWithFormat:@"%d",_Number];
    
    GoodsListModel *model = [[GoodsListModel alloc]init];
    model.GoodsId = cell1.ProductId.text;
    [[GoodsDetailDataBase shareDataBase] updateItem:model andProNumber:[NSString stringWithFormat:@"%d",_Number]];
    
    NSMutableArray *array = [[GoodsDetailDataBase shareDataBase]readTableName:@"CarsList"];
    [self setTotalPrice:array];
}
-(void)increaseClcik:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    UITableViewCell *cell = [_CarTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag-100 inSection:0]];
    ShopingCarCell *cell1 = (ShopingCarCell *)cell;
    _Number = [cell1.NubmberTextField.text intValue];
    _Number++;
    
    //ui显示
    cell1.NubmberTextField.text = [NSString stringWithFormat:@"%d",_Number];
    //存储数据
    GoodsListModel *model = [[GoodsListModel alloc]init];
    model.GoodsId = cell1.ProductId.text;
    [[GoodsDetailDataBase shareDataBase] updateItem:model andProNumber:[NSString stringWithFormat:@"%d",_Number]];
   
    NSMutableArray *array = [[GoodsDetailDataBase shareDataBase]readTableName:@"CarsList"];
    [self setTotalPrice:array];

}
-(void)deleteClcik:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    UITableViewCell *cell = [_CarTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag-100 inSection:0]];
    ShopingCarCell *cell1 = (ShopingCarCell *)cell;
    GoodsListModel *model = [[GoodsListModel alloc]init];
    model.GoodsId = cell1.ProductId.text;
    [UIView animateWithDuration:0.5 animations:^{
        cell1.BackGrondView.frame = CGRectMake(-400, 0, 400, 95);
        [[GoodsDetailDataBase shareDataBase] deleteTableProductId:model];
    } completion:^(BOOL finished) {
        [cell1.BackGrondView removeFromSuperview];
        self.dataArray = [[GoodsDetailDataBase shareDataBase] readTableName:@"CarsList"];
        if ([self.dataArray count] == 0) {
            [_CompleteView setHidden:NO];
            _isShowDelete = NO;
            _isShowDeleteYesOrNo =  NO;
            [_editorBtn setTitle:@"编辑" forState:UIControlStateNormal];
        }else{
            [_CompleteView setHidden:YES];
        }
        [self setTotalPrice:self.dataArray];
        [_CarTableView reloadData];
        
    }];
    /**
     *  设置tabbarlable显示
     */
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    [_ITTTabBarController setNumberlable];
}
-(void)getTheEndEditor:(UITextField *)text
{
    UITextField *tx = (UITextField *)text;
    if ([tx.text isEqualToString:@"0"] ||[tx.text length] ==0) {
        tx.text = @"1";
    }
    UITableViewCell *cell = [_CarTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:tx.tag-100 inSection:0]];
    ShopingCarCell *cell1 = (ShopingCarCell *)cell;
    GoodsListModel *model = [[GoodsListModel alloc]init];
    model.GoodsId = cell1.ProductId.text;
    
    [[GoodsDetailDataBase shareDataBase] updateItem:model andProNumber:tx.text];
    NSMutableArray *array = [[GoodsDetailDataBase shareDataBase]readTableName:@"CarsList"];
    
    [self setTotalPrice:array];
}


#pragma mark
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    GoodsDetailsViewController *gvc = [[GoodsDetailsViewController alloc]initWithNibName:@"GoodsDetailsViewController" bundle:nil];
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = YES;
    gvc.GoodsId = model.GoodsId;
    gvc.isHiddenTabBar = YES;
    if ([model.Type isEqualToString:isGoodsTypePoint]) {
        gvc.GoodsType = isGoodsTypePoint;
    }else{
        gvc.GoodsType = isGoodsTypeMoney;
    }
    [self.navigationController pushViewController:gvc animated:YES];

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];

}
- (void)GetValuesClick:(UIButton *)sender
{
    if (!isReachability) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"您的网络不给力哦~"];
        return;
    }
    if (self.userModel.UserId.length == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"提示" message:@"请您先登录再来结算!" cancel:@"取消" others:@"确认"];
        return;
    }
    
    if ([self.dataArray count] == 0) {
        [_editorBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"您好,购物车没有商品,无法结算!"];
        return;
    }
    
    if (self.point !=0 && self.price != 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"购物车只能存在一种类型商品,不能同时结算积分和现金商品,谢谢合作!"];
        return;
    }
    
    if ([self.userModel.Point intValue] < self.point) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"您的积分不够,请先充值"];
        return;
    }
    
    
    _isShowDelete = NO;
    [_editorBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_CarTableView reloadData];
    _isShowDeleteYesOrNo =  NO;
    [_editorBtn setTitle:@"编辑" forState:UIControlStateNormal];
    

    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = YES;
    self.tvc.price = self.price;
    self.tvc.point = self.point;
    self.tvc.listArray = self.dataArray;
    [self.navigationController pushViewController:self.tvc animated:YES];
}



#pragma mark -
#pragma mark NavigationButtonAction
- (IBAction)editorButtomClick:(id)sender {
    
    if ([self.dataArray count] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"您好,购物车没有商品,无法编辑!"];
        return;
    }
    if (_isShowDeleteYesOrNo == NO) {
        _isShowDelete = YES;
        [_editorBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_CarTableView reloadData];
        _isShowDeleteYesOrNo = YES;
        return;
    }if (_isShowDeleteYesOrNo == YES)
    {
        _isShowDelete = NO;
        [_editorBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_CarTableView reloadData];
        _isShowDeleteYesOrNo =  NO;
        return;
    }
}

#pragma mark
#pragma mark TextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect rt = [textField convertRect:textField.frame toView:self.view];
    if (rt.origin.y> 300 && rt.origin.y< 400) {
        [UIView animateWithDuration:0.5 animations:^{
            self.CarTableView.frame = CGRectMake(0, -75, 320, 420);
        } completion:^(BOOL finished) {
            
        }];
    }
    if (rt.origin.y>400 &&rt.origin.y<500) {
        [UIView animateWithDuration:0.5 animations:^{
            self.CarTableView.frame = CGRectMake(0, -170, 320, 420);
        } completion:^(BOOL finished) {
            
        }];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.5 animations:^{
        self.CarTableView.frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height - 64 - 49 - 41);
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1002) {
        if (buttonIndex == 1) {
            
            _isShowDelete = NO;
            [_editorBtn setTitle:@"编辑" forState:UIControlStateNormal];
            [_CarTableView reloadData];
            _isShowDeleteYesOrNo =  NO;
            [_editorBtn setTitle:@"编辑" forState:UIControlStateNormal];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            [SharedApp showViewController:LOGIN_VIEW_CONTROLLER andIndex:0];
        }
    }
}
@end
