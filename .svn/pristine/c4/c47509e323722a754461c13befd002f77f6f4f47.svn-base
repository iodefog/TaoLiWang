//
//  ITTTabBarView.h
//  TaoliWang
//
//  Created by zdqk on 14-1-9.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTXibView.h"
#import <UIKit/UIKit.h>

@protocol ITTCustomTabBarViewDelegate;
@interface ITTTabBarView : ITTXibView
@property (nonatomic, assign) id <ITTCustomTabBarViewDelegate>   delegate;
@property (nonatomic, assign) NSInteger                         selectedIndex;
@property (weak, nonatomic) IBOutlet UILabel *NumberLable;
@property (weak, nonatomic) IBOutlet UIImageView *NumberPhoto;

+(ITTTabBarView *)viewFromNib;
- (void)notifyDelegate:(NSInteger)index;
- (BOOL)shouldSelectTab:(NSInteger)index;
@end

@protocol ITTCustomTabBarViewDelegate <NSObject>
/**
 *  可实现和不可实现的代理
 */
@optional
- (void)customTabBar:(ITTTabBarView*)tabBar selectedIndex:(NSInteger)index;
- (BOOL)customTabBarWillSelect:(ITTTabBarView*)tabBar selectedIndex:(NSInteger)index;

@end