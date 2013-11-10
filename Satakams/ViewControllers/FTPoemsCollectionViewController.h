//
//  FTSampleCollectionViewController.h
//  Satakams
//
//  Created by FabNeeraj on 11/2/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTMenuSelectionProtocol.h"

@interface FTPoemsCollectionViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate, FTMenuSelectionProtocol>
@end
