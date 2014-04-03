//
//  ResultScanningViewController.h
//  TaoliWang
//
//  Created by Mac OS X on 14-1-23.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultScanningViewController : UIViewController<UIAlertViewDelegate>
@property (copy, nonatomic)NSString         *DataStr;
@property (nonatomic ,assign) int          Scannning;
@end
