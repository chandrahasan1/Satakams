//
//  FTPoemDetailViewController.h
//  Satakams
//
//  Created by Chandu on 11/29/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTPoemDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *verseLabel;
@property (weak, nonatomic) IBOutlet UIView *audioCommander;

@property (copy, nonatomic) NSIndexPath *currentIndexPath;
@property (strong, nonatomic) NSArray *satakaPoems;
@end
