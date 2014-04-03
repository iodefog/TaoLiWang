//
//  MyAlertView.h
//  T0925_HUD
//
//  Created by tt on 13-9-27.
//  Copyright (c) 2013年 tt. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol DismissAlertDelegate <NSObject>
//
//- (void)dismissWithButtonIndex:(int)index;
//
//@end

typedef void (^DismissAlertBlock)(int buttonIndex);

@interface MyAlertView : UIView

//@property (assign, nonatomic) id<DismissAlertDelegate> delegate;
@property (nonatomic, copy) DismissAlertBlock dismissBlock;

@property (nonatomic, strong) UILabel *label_title;         // 标题label
@property (nonatomic, strong) UIImageView *cardImageView;   // card


+ (void)showAlertViewWithTitle:(NSString*) title
                       message:(NSString*) message
                  ButtonTitle1:(NSString*) title1
                  ButtonTitle2:(NSArray*) otherTitle2
                     onDismiss:(DismissAlertBlock) dismissed;


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
                          onDismiss:(DismissAlertBlock)dismissed;


@end
