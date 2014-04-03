//
//  ITTTabBarController.h
//  TaoliWang
//
//  Created by zdqk on 14-1-8.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITTTabBarView.h"


@interface ITTTabBarController : UITabBarController<ITTCustomTabBarViewDelegate>
{
    BOOL           _tabBarHidden;
    UIView        *_contentView;
    ITTTabBarView *_customTabBarView;
}

@property (nonatomic, assign) BOOL tabBarHidden;
@property (nonatomic, assign) CGFloat tabHeight;
@property (nonatomic, retain) ITTTabBarView *customTabBarView;
@property (nonatomic, retain, readonly) UIView *contentView;

- (void)setContentViewBounds;
- (void)setNumberlable;
//subclass must override this method to sepcify tabbar class
- (NSString*)tabBarClassName;
@end
