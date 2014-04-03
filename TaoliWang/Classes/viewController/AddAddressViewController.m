//
//  AddAddressViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-18.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AddressModel.h"
#import "MyAddressDataBase.h"
#import "AddInformationDataRequest.h"
#import "GetCityDataRequest.h"
#import "ModifyInformationDataRequest.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"
#import "TSLocateView.h"

@interface AddAddressViewController ()
@property (nonatomic, strong)AddressModel               *AddressModel;
@property (nonatomic, strong)UserInfomationModel        *userModel;

@property (nonatomic, strong)NSMutableArray             *ProvieAndCityArray;
@property (nonatomic, strong)NSMutableArray             *DataArray;
@property (nonatomic, strong)UIView                     *backview;

@end

@implementation AddAddressViewController
{

    __weak IBOutlet UITextView *AddressDetailTextView;
    __weak IBOutlet UITextField *ZipCodeTextField;
    __weak IBOutlet UITextField *numberPhoneTextField;
    __weak IBOutlet UITextField *AddresstextField;
    __weak IBOutlet UITextField *NameTextField;
    __weak IBOutlet UIScrollView *BackScrollView;
    __weak IBOutlet UILabel *TitleLable;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardUp) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDown) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
#pragma mark 
#pragma mark StartRequest
-(void)startModifyRequest
{
    if ([self KnowStringLength] == NO) {
        return;
    }
    NSDictionary *param = @{@"dzid": self.AddressModel.AddressId,
                            @"yhid": self.userModel.UserId,
                            @"shrmc": NameTextField.text,
                            @"szsf": [self.ProvieAndCityArray objectAtIndex:0],
                            @"szdq": [self.ProvieAndCityArray objectAtIndex:1],
                            @"shrsj": numberPhoneTextField.text,
                            @"shrdz": AddressDetailTextView.text,
                            @"yzbm": ZipCodeTextField.text,
                            @"sfsxdz":self.isType};
    [ModifyInformationDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            
            AddressModel *model = [[AddressModel alloc]init];
            model.AddressId = self.AddressModel.AddressId;
            model.Name =NameTextField.text;
            model.Province = [self.ProvieAndCityArray objectAtIndex:0];
            model.city = [self.ProvieAndCityArray objectAtIndex:1];
            model.Phone = numberPhoneTextField.text;
            model.Address = AddressDetailTextView.text;
            model.ZipCode = ZipCodeTextField.text;
            model.type = self.isType;
            [[MyAddressDataBase shareDataBase] updateItem:model];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
    
}
-(void)startAddRequest
{
    if ([self KnowStringLength] == NO) {
        return;
    }
    NSDictionary *param = @{@"yhid": self.userModel.UserId,
                            @"shrmc": NameTextField.text,
                            @"szsf": [self.ProvieAndCityArray objectAtIndex:0],
                            @"szdq": [self.ProvieAndCityArray objectAtIndex:1],
                            @"shrsj": numberPhoneTextField.text,
                            @"shrdz": AddressDetailTextView.text,
                            @"yzbm": ZipCodeTextField.text,
                            @"sfsxdz":self.isType};
    [AddInformationDataRequest requestWithParameters:param withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        
        if ([[request.handleredResult[@"code"]stringValue] isEqualToString:@"1"]) {
            AddressModel *model = [[AddressModel alloc]init];
            model.AddressId = request.handleredResult[@"result"];
            model.Name =NameTextField.text;
            model.Province = [self.ProvieAndCityArray objectAtIndex:0];
            model.city = [self.ProvieAndCityArray objectAtIndex:1];
            model.Phone = numberPhoneTextField.text;
            model.Address = AddressDetailTextView.text;
            model.ZipCode = ZipCodeTextField.text;
            model.type = self.isType;
            [[MyAddressDataBase shareDataBase]update];
            [[MyAddressDataBase shareDataBase] insertItem:model];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
-(void)startGetCityDataRequest
{
    [GetCityDataRequest requestWithParameters:nil withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        
        NSArray *array01 = request.handleredResult[@"ProviedataArray"];
        NSArray *array02 = request.handleredResult[@"result"];
        
        NSString *FilePath01 =[AddDocumentPathFile AddFileName:@"test01.plist" andType:@"plist"];
        [AddDocumentPathFile WriteContent:array02 andFilePath:FilePath01];
        
        NSString *FilePath02 =[AddDocumentPathFile AddFileName:@"test02.plist" andType:@"plist"];
        [AddDocumentPathFile WriteContent:array01 andFilePath:FilePath02];
        [self initUI];

    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}

#pragma mark
#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!isReachability) {
        
    }else{
        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:[AddDocumentPathFile AddFileName:@"test02.plist" andType:@"plist"]];
        if (array.count == 0) {
            [self startGetCityDataRequest];
        }else{
            [self initUI];
        }
    }
}
-(void)initUI
{
    
    self.ProvieAndCityArray = [[NSMutableArray alloc]init];
    self.userModel = [SaveAndGetUserInformation readUserDefaults];
    TitleLable.text = _NameStr;
    if ([self.NameStr isEqualToString:@"新增信息"]) {
        NSLog(@"新增信息进入改界面");
    }else{
        NSLog(@"编辑信息进入改界面");
        self.DataArray = [[MyAddressDataBase shareDataBase] readTableName:@"MyAddress"];
        self.AddressModel = [self.DataArray objectAtIndex:self.selectIndexRow];
        NameTextField.text = self.AddressModel.Name;
        NSMutableArray *arr = [self ProviceAndCityWithDm01:self.AddressModel.Province andDm02:self.AddressModel.city];
        AddresstextField.text = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
        numberPhoneTextField.text = self.AddressModel.Phone;
        ZipCodeTextField.text = self.AddressModel.ZipCode;
        AddressDetailTextView.text = self.AddressModel.Address;
        AddressDetailTextView.textColor = [UIColor darkGrayColor];
        [self.ProvieAndCityArray addObject:self.AddressModel.Province];
        [self.ProvieAndCityArray addObject:self.AddressModel.city];
    }
    
    if (!iPhone5) {
        BackScrollView.contentSize = CGSizeMake(320, 555);
    }else{
        BackScrollView.contentSize = CGSizeMake(320, 450);
    }

    
}
-(void)keyboardUp{
    if ([NameTextField performSelector:@selector(isFirstResponder)]) {
        return;
    }
    if (!iPhone5) {
        BackScrollView.contentSize = CGSizeMake(320, 715);
        [UIView animateWithDuration:0.5 animations:^{
            BackScrollView.contentOffset = CGPointMake(0, 215);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        BackScrollView.contentSize = CGSizeMake(320, 650);

        [UIView animateWithDuration:0.5 animations:^{
            BackScrollView.contentOffset = CGPointMake(0, 140);
        } completion:^(BOOL finished) {
            
        }];
    }

}

-(void)keyboardDown{
    [UIView animateWithDuration:0.5 animations:^{
        BackScrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        
    }];
    if (!iPhone5) {
        BackScrollView.contentSize = CGSizeMake(320, 550);
    }else{
        BackScrollView.contentSize = CGSizeMake(320, 450);
    }
}
#pragma mark
#pragma mark Method
-(NSMutableArray *)ProviceAndCityWithDm01:(NSString *)dm01 andDm02:(NSString *)dm02
{
    NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:[AddDocumentPathFile AddFileName:@"test01.plist" andType:@"plist"]];
    NSMutableArray *arr01 = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in arr) {
        if ([dm01 isEqualToString:[dict objectForKey:@"dm"]]) {
            [arr01 addObject:[dict objectForKey:@"mc"]];
        }
        if ([dm02 isEqualToString:[dict objectForKey:@"dm"]]) {
            [arr01 addObject:[dict objectForKey:@"mc"]];
        }
    }
    return arr01;
}
-(BOOL)KnowStringLength
{
    if ([[NameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"收货人不能为空!"];
        return NO;
    }
    if ([[AddresstextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"所在地区不能为空!"];
        return NO;
    }
    if ([[numberPhoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0){
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"手机号码不能为空!"];
        return NO;
    }
    if (![PhoneCode isMobileNumber:numberPhoneTextField.text]) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"手机号格式不正确"];
        return NO;
    }
    if ([[ZipCodeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"邮编不能为空"];
        return NO;
    }
    if([PhoneCode isZipCodeWithString:ZipCodeTextField.text] == NO) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"邮编格式不正确"];
        return NO;
    }
    if ([[AddressDetailTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 || [AddressDetailTextView.text isEqualToString:@"请输入收货人的详细地址"]) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"收货的人详细地址不能为空"];
        return NO;
    }
    return YES;
}

#pragma mark
#pragma mark ButtonAction
- (IBAction)BackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)TouchViewEvent:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
- (IBAction)SelectProvice:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    self.backview = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.backview];
    TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:@"城市选择" delegate:self];
    [locateView showInView:self.backview];
}
- (IBAction)ConformButtonClick:(id)sender {
    if ([self.NameStr isEqualToString:@"新增信息"]) {
        [self startAddRequest];
    }else{
        [self startModifyRequest];
    }
}
#pragma mark
#pragma mark TextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入收货人的详细地址"]) {
        AddressDetailTextView.text = @"";
        AddressDetailTextView.textColor = [UIColor lightGrayColor];

    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([AddressDetailTextView.text length] == 0) {
        AddressDetailTextView.text = @"请输入收货人的详细地址";
        AddressDetailTextView.textColor = [UIColor lightGrayColor];
    }else{
        AddressDetailTextView.textColor = [UIColor darkGrayColor];
    }
}
#pragma mark
#pragma mark ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TSLocateView *locateView = (TSLocateView *)actionSheet;
    TSLocation *location = locateView.locate;
    NSLog(@"dm ==:%@ mc ===:%@ dm01 ===:%@ mc01 ===:%@", location.dm, location.mc, location.dm01,location.mc01);
    
    //You can uses location to your application.
    [self.backview removeFromSuperview];

    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select");
        [self.ProvieAndCityArray removeAllObjects];
        [self.ProvieAndCityArray addObject:location.dm];
        [self.ProvieAndCityArray addObject:location.dm01];
        AddresstextField.text = [NSString stringWithFormat:@"%@ %@",location.mc,location.mc01];
    }
}

@end
