//
//  ITTTableView.h
//  TaoliWang
//
//  Created by Mac OS X on 14-3-12.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTXibView.h"


typedef enum {
    isloadNone = 0,
    isloadPoint,
    isloadMoney
}loadType;


@protocol SelectCustomViewDelegate <NSObject>

-(void)selectRangeData:(NSString *)NameStr andType:(loadType)type;

@end

@interface ITTTableView : ITTXibView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign)loadType   Type;
@property (nonatomic, strong)UIView     *backView;
@property (nonatomic, assign)id<SelectCustomViewDelegate>delegate;
-(void)ShowTableView:(loadType)Type;
@end
