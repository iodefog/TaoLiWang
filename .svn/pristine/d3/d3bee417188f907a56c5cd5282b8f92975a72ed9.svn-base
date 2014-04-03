//
//  ITTTabBarView.m
//  TaoliWang
//
//  Created by zdqk on 14-1-9.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTTabBarView.h"
#import "UserInfomationModel.h"
#import "SaveAndGetUserInformation.h"
#import "AppDelegate.h"
@interface ITTTabBarView ()
{
    UIButton                    *_selectedButton;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *tab1Button;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *tab2Button;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *tab3Button;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *tab4Button;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *tab5Button;

@end

@implementation ITTTabBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/**
 *  加载tabBarView
 *
 *  @return
 */
+(ITTTabBarView *)viewFromNib
{
    return [[self class] loadFromXib];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    _selectedButton = _tab1Button;
}


/**
 *  代理
 *
 *  @param BOOL
 *
 *  @return
 */

#pragma mark - public methods

- (BOOL)shouldSelectTab:(NSInteger)index
{
    BOOL shouldSelect = TRUE;
    if (_delegate && [_delegate respondsToSelector:@selector(customTabBarWillSelect:selectedIndex:)]) {
        shouldSelect = [_delegate customTabBarWillSelect:self selectedIndex:index];
    }
    return shouldSelect;
}

- (void)notifyDelegate:(NSInteger)index
{
    if (_delegate && [_delegate respondsToSelector:@selector(customTabBar:selectedIndex:)]) {
        [_delegate customTabBar:self selectedIndex:index];
    }
}
/**
 *  私有方法
 *
 *  @param sender
 */


-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    int selIndex = (int)selectedIndex;
    [self selectTabAtIndex:selIndex];
}
-(void)selectTabAtIndex:(int)index
{
    _selectedButton.enabled = YES;
    switch (index) {
        case 0:{
            _selectedButton = _tab1Button;
            break;
        }
        case 1:{
            
            _selectedButton = _tab2Button;
            break;
        }
        case 2:{
            _selectedButton = _tab3Button;
            
            break;
        }
        case 3:{
            
            _selectedButton = _tab4Button;
            break;
        }
        case 4:{
            _selectedButton = _tab5Button;
            break;
        }
        default:
            break;
    }
    _selectedButton.enabled = NO;
}

- (IBAction)onTab1Action:(id)sender {
    if ([self shouldSelectTab:0]) {
        [self selectTabAtIndex:0];
        [self notifyDelegate:0];
    }
}
- (IBAction)onTab2Action:(id)sender {
    if ([self shouldSelectTab:1]) {
        [self selectTabAtIndex:1];
        [self notifyDelegate:1];
    }
}
- (IBAction)onTab3Action:(id)sender {
    
    UserInfomationModel *model = [SaveAndGetUserInformation readUserDefaults];
    if ([model.UserId length] == 0) {
        [SharedApp showViewController:LOGIN_VIEW_CONTROLLER andIndex:0];
        return;
    }
    if ([self shouldSelectTab:2]) {
        [self selectTabAtIndex:2];
        [self notifyDelegate:2];
    }
}
- (IBAction)onTab4Action:(id)sender {
    if ([self shouldSelectTab:3]) {
        [self selectTabAtIndex:3];
        [self notifyDelegate:3];
    }
}
- (IBAction)onTab5Action:(id)sender {
    if ([self shouldSelectTab:4]) {
        [self selectTabAtIndex:4];
        [self notifyDelegate:4];
    }
}
@end
