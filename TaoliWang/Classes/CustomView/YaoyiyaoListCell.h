//
//  YaoyiyaoListCell.h
//  TaoliWang
//
//  Created by HE on 14-3-5.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YaoyiyaoListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ITTImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titelLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UILabel *typeLable;
@property (weak, nonatomic) IBOutlet UILabel *distanceLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;

@end
