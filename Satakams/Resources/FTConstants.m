//
//  FTConstants.m
//  Satakams
//
//  Created by Chandu on 11/28/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import "FTConstants.h"

@implementation FTConstants

+(UIColor *)createRepeatedColor:(float)val{
    return [UIColor colorWithRed:val/255.0f green:val/255.0f blue:val/255.0f alpha:1.0f];
}

+(id)valueForInfoPlistKey:(NSString *)key {
    if (!key) {
        return nil;
    }
    NSBundle *mainBundle = [NSBundle mainBundle];
    return [mainBundle objectForInfoDictionaryKey:key];
}

@end
