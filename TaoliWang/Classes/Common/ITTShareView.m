//
//  ITTShareView.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-10.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTShareView.h"

@implementation ITTShareView

-(id)init{
    if (self = [super init]) {
        self = [ITTShareView loadFromXib];
    }
    return self;
}

-(void)ShowShareView
{
    self.top = Screen_height;
    self.left = 0;
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.5f;
    
    [[UIApplication sharedApplication].delegate.window addSubview:self.backView];
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.top = Screen_height-self.size.height;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)hidden{
    [UIView animateWithDuration:0.3 animations:^{
        self.top = Screen_height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.backView removeFromSuperview];
    }];
}

- (IBAction)SinaShare:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(SinaShareBtnClick:)]) {
        [self.delegate SinaShareBtnClick:btn];
        [self hidden];
    }
}
- (IBAction)WeiXinShare:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(WeiXinShareBtnClick:)]) {
        [self.delegate WeiXinShareBtnClick:btn];
        [self hidden];
    }
}
- (IBAction)QQSpaceShare:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(QQSpaceShareBtnCLick:)]) {
        [self.delegate QQSpaceShareBtnCLick:btn];
        [self hidden];
    }
}
- (IBAction)CancelBtn:(id)sender {
    [self hidden];
}

-(void)awakeFromNib{
    [super awakeFromNib];
}
@end
