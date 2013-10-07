//
//  FTPoem.h
//  Satakams
//
//  Created by Chandu on 10/7/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTPoem : NSObject
{
    NSString *mPoemId;
    NSString *mVerse;
    NSString *mMeaning;
    NSString *mAudioFile;
    NSString *mSatakamId;
}
@property (nonatomic, strong) NSString *poemId;
@property (nonatomic, strong) NSString *verse;
@property (nonatomic, strong) NSString *meaning;
@property (nonatomic, strong) NSString *audioFile;
@property (nonatomic, strong) NSString *satakamId;
@property (nonatomic, unsafe_unretained) BOOL faved;
@end
