//
//  SearchPointViewController.h
//  TaoliWang
//
//  Created by Mac OS X on 14-1-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchPointViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, copy)NSString                 *UserID;
@end
