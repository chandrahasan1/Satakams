//
//  FTPoet.h
//  Satakams
//
//  Created by Chandu on 10/7/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTPoet : NSObject
{
    NSString *mPoetId;
    NSString *mPoetName;
    NSString *mPoetBio;
    NSString *mSatakamId;
}
@property (nonatomic, strong) NSString *poetId;
@property (nonatomic, strong) NSString *poetName;
@property (nonatomic, strong) NSString *poetBio;
@property (nonatomic, strong) NSString *satakamId;

@end
