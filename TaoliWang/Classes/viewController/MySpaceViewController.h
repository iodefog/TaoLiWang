//
//  MySpaceViewController.h
//  TaoliWang
//
//  Created by Mac OS X on 14-2-10.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "MySpaceHeadView.h"
#import "ITTShareView.h"

@interface MySpaceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,SendBtnDelegate,ShareDelegate>
@property (nonatomic, copy)NSString                 *UserId;
@property (nonatomic, copy)NSString                 *userName;
@end
