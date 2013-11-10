//
//  FTAudioManager.h
//  Satakams
//
//  Created by Chandu on 10/30/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface FTAudioManager : NSObject<AVAudioPlayerDelegate>
@property (nonatomic, readonly) AVAudioPlayer *audioPlayer;
+(FTAudioManager *)sharedInstance;
@end
