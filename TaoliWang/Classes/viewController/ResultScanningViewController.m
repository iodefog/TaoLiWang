//
//  ResultScanningViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-23.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ResultScanningViewController.h"
#import "GetPointTypeDataRequest.h"
#import "GetPointDataRequest.h"
#import "GetPointViewController.h"
#import "SaveAndGetUserInformation.h"
#import "UserInfomationModel.h"
#import "DistrubtionTypeRequest.h"
#import "DistributionSubmitRequest.h"
#import "DistributionInfoModel.h"
#import "SaoErWeiMaDataRequest.h"
#import "AppDelegate.h"
#import "ScanningViewController.h"

@interface ResultScanningViewController ()
@property (weak, nonatomic) IBOutlet UILabel            *DetailLable;
@property (weak, nonatomic) IBOutlet UILabel            *PointLable;
@property (weak, nonatomic) IBOutlet UIView             *TiaomaView;
@property (weak, nonatomic) IBOutlet UIScrollView       *ErweimaView;
@property (nonatomic, strong)ITTTabBarController        *ITTTabBarController;

@property (strong, nonatomic) NSDictionary *dataDict;
@end

@implementation ResultScanningViewController
{

    __weak IBOutlet UIWebView *ErWeimaShowWebView;
    __weak IBOutlet UILabel *FenxiaoshangLable;
    __weak IBOutlet UIView *FenxiaoshangView;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - 
#pragma mark 积分扫码
-(void)StartRequestPointType
{
    if (![PhoneCode isNumberiCalWithString:_DataStr] && [_DataStr length] != 16) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"请扫本店的条形码,您的条码不正确,谢谢合作!"];
        return;
    }
    NSDictionary *param = @{@"type":@"1",@"km":_DataStr};
    [GetPointTypeDataRequest requestWithParameters:param
                                 withIndicatorView:self.view
                                 withCancelSubject:nil
    onRequestStart:^(ITTBaseDataRequest *request) {
                                        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            _dataDict = request.handleredResult[@"result"];
            _DetailLable.text = _dataDict[@"kh"];
            _PointLable.text = [_dataDict[@"jf"]stringValue];
        }else{
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:request.handleredResult[@"msg"]];
        }

    } onRequestCanceled:^(ITTBaseDataRequest *request) {
                                        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
                                        
    }];
}
-(void)startRequestPoint
{
    if (!isReachability) {
        [UIAlertView popupAlertByDelegate:self andTag:1004 title:@"提示" message:@"请先检查您的网络,谢谢合作!"];
        return;
    }
    UserInfomationModel *model = [SaveAndGetUserInformation readUserDefaults];
    if ([model.UserId length] == 0) {
        return;
    }
    NSDictionary *param = @{@"yhid":model.UserId,@"km":_DataStr};
    [GetPointDataRequest requestWithParameters:param
                             withIndicatorView:self.view
                             withCancelSubject:nil
    onRequestStart:^(ITTBaseDataRequest *request) {
                                    
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
           NSString *str = [NSString stringWithFormat:@"积分余额:%@    \n%@",request.handleredResult[@"result"],request.handleredResult[@"msg"]];
              [UIAlertView popupAlertByDelegate:self andTag:1006 title:@"温馨提示" message:str cancel:@"返回" others:@"继续充值"];
        }else{
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"温馨提示" message:request.handleredResult[@"msg"]];
        }
      
        
    } onRequestCanceled:^(ITTBaseDataRequest *request) {

    } onRequestFailed:^(ITTBaseDataRequest *request) {
                                    
    }];
}



#pragma mark
#pragma mark 分销商扫码
-(void)StartFenxiashangRequestType
{
    if (![PhoneCode isNumberiCalWithString:_DataStr] && [_DataStr length] != 16) {
    [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"提示" message:@"请扫本店的条形码,您的条码不正确,谢谢合作!"];
    return;
    }
    NSDictionary *param = @{@"mm":_DataStr};
    [DistrubtionTypeRequest requestWithParameters:param
                                 withIndicatorView:self.view
                                 withCancelSubject:nil
                                    onRequestStart:
     ^(ITTBaseDataRequest *request) {
         
         
     } onRequestFinished:^(ITTBaseDataRequest *request) {
         if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
             _dataDict = request.handleredResult[@"result"];
             FenxiaoshangLable.text = _dataDict[@"kh"];
         }else{
             [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"提示" message:request.handleredResult[@"msg"]];
         }
         
     } onRequestCanceled:^(ITTBaseDataRequest *request) {
         
     } onRequestFailed:^(ITTBaseDataRequest *request) {
         
     }];



    
}
-(void)startFenxiangshangRequest
{
    if (!isReachability) {
        [UIAlertView popupAlertByDelegate:self andTag:1004 title:@"提示" message:@"请先检查您的网络,谢谢合作!"];
        return;
    }
    DistributionInfoModel *model = [SaveAndGetUserInformation readDistributionDefaults];
    if ([model.DistributionId length] == 0) {
        return;
    }
    NSDictionary *param = @{@"yhid":model.DistributionId,@"mm":_DataStr};
    [DistributionSubmitRequest requestWithParameters:param
                             withIndicatorView:self.view
                             withCancelSubject:nil
                                onRequestStart:
     ^(ITTBaseDataRequest *request) {
                                    
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"提示" message:request.handleredResult[@"msg"]];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
                                    
    } onRequestFailed:^(ITTBaseDataRequest *request) {
                                    
    }];

}

#pragma mark
#pragma makr 商品二维码扫码

-(void)StartErweimaReqeust
{
    NSDictionary *param = @{@"id":_DataStr};
    [SaoErWeiMaDataRequest requestWithParameters:param
                               withIndicatorView:self.view
                               withCancelSubject:nil
                                  onRequestStart:
     ^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            [self HtmlToWebViewShow:request.handleredResult[@"result"]];
            [self InitUI];
        }else{
            [UIAlertView popupAlertByDelegate:self andTag:1002 title:@"提示" message:@"请扫本店的条形码,您的条码不正确,谢谢合作!"];
        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];

}
-(void)HtmlToWebViewShow:(NSString *)str
{
    /**
     *  把xml格式字符串写入test.html 在用webview 展示
     */
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [path objectAtIndex:0];
    NSString *htmlPath = [filePath stringByAppendingPathComponent:@"test.html"];
    [fm createFileAtPath:htmlPath contents:nil attributes:nil];
    [str writeToFile:htmlPath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    NSString *htmlstring=[NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:NULL];
    [ErWeimaShowWebView loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:htmlPath]];
}
- (void) InitUI{
    if (Screen_height == 480) {
        _ErweimaView.contentSize = CGSizeMake(320, 600);
    }else{
        _ErweimaView.contentSize = CGSizeMake(320, 504);
    }
}


#pragma mark -
#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (!isReachability) {
        [_ErweimaView setHidden:NO];
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"连接失败，请稍后重试"];
    }else
    {
        if (self.Scannning == isHome) {
            [_ErweimaView setHidden:NO];
            [self StartErweimaReqeust];
        }
        if (self.Scannning == isGetpoint) {
            [_TiaomaView setHidden:NO];
            [self StartRequestPointType];
        }
        if (self.Scannning == isDistribution){
            [FenxiaoshangView setHidden:NO];
            [self StartFenxiashangRequestType];
        }
    }

}



#pragma mark
#pragma mark ButtonCLick
- (IBAction)ComfirmButtonClick:(id)sender {
        [self startRequestPoint];
}
- (IBAction)FenxiaoshangButtonClick:(id)sender {
    [self startFenxiangshangRequest];
    
}
- (IBAction)popRootViewController:(id)sender {
    if (self.Scannning == isGetpoint) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
    if (self.Scannning == isHome) {
        _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
        _ITTTabBarController.tabBarHidden = NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if (self.Scannning == isDistribution) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


- (IBAction)ErweimaButtonClick:(id)sender {
    
    UserInfomationModel *UserModel = [SaveAndGetUserInformation readUserDefaults];
    if ([UserModel.UserId length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1003 title:@"温馨提示" message:@"您还没有登录,无法充值"];
        return;
    }

    GetPointViewController *gvc = [[GetPointViewController alloc]initWithNibName:@"GetPointViewController" bundle:nil];
    gvc.isHomePopToHere = NO;
    [self.navigationController pushViewController:gvc animated:YES];
    
}



#pragma mark -
#pragma mark UIalertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
     [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
    if (alertView.tag == 1002) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if (alertView.tag == 1003) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [SharedApp showViewController:LOGIN_VIEW_CONTROLLER andIndex:0];
    }
    if (alertView.tag == 1006) {
        if (buttonIndex == 0) {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
@end
