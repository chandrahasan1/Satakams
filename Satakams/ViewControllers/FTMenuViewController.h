//
//  FTLeftViewController.h
//  Satakams
//
//  Created by FabNeeraj on 10/4/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuSelectionProtocol <NSObject>
@required
- (void)selectedSatakmWithId:(NSString *)satakamId;
- (void)selectedFav;
@end

@interface FTMenuViewController : UITableViewController
{
    NSArray *mSatakams;
}
@property(nonatomic, weak) id<MenuSelectionProtocol>menuSelectionDelegate;
@end
