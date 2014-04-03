//
//  MyAlertView.m
//  T0925_HUD
//
//  Created by tt on 13-9-27.
//  Copyright (c) 2013年 tt. All rights reserved.
//

#import "MyAlertView.h"
#import "QuartzCore/QuartzCore.h"

#define kTextHighlightedColor [UIColor colorWithRed:43/255.0 green:139/255.0 blue:225/255.0 alpha:1]

@interface MyAlertView()

@property (retain, nonatomic) UIView *view_alert;

@end


@implementation MyAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithTitle:(NSString*) title
            message:(NSString*) message
       ButtonTitle1:(NSString*) title1
       ButtonTitle2:(NSArray*) otherTitle2
          onDismiss:(DismissAlertBlock) dismissed{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.dismissBlock = dismissed;
        
        UIView *view_bg = [[UIView alloc] initWithFrame:self.frame];
        view_bg.backgroundColor = [UIColor blackColor];
        view_bg.alpha = 0.4;
        [self addSubview:view_bg];

        
        self.view_alert = [[UIView alloc] init];
        //self.view_alert.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Pop_bg_general.png"]];
        
        
        self.label_title = [[UILabel alloc] initWithFrame:CGRectMake(12.5, 0, 220, title.length > 0?34:0)];
        self.label_title.backgroundColor = [UIColor clearColor];
        self.label_title.font = [UIFont boldSystemFontOfSize:19.0];
        self.label_title.textColor = [UIColor darkGrayColor];
        self.label_title.textAlignment = NSTextAlignmentCenter;
        self.label_title.text = title;
        [self.view_alert addSubview:self.label_title];
        
        
        UILabel *label_msg = [[UILabel alloc] initWithFrame:CGRectMake(12.5, self.label_title.frame.size.height == 0?12.5:self.label_title.frame.size.height, 220, 0)];
        label_msg.backgroundColor = [UIColor clearColor];
        label_msg.numberOfLines = 0;
        label_msg.font = [UIFont systemFontOfSize:12.0];
        label_msg.textColor = [UIColor grayColor];
        label_msg.textAlignment = NSTextAlignmentCenter;
        label_msg.text = message;
        [label_msg sizeToFit];
        //NSLog(@"%f",label_msg.frame.size.width);
        if (label_msg.frame.size.width < 220.0) {
            CGRect frame_labelMsg = label_msg.frame;
            frame_labelMsg.origin.x = ((250.0 - frame_labelMsg.size.width)/2.0);
            label_msg.frame = frame_labelMsg;
        }
        
        if (label_msg.frame.size.height > 200.0) {
            CGRect frame_labelMsg = label_msg.frame;
            frame_labelMsg.size.height = 200.0;
            label_msg.frame = frame_labelMsg;
        }
        
        [self.view_alert addSubview:label_msg];
        
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag = 0;
        [btn1 setTitle:title1 forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 setTitleColor:kTextHighlightedColor forState:UIControlStateHighlighted];
        btn1.titleLabel.font = [UIFont boldSystemFontOfSize:19.0];
        
        if (otherTitle2.count > 0) {
            btn1.frame = CGRectMake(12.5, (label_msg.frame.origin.y + label_msg.frame.size.height + 12.5), 112.5, 44);
            [btn1 setBackgroundImage:[UIImage imageNamed:@"Pop_btn_mouseout_2.png"] forState:UIControlStateNormal];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"Pop_btn_mouseover_2.png"] forState:UIControlStateHighlighted];
            
            UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn2 addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            btn2.tag = 1;
            btn2.frame = CGRectMake(btn1.frame.origin.x + btn1.frame.size.width, btn1.frame.origin.y , 112.5, 44);
            [btn2 setBackgroundImage:[UIImage imageNamed:@"Pop_btn_mouseout_3.png"] forState:UIControlStateNormal];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"Pop_btn_mouseover_3.png"] forState:UIControlStateHighlighted];
            [btn2 setTitle:otherTitle2[0] forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn2 setTitleColor:kTextHighlightedColor forState:UIControlStateHighlighted];
            btn2.titleLabel.font = [UIFont boldSystemFontOfSize:19.0];
            [self.view_alert addSubview:btn2];
        }else{
            btn1.frame = CGRectMake(12.5, (label_msg.frame.origin.y + label_msg.frame.size.height + 12.5), 225.0, 44);
            [btn1 setBackgroundImage:[UIImage imageNamed:@"Pop_btn_mouseout_1.png"] forState:UIControlStateNormal];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"Pop_btn_mouseover_1.png"] forState:UIControlStateHighlighted];
        }
        [self.view_alert addSubview:btn1];
        
        
        
        CGRect frameAlert = self.view_alert.frame;
        frameAlert.size = CGSizeMake(250, btn1.frame.origin.y + btn1.frame.size.height + 12.5);
        self.view_alert.frame = frameAlert;
        self.view_alert.center = self.center;
        
        
        UIImageView *iv_bg = [[UIImageView alloc] initWithFrame:self.view_alert.bounds];
        iv_bg.image = [[UIImage imageNamed:@"pop-up_bg_1"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 13, 13)];
        [self.view_alert insertSubview:iv_bg atIndex:0];
        [self addSubview:self.view_alert];
        
    }
    return self;

}

- (void)btnTouchUpInside:(id)sender{
    [self hide];
    
    UIButton *btn = (UIButton *)sender;
//    if ([self.delegate respondsToSelector:@selector(dismissWithButtonIndex:)]) {
//        [self.delegate dismissWithButtonIndex:btn.tag];
//    }
    if (self.dismissBlock) {
        self.dismissBlock(btn.tag);
    }
}

- (void)show{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.30;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.view_alert.layer addAnimation:animation forKey:nil];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)hide{
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (void)showAlertViewWithTitle:(NSString*) title
                       message:(NSString*) message
                  ButtonTitle1:(NSString*) title1
                  ButtonTitle2:(NSArray*) otherTitle2
                     onDismiss:(DismissAlertBlock) dismissed{
    
    MyAlertView *alertView = [[MyAlertView alloc] initWithTitle:title message:message ButtonTitle1:title1 ButtonTitle2:otherTitle2 onDismiss:dismissed];
    BOOL isExist = NO;
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[MyAlertView class]]) {
            isExist = YES;
            break;
        }
    }
    
    if (!isExist) {
        [alertView show];
    }
}



/**
 *  显示block的呼叫弹出view
 *
 *  @param title       提示标题
 *  @param message     提示内容
 *  @param buttonTitle 第一个按钮文字
 *  @param otherTitles 其他按钮文字
 *  @param dismissed   消失block处理
 */
+ (void)showBlockAlertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                        buttonTitle:(NSString *)buttonTitle
                       buttonTitles:(NSArray *)otherTitles
                          onDismiss:(DismissAlertBlock)dismissed {
    MyAlertView *alertView = [[MyAlertView alloc] initWithTitle:title message:message ButtonTitle1:buttonTitle ButtonTitle2:otherTitles onDismiss:dismissed];
//    alertView.label_title.backgroundColor = [UIColor orangeColor];
    alertView.label_title.frame = CGRectMake(50, 0, alertView.view_alert.frame.size.width-(2*50), title.length > 0?34:0);
    alertView.label_title.font = [UIFont boldSystemFontOfSize:15.0];
    alertView.cardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21, 7, 28, 20)];
    alertView.cardImageView.image = [UIImage imageNamed:@"Icon_card"];
    [alertView.view_alert addSubview:alertView.cardImageView];
    
    BOOL isExist = NO;
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[MyAlertView class]]) {
            isExist = YES;
            break;
        }
    }
    
    if (!isExist) {
        [alertView show];
    }
}


@end
