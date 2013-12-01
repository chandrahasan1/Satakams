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
- (id)getSatakamWithId:(NSString *)satakamId;
/**
 *  If forced is 'YES' then it will replace the file in user documents with the one in bundle and set latest version (available in info.plist)
 *  in user defaults.
 *  If forced is 'NO' it will replace the file in user documents with bundle file only if file doesn't exist in documents or there is a version
 *  mismatch.
 */
- (void)resetDatabaseFileForced:(BOOL)forced;
@end
