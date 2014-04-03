//
//  PaySuccessViewController.m
//  TaoliWang
//
//  Created by HE on 14-3-4.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "PaySuccessViewController.h"
#import "GoodsDetailDataBase.h"
#import "MyPayDetailViewController.h"

@interface PaySuccessViewController ()
@property (nonatomic, strong)ITTTabBarController            *ITTTabBarController;
@end

@implementation PaySuccessViewController
{

    __weak IBOutlet UILabel *OrderpriceLable;
    __weak IBOutlet UILabel *OrderBH;
    __weak IBOutlet UILabel *OrderJElable;
    __weak IBOutlet UILabel *PayTypeLable;

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI
{
    OrderBH.text = self.ddBH;
    if (self.point == 0) {
        OrderpriceLable.text = @"订单金额:";
        OrderJElable.text = [NSString stringWithFormat:@"%.2f元",self.price];
    }else{
        OrderpriceLable.text = @"订单积分:";
        OrderJElable.text = [NSString stringWithFormat:@"%d积分",self.point];
    }
    PayTypeLable.text = [NSString stringWithFormat:@"%@方式",self.PayType];
    
}
- (IBAction)OrderDetailClick:(id)sender {
    MyPayDetailViewController *mvc= [[MyPayDetailViewController alloc]initWithNibName:@"MyPayDetailViewController" bundle:nil];
    mvc.userID = self.UserId;
    mvc.GoodsId = self.ddBH;
    [self.navigationController pushViewController:mvc animated:YES];
}
- (IBAction)PopViewControllerClick:(id)sender {
    [[GoodsDetailDataBase shareDataBase] deleteTable:@"CarsList"];
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = NO;
    [_ITTTabBarController setNumberlable];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
