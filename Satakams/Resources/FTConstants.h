//
//  FTConstants.h
//  Satakams
//
//  Created by Chandu on 11/28/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <Foundation/Foundation.h>


// TODO:Before going into production make it 0.
#define LOGGING_ENABLED 1

#if LOGGING_ENABLED
#define debugLog(fmt, ...) do { \
NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__); \
}while(0)
#else
#define debugLog(...)
#endif


#define DATABASE_VERSION_KEY @"DatabaseVersion"
#define DATABASE_FILE_NAME @"ft.satakam.database"


#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
#define HALF_PIXEL_RETINA ((IS_RETINA)?(0.5):(1))
#define GREY_247 [FTConstants createRepeatedColor:247]
#define GREY_51  [FTConstants createRepeatedColor:51]

typedef enum {
    FabSettingsTableCellTypeNone = 0,
    FabSettingsTableCellTypeMiddle = 1,
    FabSettingsTableCellTypeFirst = 2,
    FabSettingsTableCellTypeLast = 3
}FabSettingsTableCellType;

typedef enum {
    kFTCollectionCellTypePort = 0,
    kFTCollectionCellTypeLand
} FTCollectionCellType;


@interface FTConstants : NSObject
+(UIColor *)createRepeatedColor:(float)val;
+(id)valueForInfoPlistKey:(NSString *)key;

@end


