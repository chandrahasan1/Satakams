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

@interface FTDatabaseWrapper : NSObject
+(FTDatabaseWrapper *)sharedInstance;
- (FMDatabaseQueue *)databaseQueue;
@end
