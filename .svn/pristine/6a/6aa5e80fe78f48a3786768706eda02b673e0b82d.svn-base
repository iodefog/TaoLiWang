//
//  SearchViewController.h
//  TaoliWang
//
//  Created by Mac OS X on 14-1-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "ITTSelectView.h"
#import "ITTTableView.h"
#import "PopCarView.h"

typedef NS_ENUM(NSInteger, GoodsType) {
    isSearchPoint = 0,
    isSearchMoney,
    isBtnPoint,
    isBtnMoney
};

@interface SearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SearchSelectViewDelegate,SelectCustomViewDelegate,JoinCarDelegate>
@property (nonatomic, assign)BOOL       HomeToSearch;
@property (nonatomic, assign)GoodsType  gType;
@end
