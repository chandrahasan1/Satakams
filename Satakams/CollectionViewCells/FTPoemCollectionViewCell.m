//
//  FTPoemCollectionViewCell.m
//  Satakams
//
//  Created by FabNeeraj on 11/2/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import "FTPoemCollectionViewCell.h"

@interface FTPoemCollectionViewCell()
@property(nonatomic, strong)UILabel *myLabel;
@end

@implementation FTPoemCollectionViewCell

@synthesize satakamTitle = mCellText;
@synthesize myLabel = mMyLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // TODO:Don't hard code.
        self.myLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.myLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.myLabel.font = [UIFont fontWithName:@"Ramaneeya" size:18.0];
        self.myLabel.numberOfLines = 0;
        self.myLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.myLabel];
    }
    return self;
}

- (void)setSatakamTitle:(NSString *)cellText
{
    self.myLabel.text = cellText;
}

@end
