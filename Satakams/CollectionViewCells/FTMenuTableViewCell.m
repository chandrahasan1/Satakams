//
//  FTMenuTableViewCell.m
//  Satakams
//
//  Created by Chandu on 11/28/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import "FTMenuTableViewCell.h"

@interface FTMenuTableViewCell ()
{
    __strong UIImageView *mTopSeperatorView;
    __strong UIImageView *mBottomSeperatorView;
}
@end

@implementation FTMenuTableViewCell
@synthesize cellBackgroundColor;
@synthesize tableCellType = mTableCellType;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.cellBackgroundColor = GREY_247;
        
        UIView *selectedView = [[UIView alloc] initWithFrame:self.bounds];
        selectedView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        selectedView.backgroundColor = self.cellBackgroundColor;

        CGRect topSepFrame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), HALF_PIXEL_RETINA);
        CGRect bottomSepFrame = CGRectMake(0, CGRectGetHeight(self.bounds) - HALF_PIXEL_RETINA, CGRectGetWidth(self.bounds), HALF_PIXEL_RETINA);

        UIImageView *imgView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, .5, CGRectGetWidth(self.bounds), HALF_PIXEL_RETINA)];
        imgView.contentMode = UIViewContentModeScaleToFill;
        imgView.backgroundColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
        [selectedView addSubview:imgView];
        
        UIImageView *imgViewBott  = [[UIImageView alloc] initWithFrame:bottomSepFrame];
        imgViewBott.contentMode = UIViewContentModeScaleToFill;
        imgViewBott.backgroundColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
        [selectedView addSubview:imgViewBott];
        
        self.selectedBackgroundView = selectedView;

        
        
        mTopSeperatorView = [[UIImageView alloc] initWithFrame:topSepFrame];
        mTopSeperatorView.contentMode = UIViewContentModeScaleToFill;
        mTopSeperatorView.backgroundColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
        [self addSubview:mTopSeperatorView];
        
        mBottomSeperatorView = [[UIImageView alloc] initWithFrame:bottomSepFrame];
        mBottomSeperatorView.contentMode = UIViewContentModeScaleToFill;
        mBottomSeperatorView.backgroundColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
        [self addSubview:mBottomSeperatorView];
    }
    return self;
}

#pragma mark -

-(void)layoutSubviews {
    
    [super layoutSubviews];
    CGRect topSepFrame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), HALF_PIXEL_RETINA);
    CGRect bottomSepFrame = CGRectMake(0, CGRectGetHeight(self.bounds) - HALF_PIXEL_RETINA, CGRectGetWidth(self.bounds), HALF_PIXEL_RETINA);

    [self bringSubviewToFront:mTopSeperatorView];
    [self bringSubviewToFront:mBottomSeperatorView];
    mTopSeperatorView.frame = topSepFrame;
    mBottomSeperatorView.frame = bottomSepFrame;
}

#pragma mark -

- (void)setTableCellType:(FabSettingsTableCellType)tablecellType {
    if (mTableCellType != tablecellType) {
        mTableCellType = tablecellType;
        [self bringSubviewToFront:mTopSeperatorView];
        [self bringSubviewToFront:mBottomSeperatorView];
        switch (mTableCellType) {
            case FabSettingsTableCellTypeMiddle:
            {
                mTopSeperatorView.hidden = YES;
                mBottomSeperatorView.hidden = NO;
            }
                break;
            case FabSettingsTableCellTypeFirst:
            {
                mTopSeperatorView.hidden = NO;
                mBottomSeperatorView.hidden = NO;
            }
                break;
            case FabSettingsTableCellTypeLast:
            {
                mTopSeperatorView.hidden = YES;
                mBottomSeperatorView.hidden = NO;
            }
                break;
            default:
            {
                mTopSeperatorView.hidden = YES;
                mBottomSeperatorView.hidden = YES;
            }
                break;
        }
    }
}

#pragma mark -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = self.cellBackgroundColor;
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = self.cellBackgroundColor;
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = [UIColor whiteColor];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = [UIColor whiteColor];
    [super touchesCancelled:touches withEvent:event];
}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    self.tableCellType = FabSettingsTableCellTypeNone;
}

-(void)dealloc{
    self.cellBackgroundColor = nil;
}
@end
