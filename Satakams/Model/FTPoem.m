//
//  FTPoem.m
//  Satakams
//
//  Created by Chandu on 10/7/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import "FTPoem.h"

@implementation FTPoem
@synthesize poemId = mPoemId;
@synthesize verse = mVerse;
@synthesize meaning = mMeaning;
@synthesize audioFile = mAudioFile;
@synthesize satakamId = mSatakamId;
@synthesize faved;

- (id)init {
    
    self = [super init];

    return self;
}
@end
