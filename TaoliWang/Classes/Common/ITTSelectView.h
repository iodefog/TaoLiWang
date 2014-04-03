//
//  ITTSelectView.h
//  TaoliWang
//
//  Created by Mac OS X on 14-3-12.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTXibView.h"

@protocol SearchSelectViewDelegate <NSObject>

-(void)MoneyBtnAction:(UIButton *)sender;
-(void)PointBtnAction:(UIButton *)sender;

@end

@interface ITTSelectView : ITTXibView
@property (nonatomic, assign)id<SearchSelectViewDelegate>delegate;
@property (nonatomic, strong)UIView *backView;

-(void)showSelectView;
-(void)HiddenSelectView;
@end
