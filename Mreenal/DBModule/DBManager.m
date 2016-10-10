//
//  DBManager.m
//  IslamicQuize
//
//  Created by Zavi RBS on 06/11/2013.
//  Copyright (c) 2013 TechnoStairs. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>
static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;
@implementation DBManager
@synthesize databaseName,databasePath; 
+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance initializeDB];
    }
    return sharedInstance;
}
-(void) initializeDB{
    databaseName = @"Mreenal.sqlite";
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentDir stringByAppendingPathComponent:self.databaseName];
    
    [self createAndCheckDatabase];
}
-(void) createAndCheckDatabase
{
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:self.databasePath];
    
    if(success) return;
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:self.databasePath error:nil];
}
-(BOOL) insertPointData:(NSString *) pro_name pro_price:(NSString *)pro_price pro_size:(NSString*)pro_size pro_quantity:(NSString *)pro_quantity pro_image:(NSString *)pro_image;
{
    [self initializeDB];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO product (product_name,product_price,product_size,product_quantity,product_image) VALUES ('%@','%@','%@','%@','%@');",pro_name,pro_price,pro_size,pro_quantity,pro_image,nil];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
        
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}
- (NSMutableArray*) allProudcts
{
    [self initializeDB];
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT product.pro_id,product.product_name,product.product_price,product.product_image,product.product_size,product.product_quantity FROM product"];
        const char *query_stmt = [querySQL UTF8String];
      
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString * proid = ((char *)sqlite3_column_text(statement, 0)) ?
                [NSString stringWithUTF8String:
                 (char *)sqlite3_column_text(statement, 0)] : nil;
                NSString * pro_name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString * pro_price = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString * pro_image = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                NSString * pro_size = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                NSString * pro_quantity = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                [resultArray addObjectsFromArray:[NSArray arrayWithObjects:[NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects: proid, pro_name,pro_price,pro_image,pro_size,pro_quantity, nil]                      forKeys:[NSArray arrayWithObjects:@"proId", @"pro_name",@"pro_price",@"pro_image",@"pro_size",@"pro_qunatity", nil]], nil]];
            }
        }
        else
        {
                NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
            }
  
            sqlite3_reset(statement);
            
        
    }
    return resultArray;
}
-(BOOL) deleteProductRecord:(NSString *)proId
{
    [self initializeDB];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"DELETE FROM product WHERE pro_id=%ld;",(long)[proId integerValue],nil];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

@end
