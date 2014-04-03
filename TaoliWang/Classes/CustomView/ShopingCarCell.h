//
//  ShopingCarCell.h
//  TaoliWang
//
//  Created by Mac OS X on 14-1-15.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopingCarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ITTImageView *ShopImageView;
@property (weak, nonatomic) IBOutlet UILabel *NameLable;
@property (weak, nonatomic) IBOutlet UILabel *NumberLable;
@property (weak, nonatomic) IBOutlet UILabel *PriceLable;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UITextField *NubmberTextField;
@property (weak, nonatomic) IBOutlet UIButton *increaseBtn;
@property (weak, nonatomic) IBOutlet UILabel *ProductId;
@property (weak, nonatomic) IBOutlet UIView *BackGrondView;
@property (weak, nonatomic) IBOutlet UIButton *DeleteBtn;

@end
