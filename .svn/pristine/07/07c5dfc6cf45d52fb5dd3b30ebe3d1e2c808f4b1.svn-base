//
//  MySpaceHeadView.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-7.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MySpaceHeadView.h"

@implementation MySpaceHeadView

+(UIView *)HeaderView:(NSString *)title andTag:(id)delegate
{
    MySpaceHeadView *view = [MySpaceHeadView loadFromXib];
    view.top = 0;
    view.left = 0;
    view.TitielLable.text = title;
    view.delegate = delegate;
    return view;
}
- (IBAction)BtnAciton:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(BtnPresss:)]) {
        [self.delegate BtnPresss:btn];
    }
}
-(void)awakeFromNib{
    [super awakeFromNib];
}
@end
