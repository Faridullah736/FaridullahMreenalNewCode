//
//  DBManager.h
//  IslamicQuize
//
//  Created by Zavi RBS on 06/11/2013.
//  Copyright (c) 2013 TechnoStairs. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <sqlite3.h>

@interface DBManager : NSObject
{
   
}

@property (nonatomic,strong) NSString *databaseName;
@property (nonatomic,strong) NSString *databasePath;
+(DBManager*)getSharedInstance;
-(void) initializeDB;
-(void) createAndCheckDatabase;
-(BOOL) insertPointData:(NSString *) pro_name pro_price:(NSString *)pro_price pro_size:(NSString*)pro_size pro_quantity:(NSString *)pro_quantity pro_image:(NSString *)pro_image;
- (NSMutableArray*) allProudcts;
-(BOOL) deleteProductRecord:(NSString *)proId;
@end
