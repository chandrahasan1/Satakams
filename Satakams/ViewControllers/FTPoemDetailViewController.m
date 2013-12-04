//
//  FTPoemDetailViewController.m
//  Satakams
//
//  Created by Chandu on 11/29/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import "FTPoemDetailViewController.h"
#import "FTDatabaseWrapper.h"
#import "FTPoem.h"
#import "FTSatakam.h"

@interface FTPoemDetailViewController ()
{
    __strong NSArray *mSatakaPoems;
}
@end

@implementation FTPoemDetailViewController
@synthesize currentIndexPath;
@synthesize satakaPoems = mSatakaPoems;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib {
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f];
    self.verseLabel.font = [UIFont fontWithName:@"Ramaneeya" size:14.0];
    self.verseLabel.numberOfLines = 0;
    self.verseLabel.textColor = GREY_51;
    self.verseLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotate {
    return NO;
}


#pragma mark -

-(void)setSatakaPoems:(NSArray *)poems {
    mSatakaPoems = poems;
    if (poems.count > self.currentIndexPath.row) {
        FTPoem *currentPoem = [self.satakaPoems objectAtIndex:self.currentIndexPath.row];
        [self.verseLabel setText:currentPoem.verse];
    }
}
@end
