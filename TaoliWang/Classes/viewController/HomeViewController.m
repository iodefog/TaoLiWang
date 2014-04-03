//
//  HomeViewController.m
//  TaoliWang
//
//  Created by zdqk on 14-1-8.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchViewController.h"
#import "ScanningViewController.h"
#import "GoodsDetailsViewController.h"
#import "GetPointViewController.h"
#import "CashGiftViewController.h"
#import "SearchPointViewController.h"
#import "FavourableActivityViewController.h"
#import "PromotionAdvertViewController.h"
#import "HomeInformationModel.h"
#import "HomeRequestData.h"
#import "SaveAndGetUserInformation.h"
#import "UserInfomationModel.h"
#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>

@interface HomeViewController ()

@property (nonatomic, strong) NSMutableArray             *DataArray;
@property (nonatomic, strong) NSMutableArray             *HeadArray;
@property (nonatomic, strong) NSMutableArray             *FootArray;

@property (nonatomic, assign) int                        TimeNum;
@property (nonatomic, assign) BOOL                       Tend;
@property (nonatomic, strong)ITTTabBarController         *ITTTabBarController;
@property (weak, nonatomic) IBOutlet UIScrollView        *HeadScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView        *BackScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl       *HeadPageControl;

@property (weak, nonatomic) IBOutlet UILabel *LoginLable;
@property (weak, nonatomic) IBOutlet ITTImageView        *ActivityImageView02;
@property (weak, nonatomic) IBOutlet UILabel             *GoodsNameLable;
@property (strong, nonatomic)UserInfomationModel         *UserModel;
@property (strong, nonatomic)HomeInformationModel        *DataModel;
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.HeadArray = [[NSMutableArray alloc]initWithCapacity:10];
        self.FootArray = [[NSMutableArray alloc]initWithCapacity:10];

    }
    return self;
}

#pragma mark - 
#pragma mark StartRequestData

/**
 *  网络数据请求
 */
-(void)startHomeDataRequest
{
 [HomeRequestData requestWithParameters:nil
                      withIndicatorView:self.view
                      withCancelSubject:nil
                         onRequestStart:
  ^(ITTBaseDataRequest *request) {
     
 } onRequestFinished:^(ITTBaseDataRequest *request) {
     
     self.DataArray  = request.handleredResult[@"HomeInformationModel"];
     for (HomeInformationModel *model in self.DataArray) {
         if ([model.type isEqualToString:isGoodsTypeActivity]) {
             [self.FootArray addObject:model];
         }else{
             [self.HeadArray addObject:model];
         }
     }
     [self setHomeheadView];
     [self setActivityZone];
     
 } onRequestCanceled:^(ITTBaseDataRequest *request) {
     
 } onRequestFailed:^(ITTBaseDataRequest *request) {
     
 }];
}


#pragma mark - 
#pragma mark viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (Screen_height == 480) {
        [_BackScrollView setContentSize:CGSizeMake(320, 765-40)];
    }else{
        [_BackScrollView setContentSize:CGSizeMake(320, 677-40)];
    }
    if (!isReachability) {
        
    }else{
        [self startHomeDataRequest];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.UserModel = [SaveAndGetUserInformation readUserDefaults];
    if ([self.UserModel.UserId length] == 0) {
        [_LoginLable setText:@"登录"];
        
    }else
    {
        [_LoginLable setText:@"退出"];
    }
}


/**
 *  扫描和搜索
 *
 *  @param sender
 */
#pragma mark -
#pragma NavigationAction
- (IBAction)SearchButtonClick:(id)sender {
    if ([self.UserModel.UserId length] == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [SharedApp showViewController:LOGIN_VIEW_CONTROLLER andIndex:0];
    }else
    {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"确定要退出吗？" cancel:@"取消" others:@"确定"];
    }
}
- (IBAction)ScanningButtonClick:(id)sender {
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = YES;
    ScanningViewController *svc = [[ScanningViewController alloc]initWithNibName:@"ScanningViewController" bundle:nil];
    svc.Scanning = isHome;
    svc.TitleStr = @"扫二维码";
    [self.navigationController pushViewController:svc animated:YES];
}



/**
 *  商品展示区
 */
#pragma mark -
#pragma ScrollViewAction
-(void)setHomeheadView
{
    if (self.HeadArray.count == 0) {
        return;
    }
    [_HeadScrollView setContentSize:CGSizeMake(320*self.HeadArray.count, 170)];
    _HeadPageControl.numberOfPages = self.HeadArray.count;
    self.DataModel = [self.HeadArray objectAtIndex:0];
    _GoodsNameLable.text = self.DataModel.wzjs;
    /**
     *  在ScrollView上加载图片和商品名称
     */
    for (int i = 0; i < self.HeadArray.count; i++) {
        self.DataModel = [self.HeadArray objectAtIndex:i];
        ITTImageView *ScroImageView = [[ITTImageView alloc]init];
        ScroImageView.frame = CGRectMake(i*320, 0, 320, 170);
        [ScroImageView loadImage:self.DataModel.tpmc];
        ScroImageView.userInteractionEnabled = YES;
        ScroImageView.tag = i + 10;
        
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewTapAction:)];
        tapGest.numberOfTouchesRequired = 1;
        [ScroImageView addGestureRecognizer:tapGest];
        [_HeadScrollView addSubview:ScroImageView];
        
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = _HeadScrollView.contentOffset.x/320;
    _HeadPageControl.currentPage = page;
    self.DataModel = [self.HeadArray objectAtIndex:page];
    _GoodsNameLable.text = self.DataModel.wzjs;
}
-(void)handleTimer:(NSTimer *)timer
{
    if (_TimeNum % self.HeadArray.count == 0) {
        if (!_Tend) {
            _HeadPageControl.currentPage++;
            if (_HeadPageControl.currentPage == _HeadPageControl.numberOfPages-1) {
                _Tend = YES;
            }
        }else{
            _HeadPageControl.currentPage--;
            if (_HeadPageControl.currentPage == 0) {
                _Tend = NO;
            }
        }
        [UIView animateWithDuration:0.7 animations:^{
            _HeadScrollView.contentOffset = CGPointMake(_HeadPageControl.currentPage*320, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
    _TimeNum ++;
}
-(void)scrollViewTapAction:(UITapGestureRecognizer *)tap
{
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = YES;
    GoodsDetailsViewController *gvc = [[GoodsDetailsViewController alloc]initWithNibName:@"GoodsDetailsViewController" bundle:nil];
    self.DataModel = [self.HeadArray objectAtIndex:tap.view.tag-10];
    if ([self.DataModel.type isEqualToString:isGoodsTypePoint]) {
        gvc.GoodsType = isGoodsTypePoint;
    }else{
        gvc.GoodsType = isGoodsTypeMoney;
    }
    gvc.isHiddenTabBar = YES;
    gvc.GoodsId = self.DataModel.lxdz;
    [self.navigationController pushViewController:gvc animated:YES];
   
}



/**
 *  积分专区
 */
#pragma mark -
#pragma IntegralZoneAction
- (IBAction)GetPointButtonClick:(id)sender {
    
    self.UserModel = [SaveAndGetUserInformation readUserDefaults];
    if ([self.UserModel.UserId length] == 0) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [SharedApp showViewController:LOGIN_VIEW_CONTROLLER andIndex:0];
        return;
    }
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = YES;
    GetPointViewController *gvc = [[GetPointViewController alloc]initWithNibName:@"GetPointViewController" bundle:nil];
    gvc.isHomePopToHere = YES;
    [self.navigationController pushViewController:gvc animated:YES];
}
- (IBAction)CashGiftButtonClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = YES;
    CashGiftViewController *cvc = [[CashGiftViewController alloc]initWithNibName:@"CashGiftViewController" bundle:nil];
    if (btn.tag == 1001) {
        cvc.Type = isGoodsTypePoint;
    }else{
        cvc.Type = isGoodsTypeMoney;
    }
    cvc.UserId = self.UserModel.UserId;
    [self.navigationController pushViewController:cvc animated:YES];
}
- (IBAction)FavourableActivityButtonClick:(id)sender {
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = YES;
    FavourableActivityViewController *fvc = [[FavourableActivityViewController alloc]initWithNibName:@"FavourableActivityViewController" bundle:nil];
    [self.navigationController pushViewController:fvc animated:YES];
}




/**
 *  活动专区
 */
#pragma mark -
#pragma ActivityZoneAction
-(void)setActivityZone
{
    self.DataModel = [self.FootArray objectAtIndex:0];
    [_ActivityImageView02 loadImage:self.DataModel.tpmc];
}
- (IBAction)ActivityZoneButton01Click:(id)sender {
    UIButton *btn = (UIButton *)sender;
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = YES;
    PromotionAdvertViewController *avc = [[PromotionAdvertViewController alloc]initWithNibName:@"PromotionAdvertViewController" bundle:nil];
    avc.isRootViewController = YES;
    if ([self.FootArray count] > btn.tag-1000) {
        self.DataModel = [self.FootArray objectAtIndex:btn.tag-1000];
        avc.ActivityId = self.DataModel.lxdz;
    }
    [self.navigationController pushViewController:avc animated:YES];
}

//退出登录
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
        if (buttonIndex == 1) {
            self.UserModel.UserId = @"";
            self.UserModel.UserName = @"";
            self.UserModel.Password = @"";
            self.UserModel.Point = @"";
            self.UserModel.Phone = @"";
            self.UserModel.Email = @"";
            [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
            [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
            [SaveAndGetUserInformation saveUserDefaultsWithTheUserInformation:self.UserModel];
            [self.navigationController popToRootViewControllerAnimated:NO];
            [SharedApp showViewController:LOGIN_VIEW_CONTROLLER andIndex:0];
        }
    }
}

@end
