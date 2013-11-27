//
//  FTPoemCollectionViewCell.h
//  Satakams
//
//  Created by FabNeeraj on 11/2/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kFTCollectionCellTypePort = 0,
    kFTCollectionCellTypeLand
} FTCollectionCellType;

typedef enum {
    FabSettingsTableCellTypeNone = 0,
    FabSettingsTableCellTypeMiddle = 1,
    FabSettingsTableCellTypeFirst = 2,
    FabSettingsTableCellTypeLast = 3
}FabSettingsTableCellType;

@interface FTPoemCollectionViewCell : UICollectionViewCell
{
    UIColor *cellBackgroundColor;
    FabSettingsTableCellType mTableCellType;
}
@property (nonatomic, strong)NSString *satakamTitle;
@property (nonatomic, unsafe_unretained) FTCollectionCellType style;
@property (nonatomic, strong) UIColor *cellBackgroundColor;
@property (nonatomic, unsafe_unretained) FabSettingsTableCellType tableCellType;
@end
