//
//  MyPayCountViewController.h
//  TaoliWang
//
//  Created by Mac OS X on 14-2-8.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPayCountViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ITTPullTableViewDelegate>
@property (nonatomic, copy)NSString                 *UserId;
@end
