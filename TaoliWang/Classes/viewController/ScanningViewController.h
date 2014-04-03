//
//  ScanningViewController.h
//  TaoliWang
//
//  Created by Mac OS X on 14-1-13.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanningViewController : UIViewController<ZBarReaderViewDelegate>
@property (retain, nonatomic) IBOutlet ZBarReaderView   *readOneView;
@property (weak, nonatomic) IBOutlet ZBarReaderView     *readTwoView;

@property (copy, nonatomic) NSString                    *TitleStr;
@property (nonatomic) int                               Scanning;
@end
