//
//  FTPoemCollectionViewCell.h
//  Satakams
//
//  Created by FabNeeraj on 11/2/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <UIKit/UIKit.h>

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
