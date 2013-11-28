//
//  FTMenuTableViewCell.h
//  Satakams
//
//  Created by Chandu on 11/28/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTMenuTableViewCell : UITableViewCell {
    UIColor *cellBackgroundColor;
    FabSettingsTableCellType mTableCellType;
}

@property (nonatomic, strong) UIColor *cellBackgroundColor;
@property (nonatomic, unsafe_unretained) FabSettingsTableCellType tableCellType;
@end
