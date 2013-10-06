//
//  FTAppDelegate.h
//  Satakams
//
//  Created by Chandu on 10/3/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <UIKit/UIKit.h>


@class PKRevealController;

@interface FTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) PKRevealController *revealController;
@end
