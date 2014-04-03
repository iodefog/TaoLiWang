//
//  ITTShareView.h
//  TaoliWang
//
//  Created by Mac OS X on 14-3-10.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTXibView.h"

@protocol ShareDelegate <NSObject>
-(void)SinaShareBtnClick:(UIButton *)sender;
-(void)WeiXinShareBtnClick:(UIButton *)sender;
-(void)QQSpaceShareBtnCLick:(UIButton *)sender;
@end

@interface ITTShareView : ITTXibView
@property (nonatomic,assign)id<ShareDelegate>delegate;
@property (nonatomic, strong)UIView *backView;
-(void)ShowShareView;
@end
