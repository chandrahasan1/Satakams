//
//  FTPoemCollectionViewCell.m
//  Satakams
//
//  Created by FabNeeraj on 11/2/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import "FTPoemCollectionViewCell.h"

#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
#define HALF_PIXEL_RETINA ((IS_RETINA)?(0.5):(1))
#define GREY_247 [FTPoemCollectionViewCell createRepeatedColor:247]
#define GREY_51 [FTPoemCollectionViewCell createRepeatedColor:51]

@interface FTPoemCollectionViewCell()
{
    FTCollectionCellType mStyle;
    
    __strong UIImageView *mTopSeperatorView;
    __strong UIImageView *mBottomSeperatorView;

}
@property(nonatomic, strong)UILabel *myLabel;
@end

@implementation FTPoemCollectionViewCell

@synthesize satakamTitle = mCellText;
@synthesize myLabel = mMyLabel;
@synthesize style = mStyle;
@synthesize cellBackgroundColor;
@synthesize tableCellType = mTableCellType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // TODO:Don't hard code.
        
        self.cellBackgroundColor = GREY_247;
        
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectOffset(self.bounds, 20, 0)];
        self.myLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.myLabel.font = [UIFont fontWithName:@"Ramaneeya" size:18.0];
        self.myLabel.numberOfLines = 1;
        self.myLabel.textColor = GREY_51;
        self.myLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.myLabel];
        
        
        CGRect topSepFrame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), HALF_PIXEL_RETINA);
        CGRect bottomSepFrame = CGRectMake(0, CGRectGetHeight(self.bounds) - HALF_PIXEL_RETINA, CGRectGetWidth(self.bounds), HALF_PIXEL_RETINA);
        
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

+(UIColor *)createRepeatedColor:(float)val{
    return [UIColor colorWithRed:val/255.0f green:val/255.0f blue:val/255.0f alpha:1.0f];
}

- (void)setSatakamTitle:(NSString *)cellText
{
    self.myLabel.text = cellText;
}

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

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect topSepFrame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), HALF_PIXEL_RETINA);
    CGRect bottomSepFrame = CGRectMake(0, CGRectGetHeight(self.bounds) - HALF_PIXEL_RETINA, CGRectGetWidth(self.bounds), HALF_PIXEL_RETINA);
    mTopSeperatorView.frame = topSepFrame;
    mBottomSeperatorView.frame = bottomSepFrame;
    
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        self.myLabel.textAlignment = NSTextAlignmentLeft;
        self.myLabel.numberOfLines = 1;
        self.myLabel.frame = CGRectOffset(self.bounds, 20, 0);
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
    else {
        self.myLabel.textAlignment = NSTextAlignmentCenter;
        self.myLabel.numberOfLines = 0;
        self.myLabel.frame = CGRectOffset(self.bounds, 0, 0);
        mTopSeperatorView.hidden = YES;
        mBottomSeperatorView.hidden = YES;
    }
}

-(void)setStyle:(FTCollectionCellType)type {
    mStyle = type;
    [self setNeedsLayout];
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
