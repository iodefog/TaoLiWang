//
//  YaoYiYaoViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-10.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "YaoYiYaoViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "YaoyiyaoListViewController.h"

@interface YaoYiYaoViewController ()
@property (nonatomic, strong) ITTTabBarController       *tabBar01;
@property (nonatomic, strong) YaoyiyaoListViewController    *yvc;
@property (strong, nonatomic) CLLocationManager * locationManager;
@property (nonatomic, copy) NSString            * Jingdu;
@property (nonatomic, copy) NSString            * Weidu;
@end

@implementation YaoYiYaoViewController
{

    __weak IBOutlet UIImageView *AnimotionImageView;
    SystemSoundID mySound;
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
#pragma mark
#pragma mark VieDidload
- (void)viewDidLoad
{
    [super viewDidLoad];
     AnimotionImageView.center = CGPointMake(160, 160);
}
#pragma mark
#pragma mark Yaoyiyao
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        
        mySound = [self createSoundID: @"glass.wav"];
        AudioServicesPlaySystemSound(mySound);
        
        [UIView animateWithDuration:0.5f animations:^{
            AnimotionImageView.transform = CGAffineTransformMakeRotation((90 * M_PI) / 180.0f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f animations:^{
                AnimotionImageView.transform = CGAffineTransformMakeRotation((-90 * M_PI) / 180.0f);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5f animations:^{
                    AnimotionImageView.transform = CGAffineTransformMakeRotation((0 * M_PI) / 180.0f);
                } completion:^(BOOL finished) {
                    /**
                     *  获取经纬度
                     */
                    self.locationManager =[[CLLocationManager alloc] init];
                    self.locationManager.delegate = self;
                    //经纬度精确度
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
                    //随时都可能更新经纬度
                    self.locationManager.distanceFilter = kCLDistanceFilterNone;
                    //询问是否访问您的经纬度
                    [self.locationManager startUpdatingLocation];
                }];
            }];
        }];
    }
}

///播放声音
-(SystemSoundID) createSoundID: (NSString*)name {
    NSString *path = [NSString stringWithFormat: @"%@/%@",
                      [[NSBundle mainBundle] resourcePath], name];
    NSURL* filePath = [NSURL fileURLWithPath: path isDirectory: NO];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    return soundID;
}

#pragma mark
#pragma mark UIButtonAction
- (IBAction)popControllerButtonClick:(id)sender {
    if (_isHiddenTabBar == YES) {
        _tabBar01 = (ITTTabBarController *)self.tabBarController;
        _tabBar01.tabBarHidden = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark
#pragma mark LocationDelegate
- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
    [self.locationManager stopUpdatingLocation];
    self.Jingdu = [NSString stringWithFormat:@"%.2f",self.locationManager.location.coordinate.longitude];
    self.Weidu = [NSString stringWithFormat:@"%.2f",self.locationManager.location.coordinate.latitude];
    self.yvc = [[YaoyiyaoListViewController alloc]initWithNibName:@"YaoyiyaoListViewController" bundle:nil];
    self.yvc.jindu = self.Jingdu;
    self.yvc.weidu = self.Weidu;
    self.yvc.UserId = self.UserId;
    [self.navigationController pushViewController:self.yvc animated:YES];
}

// 定位失败 提示信息
- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error {
    
    NSString *errorString;
    [manager stopUpdatingLocation];
    NSLog(@"Error: %@",[error localizedDescription]);
    switch([error code]) {
        case kCLErrorDenied:
            //Access denied by user
            errorString = @"请在“设置->隐私->定位服务”中确认“定位”和“淘礼网”是否为开启状态";
            //Do something...
            break;
        case kCLErrorLocationUnknown:
            //Probably temporary...
            errorString = @"位置数据不可用";
            //Do something else...
            break;
        default:
            errorString = @"发生未知错误";
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位失败" message:errorString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}
@end
