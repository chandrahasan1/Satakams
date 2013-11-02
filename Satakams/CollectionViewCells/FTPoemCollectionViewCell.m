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

@synthesize cellText = mCellText;
@synthesize myLabel = mMyLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // TODO:Don't har code.
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
        [self addSubview:self.myLabel];
    }
    return self;
}

- (void)setCellText:(NSString *)cellText
{
    self.myLabel.text = cellText;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
