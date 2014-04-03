//
//  TopUpViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-15.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "TopUpViewController.h"
#import "AddressModel.h"
#import "MyAddressDataBase.h"
#import "AddAddressViewController.h"
#import "EditorAddressViewController.h"
#import "SendInformation.h"
#import "GoodsCarPayDataRequest.h"
#import "GoodsCarSubmitDataRequest.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"
#import "GoodsListModel.h"
#import "PaySuccessViewController.h"
#import "AppDelegate.h"

///淘宝支付
#import "AlixLibService.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"


@interface TopUpViewController ()
@property (nonatomic, strong)ITTTabBarController            *ITTTabBarController;
@property (nonatomic, strong)AddressModel                   *AddressModel;
@property (nonatomic, strong)NSMutableArray                 *AddresDataArray;
@property (nonatomic, strong)UserInfomationModel            *userModel;
@property (nonatomic, copy) NSString                        *addrresID;
@property (nonatomic, assign) int                           Type;
@property (nonatomic, copy) NSString                        *OrderBH;
@end

@implementation TopUpViewController
{
    __weak IBOutlet UILabel *PhoneLable;
    __weak IBOutlet UILabel *NameLable;
    __weak IBOutlet UILabel *AddressLable;
    __weak IBOutlet UIButton *BankBtn;
    __weak IBOutlet UIButton *TaoBaoBtn;
    __weak IBOutlet UILabel *TaoBaoPayLable;
    __weak IBOutlet UILabel *BankLable;
    __weak IBOutlet UILabel *MoneyLable;
    
    __weak IBOutlet UIButton *TaobaoBtn01;
    __weak IBOutlet UIButton *BankBtn01;
    __weak IBOutlet UILabel *TaobaoLable01;
    __weak IBOutlet UILabel *BankLable01;
    __weak IBOutlet UILabel *MoneyLable01;
    __weak IBOutlet UILabel *NomalUnderLable;
    __weak IBOutlet UILabel *selectUnderLable;
    
    
    __weak IBOutlet UIView *NomalView;
    __weak IBOutlet UIView *NomalMiddelView;
    __weak IBOutlet UIView *NomalUnderView;
    __weak IBOutlet UIScrollView *SelectTableView;
    __weak IBOutlet UIView *SelectTablemiddelView;
    __weak IBOutlet UIView *SelectTableUnderView;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.Type = 1;
        self.userModel = [SaveAndGetUserInformation readUserDefaults];
    }
    return self;
}

#pragma mark
#pragma mark StartRequest
/**
 *  获得用户地址
 */
-(void)startInformationRequest
{
    NSDictionary *param = @{@"yhid": self.userModel.UserId};
    [SendInformation requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        self.AddresDataArray = request.handleredResult[@"AddressModel"];
        [self initUI];
        [[MyAddressDataBase shareDataBase]deleteTable:@"MyAddress"];
        [[MyAddressDataBase shareDataBase] insertItemArray:self.AddresDataArray];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}

/**
 *  获得订单号需要传的参数
 *
 *  @return json格式的字符串
 */
-(NSString *)NSDictionaryTurnJson
{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:100];
    for (GoodsListModel *model in self.listArray) {
        NSDictionary *Dic = @{@"hpid":model.GoodsId,
                              @"dhjf":model.cklsj,
                              @"dhdj":model.tlscj,
                              @"sl":model.GoodsNumber};
        [arr addObject:Dic];
    }
    NSDictionary *dict = @{@"yhid": self.userModel.UserId,
                           @"ddbh": @"",
                           @"je": [NSString stringWithFormat:@"%.2f",self.price],
                           @"jfz":[NSString stringWithFormat:@"%d",self.point],
                           @"orderSubList": arr};
    
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return nil;
}
/**
 *  获得订单号
 */
-(void)StartPayRequest
{
    if ([self.addrresID length] == 0)
    {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息" message:@"请确认您的收获人等信息"];
        return;
    }
    NSDictionary *param = @{@"json":[self NSDictionaryTurnJson]};
    [GoodsCarPayDataRequest requestWithParameters:param
                                withIndicatorView:self.view
                                withCancelSubject:nil
                                   onRequestStart:
     ^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        
        if ([[request.handleredResult[@"code"] stringValue] isEqualToString:@"1"])
        {
            self.OrderBH = request.handleredResult[@"result"];
            
            if (self.point == 0)
            {
                NSLog(@"现金支付");
                
                //支付宝支付
                if (self.Type == 2) {
                    /*
                     *生成订单信息及签名
                     *由于demo的局限性，采用了将私钥放在本地签名的方法，商户可以根据自身情况选择签名方法(为安全起见，在条件允许的前提下，我们推荐从商户服务器获取完整的订单信息)
                     */
                    NSString *appScheme = AppName;
                    NSString* orderInfo = [self getOrderInfo:request.handleredResult[@"result"]];
                    NSString* signedStr = [self doRsa:orderInfo];
                    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderInfo, signedStr, @"RSA"];
                    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:@selector(paymentResult:) target:self];

                }
                //银联支付
                if (self.Type == 3) {
                    
                }
            }
            else
            {
                NSLog(@"积分支付");
                [self StartSubmitRequest:self.OrderBH andType:@"积分"];
            }
        }
        else
        {
            //提交订单失败
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息" message:request.handleredResult[@"msg"]];
        }
        
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
/**
 *  订单积分支付
 *
 *  @param str
 */
-(void)StartSubmitRequest:(NSString *)OrderNum andType:(NSString *)type
{
    NSDictionary *param = @{@"yhid":self.userModel.UserId,
                            @"dzid":self.addrresID,
                            @"zffs":type,
                            @"zflsh":@"",
                            @"ddbh":OrderNum,
                            @"je":[NSString stringWithFormat:@"%.2f",self.price],
                            @"jfz":[NSString stringWithFormat:@"%d",self.point]};
    
    [GoodsCarSubmitDataRequest requestWithParameters:param
                                   withIndicatorView:self.view
                                   withCancelSubject:nil
                                      onRequestStart:
     ^(ITTBaseDataRequest *request) {
    
     } onRequestFinished:^(ITTBaseDataRequest *request) {
         
         if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"])
         {
             NSDictionary *dict = request.handleredResult[@"result"];
             PaySuccessViewController *svc = [[PaySuccessViewController alloc]initWithNibName:@"PaySuccessViewController" bundle:nil];
             svc.price = self.price;
             svc.point = self.point;
             svc.PayType = type;
             svc.ddBH = dict[@"ddbh"];
             svc.UserId = self.userModel.UserId;
             [self.navigationController pushViewController:svc animated:YES];
             
         }
         else
         {
             [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息" message:request.handleredResult[@"msg"]];
         }
     } onRequestCanceled:^(ITTBaseDataRequest *request) {
    
     } onRequestFailed:^(ITTBaseDataRequest *request) {
    
     }];
}

#pragma mark
#pragma mark 支付宝支付
/**
 *  支付宝传参
 */
-(NSString*)getOrderInfo:(NSString*)orderID
{
    /*
	 *点击获取prodcut实例并初始化订单信息
	 */
    
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = orderID;//订单ID（由商家自行制定）
	order.productName = [self TurnListArrayTostr];//商品标题
	order.productDescription = [self TurnListArrayTostr]; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",self.price]; //商品价格
	order.notifyURL =  @"http://wwww.xxx.com"; //回调URL
	return [order description];
}
-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}
-(NSString *)TurnListArrayTostr
{
    NSMutableString  *titel = [NSMutableString string];
    for (GoodsListModel *model in self.listArray) {
        if (titel.length <= 120) {
            NSString *str = [NSString stringWithFormat:@"%@  ",model.chmc];
            [titel appendString:str];
        }
    }
    return titel;
}

/**
 *  支付宝
 *
 *  @return web回调函数
 */
-(void)paymentResult:(NSString *)resultd
{
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
            //小额支付
            [self StartSubmitRequest:self.OrderBH andType:@"支付宝"];
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
                [self StartSubmitRequest:self.OrderBH andType:@"支付宝"];
			}
        }
        else
        {
            //交易失败
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息" message:@"支付未完成~"];
        }
    }
    else
    {
        //失败
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息" message:@"支付未完成~"];
    }
    
}
/**
 *  支付宝
 *
 *  @return 支付宝客服端回调函数
 */
-(void)paymentResultSuccees
{
   [self StartSubmitRequest:self.OrderBH andType:@"支付宝"];
}
-(void)paymentResultFail
{
    [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息" message:@"支付未完成~"];
}

#pragma mark
#pragma mark ViewDidLoad
-(void)initUI
{
    if (Screen_height  == 480) {
        SelectTableView.contentSize = CGSizeMake(320, 554);
    }
    
    if (self.AddresDataArray.count == 0)
    {

            [NomalView setHidden:NO];
            [SelectTableView setHidden:YES];
            self.addrresID = @"";
            if (self.point == 0) {
                NomalMiddelView.hidden = NO;
                SelectTableUnderView.frame = CGRectMake(0, 97, 320, 142);
                NomalUnderLable.text = @"应付金额";
                MoneyLable01.text = [NSString stringWithFormat:@"%.2f元",self.price];

            }else{
                NomalMiddelView.hidden = YES;
                NomalUnderLable.text = @"应付积分";
                NomalUnderView.frame = CGRectMake(0, 8, 320, 142);
                MoneyLable01.text = [NSString stringWithFormat:@"%d积分",self.point];
            }
    }
    else
    {
            [NomalView setHidden:YES];
            [SelectTableView setHidden:NO];
            for (AddressModel *model in self.AddresDataArray)
            {
                if ([model.type isEqualToString:@"1"])
                {
                    NameLable.text = model.Name;
                    PhoneLable.text = model.Phone;
                    AddressLable.text = model.Address;
                    self.addrresID = model.AddressId;
                }
            }
            
            if (self.point == 0)
            {
                SelectTablemiddelView.hidden = NO;
                selectUnderLable.text = @"应付金额";
                SelectTableUnderView.frame = CGRectMake(0, 97, 320, 148);//148
                MoneyLable.text = [NSString stringWithFormat:@"%.2F元",self.price];

            }else
            {
                SelectTablemiddelView.hidden = YES;
                selectUnderLable.text = @"应付积分";
                SelectTableUnderView.frame = CGRectMake(0, 8, 320, 148);
                MoneyLable.text = [NSString stringWithFormat:@"%d积分",self.point];
            }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!isReachability) {
        
    }else{
        [self startInformationRequest];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //监听淘宝客服端付款
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentResultSuccees) name:@"PaySuccess" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentResultFail) name:@"PayFaild" object:nil];
}
#pragma mark
#pragma mark PopViewButtonAction

- (IBAction)ConformButtonClick:(id)sender {
    if (self.point == 0) {
        if (self.Type !=2 && self.Type !=3) {
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息" message:@"请选择您的付款方式"];
            return;
        }
    }
     [self StartPayRequest];
}

- (IBAction)PayMoneyButtonClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1001) {
        AddAddressViewController *avc = [[AddAddressViewController alloc]initWithNibName:@"AddAddressViewController" bundle:nil];
        avc.NameStr = @"新增信息";
        avc.isType = @"1";
        [self.navigationController pushViewController:avc animated:YES];
        
    }else{
        EditorAddressViewController *avc = [[EditorAddressViewController alloc]initWithNibName:@"EditorAddressViewController" bundle:nil];
        [self.navigationController pushViewController:avc animated:YES];
    }
}

- (IBAction)TaoBaoBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    self.Type = 2;
    if (btn.tag == 1001) {
        [TaobaoBtn01 setSelected:YES];
        [BankBtn01 setSelected:NO];
        [TaobaoLable01 setTextColor:[UIColor lightGrayColor]];
        [BankLable01 setTextColor:[UIColor blackColor]];
    }else{
        [TaoBaoBtn setSelected:YES];
        [BankBtn setSelected:NO];
        [TaoBaoPayLable setTextColor:[UIColor lightGrayColor]];
        [BankLable setTextColor:[UIColor blackColor]];
    }

}

- (IBAction)BankBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    self.Type = 3;
    if (btn.tag == 1001) {
        [TaobaoBtn01 setSelected:NO];
        [BankBtn01 setSelected:YES];
        [TaobaoLable01 setTextColor:[UIColor blackColor]];
        [BankLable01 setTextColor:[UIColor lightGrayColor]];
    }else{
        [TaoBaoBtn setSelected:NO];
        [BankBtn setSelected:YES];
        [TaoBaoPayLable setTextColor:[UIColor blackColor]];
        [BankLable setTextColor:[UIColor lightGrayColor]];
    }

}

- (IBAction)PopViewButtonClick:(id)sender {
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    _ITTTabBarController.tabBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark Dealloce
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"PaySuccess"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"PayFaild"
                                                  object:nil];
}
@end
