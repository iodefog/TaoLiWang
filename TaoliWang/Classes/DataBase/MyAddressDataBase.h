//
//  MyAddressDataBase.h
//  TaoliWang
//
//  Created by Mac OS X on 14-2-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "DataBase.h"
#import "AddressModel.h"
@interface MyAddressDataBase : DataBase
+(MyAddressDataBase *)shareDataBase;
//插入数据
-(BOOL)insertItem:(id)item;
-(void)insertItemArray:(NSArray *)array;
//读取数据
-(NSMutableArray *)readTableName:(NSString *)tableName;
//更新首选地址
-(void)updateItem:(id)item;
-(void)update;
@end
