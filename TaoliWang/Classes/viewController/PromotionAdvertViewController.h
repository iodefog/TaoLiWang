//
//  PromotionAdvertViewController.h
//  TaoliWang
//
//  Created by Mac OS X on 14-1-14.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromotionAdvertViewController : UIViewController<UIAlertViewDelegate,UIWebViewDelegate>
@property (nonatomic, assign)BOOL               isRootViewController;
@property (nonatomic, copy)NSString             *ActivityId;
@end
