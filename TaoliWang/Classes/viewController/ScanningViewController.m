//
//  ScanningViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ScanningViewController.h"
#import "ResultScanningViewController.h"
@interface ScanningViewController ()
@property (nonatomic, strong)ITTTabBarController                *ITTTabBarController;
@property (weak, nonatomic) IBOutlet UILabel                    *DiffrentyLable;
@property (weak, nonatomic) IBOutlet ZBarReaderView             *tiaoxingmaView;
@property (weak, nonatomic) IBOutlet ZBarReaderView             *erweimaView;



@end

@implementation ScanningViewController
{
    ZBarCameraSimulator *camerasim;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void) viewWillAppear:(BOOL)animated
{
    [ZBarReaderView class];
    _DiffrentyLable.text = _TitleStr;
    if (self.Scanning == isHome) {
        _erweimaView.hidden = NO;
        _readTwoView.readerDelegate = self;
        _readTwoView.torchMode = 0;
        camerasim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        camerasim.readerView = _erweimaView;
        [_readTwoView start];
    }else
    {
        _tiaoxingmaView.hidden = NO;
        _readOneView.readerDelegate = self;
        _readOneView.torchMode = 0;
        camerasim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        camerasim.readerView = _tiaoxingmaView;
        [_readOneView start];
    }

}
- (void) viewWillDisappear: (BOOL) animated
{
    if (self.Scanning == isHome) {
        [_readTwoView stop];
//        [_readTwoView removeFromSuperview];
    }else
    {
        [_readOneView stop];
//        [_readOneView removeFromSuperview];
    }
}
#pragma mark -
#pragma mark ReaderViewDelegate
-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{

    for(ZBarSymbol *sym in symbols) {
        NSLog(@"ddd == %@",sym.data);
        if ([sym.data length] != 0) {
            ResultScanningViewController *rvc = [[ResultScanningViewController alloc]initWithNibName:@"ResultScanningViewController" bundle:nil];
            rvc.DataStr = sym.data;
            rvc.Scannning = self.Scanning;
            [self.navigationController pushViewController:rvc animated:YES];
            break;
        }

        
    }
}

#pragma mark -
#pragma mark popViewController

- (IBAction)PopViewController:(id)sender {
    if (self.Scanning == isHome) {
        _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
        _ITTTabBarController.tabBarHidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }


}

@end
