//
//  FTMenuSelectionProtocol.h
//  Satakams
//
//  Created by FabNeeraj on 11/10/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FTMenuSelectionProtocol <NSObject>
@required
- (void)selectedSatakmWithId:(NSString *)satakamId;
- (void)selectedFav;
@end
