//
//  ITTTabBarController.m
//  TaoliWang
//
//  Created by zdqk on 14-1-8.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTTabBarController.h"
#import "GoodsListModel.h"
#import "GoodsDetailDataBase.h"

@interface ITTTabBarController ()
@property (nonatomic, strong) NSMutableArray        *array;
@end

@implementation ITTTabBarController

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (id)init
{
    if (self = [super init]) {
        self.tabBarHidden = FALSE;
        self.array = [[NSMutableArray alloc]initWithCapacity:1000];
    }
    return self;
}

- (void)setContentViewBounds
{
	if ([[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ) {
		_contentView = [self.view.subviews objectAtIndex:1];
	}
	else {
		_contentView = [self.view.subviews objectAtIndex:0];
	}
    _contentView.frame = CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMinY(self.view.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.frame));
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window bringSubviewToFront:self.customTabBarView];
}

-(void)setNumberlable
{
    self.array = [[GoodsDetailDataBase shareDataBase] readTableName:@"CarsList"];
    if ([self.array count] == 0) {
        self.customTabBarView.NumberLable.text = @"";
        self.customTabBarView.NumberPhoto.hidden = YES;
        return;
    }
    self.customTabBarView.NumberPhoto.hidden = NO;
    self.customTabBarView.NumberLable.text = [NSString stringWithFormat:@"%d",[self.array count]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupTabView];
    [self setNumberlable];
    [self setContentViewBounds];
    self.tabBar.hidden = TRUE;
    self.tabBar.alpha = 0.0;
    self.tabBar.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - self.tabHeight, CGRectGetWidth(self.view.bounds), self.tabHeight);
    self.tabBar.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - private methods
- (void)setupTabView
{
    NSString *tabbarClassName = [self tabBarClassName];
    NSAssert(tabbarClassName != nil, @"tabbar class is nil");
    Class tabBarClass = NSClassFromString(tabbarClassName);
    self.customTabBarView = [tabBarClass viewFromNib];
    self.tabHeight = CGRectGetHeight(self.customTabBarView.bounds);
    CGRect frame = self.customTabBarView.frame;
    frame.origin.y = CGRectGetHeight(self.view.bounds) - self.tabHeight;
    self.customTabBarView.delegate = self;
    self.customTabBarView.frame  = frame;
    //    [self.view addSubview:self.customTabBarView];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self.customTabBarView];
    [window bringSubviewToFront:self.customTabBarView];
}

- (void)setTabBarHidden:(BOOL)tabBarHidden
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    CGRect frame = self.customTabBarView.frame;
    CGRect contentFrame = _contentView.frame;
    if (_tabBarHidden != tabBarHidden) {
        if (tabBarHidden) {
            frame.origin.y = CGRectGetHeight(self.view.bounds);
            contentFrame.size.height = CGRectGetHeight(window.screen.bounds);
        }
        else {
            frame.origin.y = CGRectGetHeight(self.view.bounds) - self.tabHeight;
            contentFrame.origin.y = 0;
            contentFrame.size.height = CGRectGetHeight(window.screen.bounds) - self.tabHeight;
        }
        if (tabBarHidden) {
            _contentView.frame = contentFrame;
            [UIView animateWithDuration:0.3 animations:^{
                self.customTabBarView.frame = frame;
            }];
        }
        else {
            [UIView animateWithDuration:0.3 animations:^{
                self.customTabBarView.frame = frame;
            } completion:^(BOOL finished) {
                if (finished) {
                    _contentView.frame = contentFrame;
                }
            }];
        }
        _tabBarHidden = tabBarHidden;
    }
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [self.customTabBarView setSelectedIndex:selectedIndex];
    [super setSelectedIndex:selectedIndex];
}
#pragma mark - public
- (NSString*)tabBarClassName
{
    return @"ITTTabBarView";
}
#pragma mark - ITTCustomTabBarViewDelegate
- (void) customTabBar:(ITTTabBarView*)tabBar selectedIndex:(NSInteger)index
{
    if (self.selectedIndex == index) {
        if([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController*)self.selectedViewController popToRootViewControllerAnimated:TRUE];
        }
    }
    else {
        self.selectedIndex = index;
    }
}

@end
