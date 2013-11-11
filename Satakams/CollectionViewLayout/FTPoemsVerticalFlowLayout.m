//
//  FTPoemsVerticalFlowLayout.m
//  Satakams
//
//  Created by FabNeeraj on 11/2/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import "FTPoemsVerticalFlowLayout.h"

@implementation FTPoemsVerticalFlowLayout

- (id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(320, 50);
        self.minimumLineSpacing = 0.0;
        self.minimumInteritemSpacing = 0.0;
        self.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

@end
