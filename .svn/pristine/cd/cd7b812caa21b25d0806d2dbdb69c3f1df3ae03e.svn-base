//
//  MyAddressDataBase.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "MyAddressDataBase.h"
static MyAddressDataBase *gl_DataBse = nil;
@implementation MyAddressDataBase
+(MyAddressDataBase *)shareDataBase
{
    if (!gl_DataBse) {
        gl_DataBse = [[MyAddressDataBase alloc]init];
    }
    return gl_DataBse;
}
-(id)init
{
    if (self = [super init]) {
        if ([mdataBase open]) {
            NSDictionary *fileName = @{@"Name":@"VARCHAR",
                                       @"AddressId":@"VARCHAR",
                                       @"Address":@"VARCHAR",
                                       @"Province":@"VARCHAR",
                                       @"Phone":@"VARCHAR",
                                       @"ZipCode":@"VARCHAR",
                                       @"type":@"VARCHAR",
                                       @"city":@"VARCHAR"};
            [super createTable:@"MyAddress" fieldName:fileName];
        }
    }
    return self;
}
-(BOOL)insertItem:(id)item
{
    @synchronized(self){
        AddressModel *newItem = (AddressModel *)item;
        [mdataBase open];
        if ([item isKindOfClass:[AddressModel class]]) {
            
            NSString *sql01 = [NSString stringWithFormat:@"SELECT * FROM MyAddress WHERE AddressId='%@'",newItem.AddressId];
            FMResultSet *rs = [mdataBase executeQuery:sql01];
            if ([rs next])
            {
                return NO;
            }
            else
            {
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO MyAddress (Name,AddressId,Address,Province,Phone,ZipCode,type,city) VALUES (?,?,?,?,?,?,?,?)"];
                BOOL success = [mdataBase executeUpdate:sql,newItem.Name,newItem.AddressId,newItem.Address,newItem.Province,newItem.Phone,newItem.ZipCode,newItem.type,newItem.city];
                return success;
            }
            [self closeDB];
        }
        else
        {
            return NO;
        }
    }

}
-(void)insertItemArray:(NSArray *)array
{
    [mdataBase beginTransaction];
    for (id object in array) {
        [self insertItem:object];
    }
    [mdataBase commit];
}
/**
 *  判断是否有数据  有就不插入  没有就插入
 */

-(NSMutableArray *)readTableName:(NSString *)tableName
{
    @synchronized(self){
        NSString *sql = nil;
        if ([tableName isEqualToString:@"MyAddress"]) {
            sql = [NSString stringWithFormat:@"SELECT Name,AddressId,Address,Province,Phone,ZipCode,type,city FROM %@",tableName];
        }
        if (sql) {
            [mdataBase open];
            FMResultSet *rs = [mdataBase executeQuery:sql];
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            while ([rs next]) {
                AddressModel *item = [[AddressModel alloc]init];
                item.Name = [rs stringForColumn:@"Name"];
                item.Address = [rs stringForColumn:@"Address"];
                item.AddressId = [rs stringForColumn:@"AddressId"];
                item.Phone = [rs stringForColumn:@"Phone"];
                item.ZipCode = [rs stringForColumn:@"ZipCode"];
                item.type = [rs stringForColumn:@"type"];
                item.Province = [rs stringForColumn:@"Province"];
                item.city = [rs stringForColumn:@"city"];
                [resultArray addObject:item];
            }
            return resultArray;
        }
        return nil;
        [self closeDB];
    }
}
/**
 *  更新数据
 *
 *  @param item
 *  @param num
 */
-(void)updateItem:(id)item
{
    @synchronized(self){
        [mdataBase open];
        if ([item isKindOfClass:[AddressModel class]]) {
            AddressModel *model =(AddressModel *)item;
            
            NSString *sql01 = @"update MyAddress set type='0' where AddressId";
            BOOL success01 = [mdataBase executeUpdate:sql01];
            if (!success01) {
                NSLog(@"更新失败01");
            }
            
            NSString *sql = [NSString stringWithFormat:@"update MyAddress set Name='%@',Address='%@',Province='%@',Phone='%@',ZipCode='%@',type='%@',city='%@' where AddressId='%@'",model.Name,model.Address,model.Province,model.Phone,model.ZipCode,model.type,model.city,model.AddressId];
            BOOL success = [mdataBase executeUpdate:sql];
            if (!success) {
                NSLog(@"更新失败");
            }
        }
        [self closeDB];
    }
}
-(void)update
{
    NSString *sql01 = @"update MyAddress set type='0' where AddressId";
    BOOL success01 = [mdataBase executeUpdate:sql01];
    if (!success01) {
        NSLog(@"更新失败01");
    }
}
@end
