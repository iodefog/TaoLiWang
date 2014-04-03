//
//  CONSTS.h
//  Hupan
//
//  Copyright 2010 iTotem Studio. All rights reserved.
//


#define REQUEST_DOMAIN @"http://cx.itotemstudio.com/api.php" // default env


//other consts
typedef enum{
	kTagWindowIndicatorView = 501,
	kTagWindowIndicator,
} WindowSubViewTag;

typedef enum{
    kTagHintView = 101
} HintViewTag;

/**
 *  软件版本设备号和名称
 */
#define SoftWare_Info           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define SoftWare_Name           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/**
 *  AppDelegate
 */
#define LOGIN_VIEW_CONTROLLER           0
#define HOME_VIEW_CONTROLLER            1
#define DISTRIBUTOR_VIEW_CONTROLLER     2
#define SharedApp                       ((AppDelegate*)[[UIApplication sharedApplication] delegate])
/**
 *  ios适配
 */
#define  isIOS7                              [[[UIDevice currentDevice]systemVersion]floatValue] >=7
#define Screen_height                        [[UIScreen mainScreen] bounds].size.height
#define Screen_width                         [[UIScreen mainScreen] bounds].size.width

#define iPhone5                              ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
/**
 *  商品类型
 */
#define  isGoodsTypePoint                     @"10"     //积分商品
#define  isGoodsTypeMoney                     @"11"     //现金商品
#define  isGoodsTypeActivity                  @"20"     //活动专区
/**
 *  扫码
 */
#define isGetpoint                          1
#define isHome                              2
#define isDistribution                      3


/**
 *  is InternetConnection
 */
#define isReachability                      [Reachability isNetWorkReachable]
/**
 *  图片添加链
 */
#define Imgae_header_Local                  @"http://www.chaojijifen.com/upload/"

/**========================================================
 *  登录注册接口和获取验证码
 ===============================================================**/
#define USER_LOG_DATAREQUEST                @"http://www.chaojijifen.com:8088/Interface/UserAction!login.do"
#define Three_Login_DataRequest             @"http://www.chaojijifen.com:8088/Interface/UserAction!quickLogin.do"
#define USER_REGIST_DATAREQUEST             @"http://www.chaojijifen.com:8088/Interface/UserAction!register.do"
#define Modify_Pwd_NotOldPwd_DataRequest    @"http://www.chaojijifen.com:8088/Interface/UserAction!updatePasswordNotOld.do"
#define Get_PWd_By_Phone_DataRequest        @"http://www.chaojijifen.com:8088/Interface/UserAction!queryPasswordByMessage.do"
#define Get_pwd_By_Email_DataRquest         @"http://www.chaojijifen.com:8088/Interface/UserAction!queryPasswordByEmail.do"



/**===========================================================
 *  首页接口
 ================================================================**/
#define HOME_DATAREQUEST                    @"http://www.chaojijifen.com:8088/Interface/ECMainAction!queryECMainInfo.do"
#define HOME_SEARCH_DATAREQUEST             @"http://www.chaojijifen.com:8088/Interface/ProductAction!queryProductList.do"
#define Home_SaoErWeiMa_DataRequest         @"http://www.chaojijifen.com:8088/Interface/ActivityAction!scanQRCode.do"


/**=================================================
 *  商品详情接口
=======================================================**/
#define GOODS_LIST_DATAREQUEST              @"http://www.chaojijifen.com:8088/Interface/ProductAction!queryProductListByType.do"
#define GOODS_DETAIL_DATAREQUEST            @"http://www.chaojijifen.com:8088/Interface/ProductAction!queryProductInfo.do"

/**=======================================================
 *  获取积分借口
=======================================================**/
#define GET_POINT_TYPE_DATAREQUEST          @"http://www.chaojijifen.com:8088/Interface/PointAction!queryPointInfo.do"
#define GET_POINT_DATAREQUEST               @"http://www.chaojijifen.com:8088/Interface/PointAction!recharge.do"
#define Get_Point_Help_DataRequest          @"http://www.chaojijifen.com:8088/Interface/ArticleAction!rechargeHelp.do"
/**=======================================================
 *  积分查询
 =======================================================**/
#define  MY_SEARCHPOINT_DATAREQUEST         @"http://www.chaojijifen.com:8088/Interface/UserAction!queryPoint.do"
#define  SEARCH_POINT_DATAREQUEST           @"http://www.chaojijifen.com:8088/Interface/UserAction!queryPointList.do"


/**===================================================
 *  优惠活动
===========================================================**/
#define PROMOTION_LIST_DATAREQUEST          @"http://www.chaojijifen.com:8088/Interface/ActivityAction!queryDiscountActivityList.do"
#define PROMOTION_DETAIL_DATAREQUEST        @"http://www.chaojijifen.com:8088/Interface/ActivityAction!queryActivityInfo.do"
#define PROMOTION_LOAD_COUPON               @"http://www.chaojijifen.com:8088/Interface/CouponAction!downloadCoupon.do"



/**===================================================
 *  个人中心 我的空间接口
 ===========================================================**/
#define PERSON_MYSPACE_LIST_DATAREQUEST     @"http://www.chaojijifen.com:8088/Interface/ArticleAction!queryArticleList.do"
#define PERSON_MYSPACE_SEND_DATAREQUEST     @"http://www.chaojijifen.com:8088/Interface/ArticleUserAction!publish.do"


/**===================================================
 *  我的订阅
 ===========================================================**/
#define MY_SUBSCRIPTIONS_LIST_DATAQUEST          @"http://www.chaojijifen.com:8088/Interface/ArticleAction!queryMySubscriptionList.do"
#define MY_SUBSCRIPTIONS_DETAIL_DATAQUEST        @"http://www.chaojijifen.com:8088/Interface/ArticleAction!querySubscriptionInfo.do"
#define MY_SUBSCRIPTIONS_Comform_DATAQUEST       @"http://www.chaojijifen.com:8088/Interface/ArticleAction!queryArticleColumnList.do"
#define MY_SUBSCRIPTIONS_Cancel_DATAQUEST        @"http://www.chaojijifen.com:8088/Interface/ArticleAction!subscribe.do"



/**===================================================
 *  个人中心配送信息
 ===========================================================**/
#define Person_sendInformation_DataRequest      @"http://www.chaojijifen.com:8088/Interface/AddressAction!queryAddressList.do"
#define Person_addInformation_DataReuquest      @"http://www.chaojijifen.com:8088/Interface/AddressAction!addAddress.do"
#define Person_ModifyInformaton_DataRequest     @"http://www.chaojijifen.com:8088/Interface/AddressAction!updateAddress.do"
#define Person_DeletInformation_DataRequest     @"http://www.chaojijifen.com:8088/Interface/AddressAction!deleteAddress.do"
#define Person_SelectProvice_DataRequest        @"http://www.chaojijifen.com:8088/Interface/AddressAction!queryProvinceAndRegionList.do"



/**===================================================
 *  个人中心用户维护信息接口
 ===========================================================**/
#define Person_Information_DataRequest          @"http://www.chaojijifen.com:8088/Interface/UserAction!queryUserInfo.do"
#define Person_Information_PhoneChange_DataRequest @"http://www.chaojijifen.com:8088/Interface/UserAction!updateMobile.do"
#define Person_Information_EmailChange_DataRequest @"http://www.chaojijifen.com:8088/Interface/UserAction!updateEmail.do"
#define Person_Information_PWdChange_DataRequest   @"http://www.chaojijifen.com:8088/Interface/UserAction!updatePassword.do"
#define Person_Infomation_phoneCode_DataRequest    @"http://www.chaojijifen.com:8088/Interface/UserAction!queryCode.do"



/**===================================================
 *  购物车接口
 ===========================================================**/
#define GoodsCar_List_DataRequest               @"http://www.chaojijifen.com:8088/Interface/OrderAction!queryProductListByIds.do"
#define GoodsCar_Pay_DataRequest                @"http://www.chaojijifen.com:8088/Interface/OrderAction!pay.do"
#define GoodsCar_Submit_DataRequest             @"http://www.chaojijifen.com:8088/Interface/OrderAction!submit.do"



/**===================================================
 * 个人中心我的优惠
 ===========================================================**/
#define MyOffers_List_DataRequest               @"http://www.chaojijifen.com:8088/Interface/CouponAction!queryCouponList.do"
#define MyOffers_Detail_DataRequest             @"http://www.chaojijifen.com:8088/Interface/CouponAction!queryCouponInfo.do"



/**===================================================
 * 抽奖
 ===========================================================**/
#define Myaward_Detail_DataRequest              @"http://www.chaojijifen.com:8088/Interface/ActivityAction!queryRewardInfo.do"
#define Join_Award_DataRequest                  @"http://www.chaojijifen.com:8088/Interface/ActivityAction!extractReward.do"



/**===================================================
 * 个人中心我的订单
 ===========================================================**/
#define MyCount_List_DataRequest                @"http://www.chaojijifen.com:8088/Interface/OrderAction!queryOrderList.do"
#define MyCount_Detail_DataRequest              @"http://www.chaojijifen.com:8088/Interface/OrderAction!queryOrderInfo.do"



/**===================================================
 * 个人中心摇一摇
 ===========================================================**/
#define Yaoyiyao_List_DataRequest               @"http://www.chaojijifen.com:8088/Interface/GisAction!querySellerList.do"
#define Yaoyiyao_Detail_DataRequest             @"http://www.chaojijifen.com:8088/Interface/GisAction!querySellerInfo.do"



/**===================================================
 * 个人中心关于我们   版本信息    意见反馈
 ===========================================================**/
#define About_Ours_DataRequest                  @"http://www.chaojijifen.com:8088/Interface/ArticleAction!aboutUs.do"
#define System_Info_DataRequest                 @"http://www.chaojijifen.com:8088/Interface/UserAction!querySystemInfo.do"
#define Feedback_Detail_DataRequest             @"http://www.chaojijifen.com:8088/Interface/UserAction!feedback.do"



/**===================================================
 * 经销商登录等接口
 ===========================================================**/
#define Distribution_Login_DataRequest          @"http://www.chaojijifen.com:8088/Interface/SellerAction!sellerLogin.do"
#define Distribution_Code_DataRequest           @"http://www.chaojijifen.com:8088/Interface/SellerAction!scanCode.do"
#define Distribution_CodeSubmit_DataRequest     @"http://www.chaojijifen.com:8088/Interface/SellerAction!scanCodeSubmit.do"
#define Distribution_PromotionList_DataRequest  @"http://www.chaojijifen.com:8088/Interface/SellerAction!queryAdList.do"
#define Distribution_ADDetail_DataRequest       @"http://www.chaojijifen.com:8088/Interface/SellerAction!queryAdInfo.do"


