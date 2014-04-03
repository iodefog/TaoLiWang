//
//  GoodsDetailsViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//
//测试商品id
#define productId01                                          @"13158995437380481"      //积分
#define productId02                                          @"13860508783170395"      //现金



#import "GoodsDetailsViewController.h"
#import "GoodDetailDataRequest.h"
#import "GoodsDetailModel.h"
#import "GoodsListModel.h"
#import "GoodsDetailDataBase.h"
#import "ITTShareView.h"
#import "ShareCommon.h"
#import "TimeObject.h"
#import "AppDelegate.h"

@interface GoodsDetailsViewController ()
@property (nonatomic, strong) ITTTabBarController    *ITTTabBarController;
/**
 *  UIScrollView上的控件
 */
@property (weak, nonatomic) IBOutlet UIScrollView    *ShowImageScrollView;
@property (weak, nonatomic) IBOutlet UILabel         *ShowImageNumberLable;
@property (weak, nonatomic) IBOutlet UIView          *BackView;
@property (nonatomic, assign) int                    ImageCount;
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel         *GoodsNewPriceLable;
@property (weak, nonatomic) IBOutlet UILabel         *GoodsNameLable;
@property (weak, nonatomic) IBOutlet UILabel         *GoodsOldPriceLable;
@property (weak, nonatomic) IBOutlet UIScrollView    *ContentScrollView;

/**
 *  商品图解
 */
@property (weak, nonatomic) IBOutlet UIWebView        *GoodsTitleWebView;
@property (nonatomic, strong)GoodsDetailModel         *Detailmodel;
@property (nonatomic, strong)PopCarView               *Carview;
@end

@implementation GoodsDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _ImageCount = 0;
    }
    return self;
}
/**
 *  数据请求
 *
 *  @param void 需要传的参数
 *
 *  @return void
 */
#pragma mark - 
#pragma mark StartRequest
-(void)startGoodsDetailRequest
{
    /**
     *  商品id   self.GoodsId
     */
    NSDictionary *param = @{@"productId":self.GoodsId};
    [GoodDetailDataRequest requestWithParameters:param
                               withIndicatorView:self.view
                               withCancelSubject:nil
                                  onRequestStart:
     ^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        _Detailmodel = request.handleredResult[@"GoodsDetailModel"];
        [self.BackView setHidden:YES];
        [self setHomeheadView:_Detailmodel];
        [self setHomeMiddelView:_Detailmodel];
        [self setHomeSmallView:_Detailmodel];
        /*
         *chmc;    //名称
         @property (nonatomic, copy) NSString                    *tlscj;   //市场价格
         @property (nonatomic, copy) NSString                    *scj;     //交易价格
         @property (nonatomic, copy) NSString                    *cklsj;   //积分价格
         @property (nonatomic, strong) NSArray                   *tpmc;    //图片浏览
         @property (nonatomic, copy) NSString                    *xq;      //图示详解
         */
        NSLog(@"_Detailmodel.tlscj ======= %@", _Detailmodel.tlscj);
         NSLog(@"_Detailmodel.scj ======= %@", _Detailmodel.scj);
         NSLog(@"_Detailmodel.cklsj ======= %@", _Detailmodel.cklsj);
         NSLog(@"_Detailmodel.tpmc ======= %@", _Detailmodel.tpmc);
         NSLog(@"_Detailmodel.xq ======= %@", _Detailmodel.xq);
        
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}





/**
 *  UI加载
 *
 *  @param void
 *
 *  @return void
 */
#pragma mark -
#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self InitUI];
    [self startGoodsDetailRequest];
}
- (void)InitUI
{
    _GoodsTitleWebView.scrollView.scrollEnabled = NO;
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
#pragma mark -
#pragma mark UIScrollView
-(void)setHomeheadView:(GoodsDetailModel *)model
{
    /**
     *  图片展示
     */
    [_ShowImageScrollView setContentSize:CGSizeMake(320*[model.tpmc count], 167)];
    _ImageCount = [model.tpmc count];
    if ([model.tpmc count] == 0) {
        _ShowImageNumberLable.hidden = YES;
    }else{
        _ShowImageNumberLable.text = [NSString stringWithFormat:@"1/%d",[model.tpmc count]];
    }
    for (int i = 0; i < [model.tpmc count]; i++) {
        ITTImageView *ScroImageView = [[ITTImageView alloc]init];
        ScroImageView.contentMode = UIViewContentModeScaleAspectFit;
        [ScroImageView loadImage:[[model.tpmc objectAtIndex:i] objectForKey:@"tpmc"]];
        ScroImageView.frame = CGRectMake(i*320, 0, 320, 230);
        ScroImageView.userInteractionEnabled = YES;
        [_ShowImageScrollView addSubview:ScroImageView];
    }
}
-(void)setHomeMiddelView:(GoodsDetailModel *)model
{
    /**
     *  判断是积分还是现金商品
     */
    if ([self.GoodsType isEqualToString:isGoodsTypeMoney]) {
        _GoodsNewPriceLable.text = [NSString stringWithFormat:@"%@元",model.tlscj];
        _GoodsOldPriceLable.text = [NSString stringWithFormat:@"%@元",model.scj];
        _GoodsNameLable.text = model.chmc;
    }
    if ([self.GoodsType isEqualToString:isGoodsTypePoint]) {
        _GoodsNewPriceLable.text = [NSString stringWithFormat:@"%@积分",model.cklsj];
        _GoodsOldPriceLable.text = [NSString stringWithFormat:@"%@元",model.scj];
        _GoodsNameLable.text = model.chmc;
    }


}
-(void)setHomeSmallView:(GoodsDetailModel *)model
{
    /**
     *  把xml格式字符串写入test.html 在用webview 展示
     */
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [path objectAtIndex:0];
    NSString *htmlPath = [filePath stringByAppendingPathComponent:@"test.html"];
    [fm createFileAtPath:htmlPath contents:nil attributes:nil];
    [model.xq writeToFile:htmlPath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    NSString *htmlstring=[NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:NULL];
    self.GoodsTitleWebView.delegate = self;
    [self.GoodsTitleWebView loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:htmlPath]];    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //顶部图片scrollview的delegate
    if (scrollView.tag == 1001) {
        int page = _ShowImageScrollView.contentOffset.x/320+1;
        _ShowImageNumberLable.text = [NSString stringWithFormat:@"%d/%d",page,_ImageCount];
    }
}


/**
 *  分享
 *
 *  @param IBAction void
 *
 *  @return void
 */
#pragma mark -
#pragma mark WeiBoShare
- (IBAction)WeiboShareButtonClick:(id)sender {
    ITTShareView *view = [[ITTShareView alloc]init];
    view.delegate = self;
    [view ShowShareView];
}
-(void)SinaShareBtnClick:(UIButton *)sender{
    [ShareCommon SinaShareWithContent:[NSString stringWithFormat:@"今天发现一好东西，%@,你值得拥有",self.GoodsNameLable.text]];
}
-(void)WeiXinShareBtnClick:(UIButton *)sender{
    [ShareCommon WeixinShareWithContent:[NSString stringWithFormat:@"今天发现一好东西，%@,你值得拥有",self.GoodsNameLable.text]];
}
-(void)QQSpaceShareBtnCLick:(UIButton *)sender{
    [ShareCommon QQSpaceShareWithContent:[NSString stringWithFormat:@"今天发现一好东西，%@,你值得拥有",self.GoodsNameLable.text]];
}




/**
 *  加入购物车
 *
 *  @param IBAction Button
 *
 *  @return void
 */
#pragma mark -
#pragma mark CardsBuy
- (IBAction)InsertCardButtonClick:(id)sender {
    GoodsListModel *listModel = [[GoodsListModel alloc]init];
    listModel.GoodsId = [NSString stringWithFormat:@"%@", self.GoodsId];
    listModel.chmc = _Detailmodel.chmc;
    listModel.tlscj = _Detailmodel.tlscj;
    listModel.cklsj = _Detailmodel.cklsj;
    NSString *str = [[_Detailmodel.tpmc objectAtIndex:0] objectForKey:@"tpmc"];
    listModel.tpmc = str;
    listModel.GoodsNumber = @"1";
    if ([self.GoodsType isEqualToString:isGoodsTypePoint]) {
        listModel.Type = isGoodsTypePoint;
    }else{
        listModel.Type = isGoodsTypeMoney;
    }
    
    //判断是否存在相同类型的商品
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    CarHaveSameGoods oneSuc = [TimeObject isHaveTwoClassOfInCar:self.GoodsType];
    if (oneSuc == CarHaveSameGoodsNomal) {
        
        BOOL success = [[GoodsDetailDataBase shareDataBase]insertItem:listModel];
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

    
    //设置tabbarlable显示
    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
    [_ITTTabBarController setNumberlable];
    [self.Carview SetCarNumber];
    
}




/**
 *  webView的delegate
 *
 *  @param webView 所要显示的内容
 */
#pragma mark -
#pragma mark WebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //图片缩放
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=305;" //缩放系数
     ""
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    //webView的高度
    NSString *string = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGRect frame = [webView frame];
    frame.size.height = [string floatValue]+10;
    if (iPhone5) {
        _ContentScrollView.contentSize = CGSizeMake(320, frame.size.height+320);

    }else{
        _ContentScrollView.contentSize = CGSizeMake(320, frame.size.height+415);
    }
    [webView setFrame:frame];
}
/**
 *  返回上一层界面
 *
 *  @param IBAction void
 *
 *  @return void
 */
#pragma mark -
#pragma mark popViewController
- (IBAction)popViewControllerButtonClick:(id)sender {
    if (_isHiddenTabBar == YES) {
        _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
        _ITTTabBarController.tabBarHidden = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
