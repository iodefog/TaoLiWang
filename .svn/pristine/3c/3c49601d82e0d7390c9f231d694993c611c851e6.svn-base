//
//  ITTSelectView.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-12.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTSelectView.h"

@implementation ITTSelectView

- (id)init
{
    self = [super init];
    if (self) {
        self = [ITTSelectView loadFromXib];
    }
    return self;
}
-(void)showSelectView{
    self.top = 57;
    self.left = 10;
    [[UIApplication sharedApplication].delegate.window addSubview:self];
}
-(void)HiddenSelectView
{
    [UIView animateWithDuration:0.0 animations:^{
        self.width = 0;
        self.height = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.backView removeFromSuperview];
    }];
}

- (void)GestureAction:(UITapGestureRecognizer *)recognizer
{
    [self HiddenSelectView];
}

- (IBAction)MoneyBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(MoneyBtnAction:)]) {
        [self.delegate MoneyBtnAction:btn];
        [self HiddenSelectView];
    }
}
- (IBAction)PointBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(PointBtnAction:)]) {
        [self.delegate PointBtnAction:btn];
        [self HiddenSelectView];
    }
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
    self.backView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GestureAction:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.backView addGestureRecognizer:tapGestureRecognizer];
    [[UIApplication sharedApplication].delegate.window addSubview:self.backView];
}
@end
