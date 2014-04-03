//
//  MySpaceHeadView.h
//  TaoliWang
//
//  Created by Mac OS X on 14-3-7.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTXibView.h"

@protocol SendBtnDelegate <NSObject>

-(void)BtnPresss:(UIButton *)btn;

@end

@interface MySpaceHeadView : ITTXibView

@property (nonatomic, assign) id <SendBtnDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *TitielLable;
@property (weak, nonatomic) IBOutlet UIButton *SendBtn;

+(UIView *)HeaderView:(NSString *)title andTag:(id)delegate;
@end
