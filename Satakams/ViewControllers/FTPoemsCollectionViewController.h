//
//  FTSampleCollectionViewController.h
//  Satakams
//
//  Created by FabNeeraj on 11/2/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTMenuViewController.h"

@interface FTPoemsCollectionViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate, MenuSelectionProtocol>
@property (nonatomic, unsafe_unretained) NSInteger cellPrefix;
@end
