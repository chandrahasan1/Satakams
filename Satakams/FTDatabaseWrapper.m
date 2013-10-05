//
//  FTDatabaseWrapper.m
//  Satakams
//
//  Created by FabNeeraj on 10/5/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#define DATABASE_FILE_NAME @"ft.satakam.database.sqlite"

#define CREATE_SATAKAMS_TABLE @"CREATE TABLE SATAKAMS(SID int, Name varchar(255), Bio varchar(255) , PRIMARY KEY (SID));"
#define CREATE_POEMS_TABLE @"CREATE TABLE POEMS(PoemsID int, Verse varchar(255), Meaning varchar(255), AudioFile varchar(255), SID int, faved BOOLEAN, FOREIGN KEY (SID) REFERENCES SATAKAMS(SID), PRIMARY KEY (PoemsID));"
#define CREATE_POETS_TABLE @"CREATE TABLE POETS(PoetsID int, Name varchar(255), Bio varchar(255), SID int, FOREIGN KEY (SID) REFERENCES SATAKAMS(SID), PRIMARY KEY (PoetsID));"


#import "FTDatabaseWrapper.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

@interface FTDatabaseWrapper()
@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;
@end

@implementation FTDatabaseWrapper
@synthesize databaseQueue = mDatabaseQueue;

+(FTDatabaseWrapper *)sharedInstance {
    static FTDatabaseWrapper *sharedInstance = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        sharedInstance = [[FTDatabaseWrapper alloc] init];
        
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:[self databaseFilePath]];
        BOOL tableCreated = [self createTables];
        NSLog(@"tableCreated : %d", tableCreated);
        if (!tableCreated) {
            NSLog(@"PROBLEMS!!!!!! Tables not created!!");
        }
        else {
            NSLog(@"Woo!!! Database and tables created successfully.");
        }
    }
    return self;
}

- (FMDatabaseQueue *)databaseQueue {
    return mDatabaseQueue;
}

- (NSString *)databaseFilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *baseDir = [paths objectAtIndex:0];
	NSString *databaseName = DATABASE_FILE_NAME;
	NSLog(@"Path for database : %@", [baseDir stringByAppendingPathComponent:databaseName]);
	return [baseDir stringByAppendingPathComponent:databaseName];
}



#pragma mark - Create table methods.
- (BOOL)createTables {
    __block BOOL success = NO;
    [mDatabaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        success = [db executeUpdate:CREATE_SATAKAMS_TABLE];
        success = [db executeUpdate:CREATE_POEMS_TABLE];
        success = [db executeUpdate:CREATE_POETS_TABLE];
    }];
    return success;
}

@end
