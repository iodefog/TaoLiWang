//
//  ITTTableView.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-12.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTTableView.h"
#import "SearchScopeCell.h"

@implementation ITTTableView

{
    NSArray                     *PointArray;
    NSArray                     *MoneyArray;
    __weak IBOutlet UITableView *SelectView;
}
- (id)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        PointArray = [[NSArray alloc]init];
        MoneyArray = [[NSArray alloc]init];
        self = [ITTTableView loadFromXib];
        //设置子视图随父视图改变而改变
        SelectView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        //默认为0;
        _Type = isloadNone;

    }
    return self;
}

-(void)ShowTableView:(loadType)Type{
    //读取数据
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SearchPlist" ofType:@"plist"]];
    PointArray = [dict objectForKey:@"Point"];
    MoneyArray = [dict objectForKey:@"Money"];
    
    self.top = 94;
    //设置x坐标和高度
    if (Type == isloadPoint) {
        self.left = 1;
        self.height = 344;
    }
    if (Type == isloadMoney) {
        self.left = 161;
        self.height = 212;
    }
    _Type = Type;
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    [SelectView reloadData];
}
-(void)HiddenTableView
{
    [UIView animateWithDuration:0.0 animations:^{
        self.height = 0;
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_Type == isloadPoint ) {
        return PointArray.count;
    }
    if (_Type == isloadMoney){
        return MoneyArray.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *celldentify = @"cell";
    SearchScopeCell *cell = [tableView dequeueReusableCellWithIdentifier:celldentify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SearchScopeCell" owner:self options:nil]lastObject];
    }
    if (_Type == isloadPoint) {
        cell.NameLable.text = [PointArray objectAtIndex:indexPath.row];
    }
    if (_Type == isloadMoney) {
        cell.NameLable.text = [MoneyArray objectAtIndex:indexPath.row];
    }
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    if ([self.delegate respondsToSelector:@selector(selectRangeData:andType:)]) {
        if (_Type == isloadPoint) {
            [self.delegate selectRangeData:[PointArray objectAtIndex:indexPath.row] andType:_Type];
        }
        if (_Type == isloadMoney) {
            [self.delegate selectRangeData:[MoneyArray objectAtIndex:indexPath.row] andType:_Type];
        }
        [self HiddenTableView];
    }
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
    self.backView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GestureClick:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.backView addGestureRecognizer:tapGestureRecognizer];
    [[UIApplication sharedApplication].delegate.window addSubview:self.backView];
}
//隐藏tableView
-(void)GestureClick:(UIGestureRecognizer *)recognizer
{
    [self HiddenTableView];
}
@end
