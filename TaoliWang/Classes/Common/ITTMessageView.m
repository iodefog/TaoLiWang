//
//  ITTMessageView.m
//  iTotemFramework
//
//  Created by jack 廉洁 on 3/31/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import "ITTMessageView.h"

#define ITTMessageViewDefaultDisappearTime 2

@interface ITTMessageView()
- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer;
@end

@implementation ITTMessageView


#pragma mark - private methods
- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    [self hide01:nil];
}

#pragma mark - public methods
+ (void)showMessage:(NSString*)msg disappearAfterTime:(int)time andView:(UIView *)view
{
    ITTMessageView *msgView = [ITTMessageView loadFromXib];
    msgView.bottom = Screen_height;
    UIImage *bgImage = [msgView.bgImageView.image stretchableImageWithLeftCapWidth:msgView.bgImageView.image.size.width/2 topCapHeight:msgView.bgImageView.image.size.height/2];
    msgView.bgImageView.image = bgImage;
    msgView.left = (320 - msgView.width)/2;
    msgView.messageLbl.text = msg;
    msgView.alpha = 0.0;
    [[UIApplication sharedApplication].delegate.window addSubview:msgView];
    [UIView animateWithDuration:0.4
                     animations:^{
                         msgView.alpha = 1;
                         msgView.top = Screen_height-50;
                     } 
                     completion:^(BOOL finished) {
                         [msgView performSelector:@selector(hide:) withObject:view afterDelay:time];
                     }];
    
}

+(void)showMessage01:(NSString *)msg disappearAfterTime:(int)time andView:(UIView *)view
{
    ITTMessageView *msgView = [ITTMessageView loadFromXib];
    msgView.top = Screen_height-300;
    msgView.left = (320 - msgView.width)/2;
    msgView.messageLbl.text = msg;
    msgView.alpha = 0.0;
    [[UIApplication sharedApplication].delegate.window addSubview:msgView];
    [UIView animateWithDuration:0.4
                     animations:^{
                         msgView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [msgView performSelector:@selector(hide01:) withObject:view afterDelay:time];
                     }];

}
+ (void)showMessage:(NSString*)msg
{
    int disappearTime = ITTMessageViewDefaultDisappearTime;
    [ITTMessageView showMessage:msg disappearAfterTime:disappearTime andView:nil];
}

- (void)hide01:(UIView *)view
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         [view removeFromSuperview];
                     }];
}

- (void)hide:(UIView *)view
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.bottom = Screen_height;
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         [view removeFromSuperview];
                     }];
}

#pragma mark - lifecycle methods

- (void)dealloc
{
    ITTDINFO(@"message view deallocated");
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapGestureRecognizer];
    _disappearTime = 1;
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 10;
    _bgView.layer.borderWidth = 1;
    _bgView.layer.borderColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
    
}

@end
