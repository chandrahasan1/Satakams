//
//  FTSatakam.h
//  Satakams
//
//  Created by Chandu on 10/7/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTSatakam : NSObject
{
    NSString *mSatakamId;
    NSString *mSatakamBio;
    NSString *mSatakamName;
}
@property (nonatomic, strong) NSString *satakamId;
@property (nonatomic, strong) NSString *satakamBio;
@property (nonatomic, strong) NSString *satakamName;
@end
