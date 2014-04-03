//
//  GoodsDetailDataBase.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-16.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "GoodsDetailDataBase.h"
static GoodsDetailDataBase *gl_DataBse = nil;
@implementation GoodsDetailDataBase
+(GoodsDetailDataBase *)shareDataBase
{
    if (!gl_DataBse) {
        gl_DataBse = [[GoodsDetailDataBase alloc]init];
    }
    return gl_DataBse;
}
-(id)init
{
    if (self = [super init]) {
        if ([mdataBase open]) {
            NSDictionary *fileName = @{@"productId":@"VARCHAR",
                                       @"productName":@"VARCHAR",
                                       @"productPoint":@"VARCHAR",
                                       @"productPrice":@"VARCHAR",
                                       @"productImage":@"VARCHAR",
                                       @"productNumber":@"VARCHAR",
                                       @"productType":@"VARCHAR"};
            [super createTable:@"CarsList" fieldName:fileName];
        }
    }
    return self;
}

-(BOOL)insertItem:(id)item
{
        /**
         *  判断是否有数据  有就不插入  没有就插入
         */
    @synchronized(self){
        GoodsListModel *newItem = (GoodsListModel *)item;
        [mdataBase open];
        if ([item isKindOfClass:[GoodsListModel class]]) {
            
            NSString *sql01 = [NSString stringWithFormat:@"SELECT * FROM CarsList WHERE productId='%@'",newItem.GoodsId];
            FMResultSet *rs01 = [mdataBase executeQuery:sql01];
            if ([rs01 next])
            {
                return NO;
            }
            else
            {
                NSString *sql02 = [NSString stringWithFormat:@"INSERT INTO CarsList (productId,productName,productPoint,productPrice,productImage,productNumber,productType) VALUES (?,?,?,?,?,?,?)"];
                BOOL success = [mdataBase executeUpdate:sql02,newItem.GoodsId,newItem.chmc,newItem.cklsj,newItem.tlscj,newItem.tpmc,newItem.GoodsNumber,newItem.Type];
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

-(NSMutableArray *)readTableName:(NSString *)tableName
{
    @synchronized(self){
        NSString *sql = nil;
        if ([tableName isEqualToString:@"CarsList"]) {
            sql = [NSString stringWithFormat:@"SELECT productId,productName,productPoint,productPrice,productImage,productNumber,productType FROM %@",tableName];
        }
        if (sql) {
            [mdataBase open];
            FMResultSet *rs = [mdataBase executeQuery:sql];
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            while ([rs next]) {
                GoodsListModel *item = [[GoodsListModel alloc]init];
                item.GoodsId = [rs stringForColumn:@"productId"];
                item.chmc = [rs stringForColumn:@"productName"];
                item.cklsj = [rs stringForColumn:@"productPoint"];
                item.tlscj = [rs stringForColumn:@"productPrice"];
                item.tpmc = [rs stringForColumn:@"productImage"];
                item.GoodsNumber = [rs stringForColumn:@"productNumber"];
                item.Type = [rs stringForColumn:@"productType"];
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
-(void)updateItem:(id)item andProNumber:(NSString *)num
{
    @synchronized(self){
        [mdataBase open];
        if ([item isKindOfClass:[GoodsListModel class]]) {
            GoodsListModel *model =(GoodsListModel *)item;
            NSString *sql = [NSString stringWithFormat:@"update CarsList set productNumber='%@' where productId='%@'",num,model.GoodsId];
            BOOL success = [mdataBase executeUpdate:sql];
            if (!success) {
                NSLog(@"更新失败");
            }
        }
        [self closeDB];
    }
}
/**
 *  删除数据
 */

-(void)deleteTableProductId:(id)item
{
    @synchronized(self){
    [mdataBase open];
        if ([item isKindOfClass:[GoodsListModel class]]) {
            GoodsListModel *model =(GoodsListModel *)item;
            NSString *sql = [NSString stringWithFormat:@"delete from CarsList where productId='%@'",model.GoodsId];
            BOOL success = [mdataBase executeUpdate:sql];
            if (!success) {
                NSLog(@"删除失败");
            }
        }
        [self closeDB];
    }
}
@end
