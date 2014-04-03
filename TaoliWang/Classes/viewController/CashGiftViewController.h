//
//  CashGiftViewController.h
//  TaoliWang
//
//  Created by Mac OS X on 14-1-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopCarView.h"
@interface CashGiftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ITTPullTableViewDelegate,JoinCarDelegate>
@property (strong, nonatomic) NSString                          *Type;
@property (assign, nonatomic) BOOL                              isTabBarHidden;
@property (copy, nonatomic) NSString                            *UserId;
@end
