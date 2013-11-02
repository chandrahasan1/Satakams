//
//  FTAudioManager.m
//  Satakams
//
//  Created by Chandu on 10/30/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import "FTAudioManager.h"
#import <AudioToolbox/AudioSession.h>
@interface FTAudioManager ()
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation FTAudioManager
+(FTAudioManager *)sharedInstance {
    static FTAudioManager *sharedInstance = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        sharedInstance = [[FTAudioManager alloc] init];
        
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.audioPlayer = nil;
    }
    return self;
}

- (BOOL)prepareAudioPlayerToPlayFile:(NSString *)fileName {
    BOOL isPrepared = NO;
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    NSURL *newURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    //self.soundFileURL = newURL;
    [[AVAudioSession sharedInstance] setDelegate: self];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: nil];
    
    // Registers the audio route change listener callback function
//    AudioSessionAddPropertyListener (
//                                     kAudioSessionProperty_AudioRouteChange,
//                                     audioRouteChangeListenerCallback,
//                                     self
//                                     );
    
    // Activates the audio session.
    NSError *activationError = nil;
    [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
    
    NSError *playerActivationError = nil;
    AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: newURL error: &playerActivationError];
    self.audioPlayer = newPlayer;
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer setVolume: 1.0];
    [self.audioPlayer setDelegate: self];
    if (!playerActivationError && !activationError) {
        isPrepared = YES;
    }
    return isPrepared;
}
@end
