//
//  FTDatabaseWrapper.m
//  Satakams
//
//  Created by FabNeeraj on 10/5/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#define DATABASE_FILE_NAME @"ft.satakam.database.sqlite"

#define CREATE_SATAKAMS_TABLE @"CREATE TABLE IF NOT EXISTS SATAKAMS(SID int, Name varchar(255), Bio varchar(255) , PRIMARY KEY (SID));"
#define CREATE_POEMS_TABLE @"CREATE TABLE IF NOT EXISTS POEMS(PoemsID int, Verse varchar(255), Meaning varchar(255), AudioFile varchar(255), SID int, faved BOOLEAN, FOREIGN KEY (SID) REFERENCES SATAKAMS(SID), PRIMARY KEY (PoemsID));"
#define CREATE_POETS_TABLE @"CREATE TABLE IF NOT EXISTS POETS(PoetsID int, Name varchar(255), Bio varchar(255), SID int, FOREIGN KEY (SID) REFERENCES SATAKAMS(SID), PRIMARY KEY (PoetsID));"


// Select Queries.
#define GET_ALL_SATAKAMS @"SELECT * FROM SATAKAMS;"
#define GET_ALL_POEMS_FOR_SATKAM_ID @"SELECT * FROM POEMS WHERE SID=%d;"
#define POET_FOR_SATAKAM_WITH_ID @"SELECT * FROM POETS WHERE SID=%d;"
#define FAVED_POEMS @"SELECT * FROM POEMS WHERE faved=%d GROUP BY SID;"
#define FAV_POEM_WITH_ID @"UPDATE POEMS SET faved=%d WHERE PoemsID=%d"

#import "FTDatabaseWrapper.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "FTSatakam.h"
#import "FTPoem.h"
#import "FTPoet.h"

/*
 
 //DB insert sample sql statements
 
 INSERT INTO SATAKAMS(SID, Name, Bio) VALUES(3,'Satakam 3','This is third Satakam I say');
 
 INSERT INTO POEMS(PoemsID, Verse, Meaning, AudioFile, SID, faved) VALUES (5,'This is the fifth of first', 'Stupid Meaning', '',1,0);
 
 INSERT INTO POETS(PoetsID, Name, Bio, SID) VALUES (1, 'Poet1', 'Stupid Bio', 1);
 
*/


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
        [self resetDatabaseFileForced:NO];
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

- (void)resetDatabaseFileForced:(BOOL)forced {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *databaseFilePath = [self databaseFilePath];
    if (!forced) {
        BOOL fileExists = [fileManager fileExistsAtPath:databaseFilePath];
        if (fileExists) {
            NSLog(@"Database file already there not creating it.");
            return;
        }
    }
    // Get the path to the database in the application package.
    // TODO: Don't hard code the name of the file.
    NSString *databasePathFromApp = [[NSBundle mainBundle] pathForResource:@"ft.satakam.database" ofType:@"sqlite"];
    
    // Copy the database from the package to the users filesystem
    NSError *err = nil;
    [[NSFileManager defaultManager] copyItemAtPath:databasePathFromApp toPath:databaseFilePath error:&err];
    if (!err) {
        NSLog(@"Database file successfully copied.");
    }
    else {
        NSLog(@"Database file copy failed with error description : %@", [err localizedDescription]);
    }
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

- (BOOL)setFav:(BOOL)fav forPoemwithPoemId:(NSString *)poemId {
    __block BOOL success = NO;
    [mDatabaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        success = [db executeUpdateWithFormat:FAV_POEM_WITH_ID, fav,[poemId intValue]];
        NSLog(@"%@", [db lastError]);
    }];
    return success;
}


#pragma mark- Select data methods.
- (NSArray *)allSatakams {
    __block NSMutableArray *satakamsArray = [[NSMutableArray alloc] init];
    [mDatabaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *resultSet = [db executeQuery:GET_ALL_SATAKAMS];
        while ([resultSet next]) {
            int satakamId = [resultSet intForColumn:@"SID"];
            NSString *satakamName = [resultSet stringForColumn:@"Name"];
            NSString *satakamBio = [resultSet stringForColumn:@"Bio"];
            FTSatakam *satakam = [[FTSatakam alloc] init];
            satakam.satakamId = [NSString stringWithFormat:@"%d", satakamId];
            satakam.satakamName = satakamName;
            satakam.satakamBio = satakamBio;
            [satakamsArray addObject:satakam];
        }
    }];
    return satakamsArray;
}

- (NSArray *)allPoemsForSatakamsWithId:(NSString *)satakamId {
     __block NSMutableArray *poemsArray = [[NSMutableArray alloc] init];
    [mDatabaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *resultSet = [db executeQueryWithFormat:GET_ALL_POEMS_FOR_SATKAM_ID, [satakamId integerValue]];
        while ([resultSet next]) {
            FTPoem *poem = [[FTPoem alloc] init];
            poem.poemId = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"PoemsID"]];
            poem.verse = [resultSet stringForColumn:@"Verse"];
            poem.meaning = [resultSet stringForColumn:@"Meaning"];
            poem.audioFile = [resultSet stringForColumn:@"AudioFile"];
            poem.satakamId = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"SID"]];
            poem.faved = [resultSet boolForColumn:@"faved"];
            [poemsArray addObject:poem];
        }
    }];
    return poemsArray;
}

- (FTPoet *)poetForSatakamWithId:(NSString *)satakamId {
    __block FTPoet *poet = [[FTPoet alloc] init];
    [mDatabaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
    FMResultSet *resultSet = [db executeQueryWithFormat:POET_FOR_SATAKAM_WITH_ID, [satakamId integerValue]];
    while ([resultSet next]) {
        poet.poetId = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"PoetsID"]];
        poet.poetName = [resultSet stringForColumn:@"Name"];
        poet.poetBio = [resultSet stringForColumn:@"Bio"];
        poet.satakamId = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"SID"]];
    }
    }];
    return poet;
}

- (NSArray *)allFavedPoems {
    __block NSMutableArray *favedPoems = [[NSMutableArray alloc] init];
    [mDatabaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *resultSet = [db executeQueryWithFormat:FAVED_POEMS, 1];
        while ([resultSet next]) {
            FTPoem *poem = [[FTPoem alloc] init];
            poem.poemId = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"PoemsID"]];
            poem.verse = [resultSet stringForColumn:@"Verse"];
            poem.meaning = [resultSet stringForColumn:@"Meaning"];
            poem.audioFile = [resultSet stringForColumn:@"AudioFile"];
            poem.satakamId = [NSString stringWithFormat:@"%d", [resultSet intForColumn:@"SID"]];
            poem.faved = [resultSet boolForColumn:@"faved"];
        }
    }];
    return favedPoems;
}
@end
