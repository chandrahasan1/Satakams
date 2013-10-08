//
//  FTDatabaseWrapper.h
//  Satakams
//
//  Created by FabNeeraj on 10/5/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

/* Database wrapper.
 * Use databaseQueue to call update and select queies.
 * Three tables gets created - SATAKAMS, POETS , POEMS.
 */
#import <Foundation/Foundation.h>

@class FMDatabaseQueue;
@class FTPoet;

@interface FTDatabaseWrapper : NSObject
+(FTDatabaseWrapper *)sharedInstance;
- (FMDatabaseQueue *)databaseQueue;

- (NSArray *)allSatakams;
- (NSArray *)allPoemsForSatakamsWithId:(NSString *)satakamId;
- (FTPoet *)poetForSatakamWithId:(NSString *)satakamId;
- (NSArray *)allFavedPoems;
- (BOOL)setFav:(BOOL)fav forPoemwithPoemId:(NSString *)poemId;

// If forced is 'NO' then if sqlite file doesn't exist then it will copy file from bundle to user documents. If forced is 'YES'
// then it will copy file from bundle to user documents.
- (void)resetDatabaseFileForced:(BOOL)forced;
@end
