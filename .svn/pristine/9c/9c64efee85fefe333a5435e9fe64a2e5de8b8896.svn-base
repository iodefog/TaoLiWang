//
//  BootPageViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-24.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#define PageCount       4


#import "BootPageViewController.h"
#import "AppDelegate.h"
#import "RegistViewController.h"

@interface BootPageViewController ()

@end

@implementation BootPageViewController
{
    __weak IBOutlet UIScrollView *I5ScrollView;
    __weak IBOutlet UIPageControl *I5Page;
    __weak IBOutlet UIView *I5LoginButton;
    __weak IBOutlet UIButton *I5HomeButton;
    
    __weak IBOutlet UIScrollView *I4ScrollView;
    __weak IBOutlet UIPageControl *I4Page;
    __weak IBOutlet UIButton *I4LoginButton;
    __weak IBOutlet UIButton *I4HomeButton;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setObject:@"BootPage_Value" forKey:@"BootPage_key"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self iphone5Andiphone4];
}
-(void)iphone5Andiphone4{
    if (iPhone5)
    {
        for (int i =0; i<PageCount; i++) {
            I5ScrollView.contentSize = CGSizeMake(Screen_width*PageCount, Screen_height);
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_width*i, 0, Screen_width, Screen_height)];
            image.image = [UIImage imageNamed:[NSString stringWithFormat:@"引导页-%d",i+1]];
            [I5ScrollView addSubview:image];
        }
        
    }
    else
    {
        for (int i =0; i<PageCount; i++) {
            I4ScrollView.contentSize = CGSizeMake(Screen_width*PageCount, Screen_height);
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_width*i, 0, Screen_width, Screen_height)];
            image.image = [UIImage imageNamed:[NSString stringWithFormat:@"引导页-%d-i4",i+1]];
            [I4ScrollView addSubview:image];
        }

    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    I5Page.currentPage = scrollView.contentOffset.x/Screen_width;
    I4Page.currentPage = scrollView.contentOffset.x/Screen_width;
    if (scrollView.contentOffset.x/Screen_width>=3) {
        I5LoginButton.hidden = NO;
        I5HomeButton.hidden = NO;
        I4HomeButton.hidden = NO;
        I4LoginButton.hidden = NO;
    }else{
        I5LoginButton.hidden = YES;
        I5HomeButton.hidden = YES;
        I4HomeButton.hidden = YES;
        I4LoginButton.hidden = YES;
    }
}


- (IBAction)HomeButtonAction:(id)sender {
    [SharedApp showViewController:HOME_VIEW_CONTROLLER andIndex:0];
}
- (IBAction)LoginButtonAction:(id)sender {
    RegistViewController *lvc = [[RegistViewController alloc]initWithNibName:@"RegistViewController" bundle:nil];
    lvc.HomeBootPage = YES;
    [self presentViewController:lvc animated:YES completion:^{}];
}
@end
