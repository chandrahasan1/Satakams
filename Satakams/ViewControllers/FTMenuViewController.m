//
//  FTLeftViewController.m
//  Satakams
//
//  Created by FabNeeraj on 10/4/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import "FTMenuViewController.h"
#import "PKRevealController.h"
#import "FTPoemsViewController.h"
#import "FTAppDelegate.h"
#import "FTDatabaseWrapper.h"
#import "FTSatakam.h"
#import "FTMenuTableViewCell.h"

static NSString *cellIdentifier  = @"CellIdentifier";

@interface FTMenuViewController () {
    BOOL mSelectDefaultRow;
    NSIndexPath *mDefaultSelectedRowIndexPath;
}

@end

@implementation FTMenuViewController

@synthesize menuSelectionDelegate = mMenuSelectionDelegate;

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Satakams";
    self.view.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f];
    self.clearsSelectionOnViewWillAppear = NO;
 
    mSatakams = [[FTDatabaseWrapper sharedInstance] allSatakams];
    
    [self.tableView registerClass:[FTMenuTableViewCell class]forCellReuseIdentifier:cellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Select the first row by default.
    mSelectDefaultRow = YES;
    mDefaultSelectedRowIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (mSelectDefaultRow) {
        mSelectDefaultRow = NO;
        [self.tableView selectRowAtIndexPath:mDefaultSelectedRowIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (mSatakams.count) {
        // +1 for Fav poems.
       return mSatakams.count + 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 20.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 20.0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 20.0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FTMenuTableViewCell *cell = (FTMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (mSatakams.count) {
        if (indexPath.row == 0) {
            cell.tableCellType = FabSettingsTableCellTypeFirst;
        }
        else if([mSatakams count] == indexPath.row){
            cell.tableCellType = FabSettingsTableCellTypeLast;
        }
        else
            cell.tableCellType = FabSettingsTableCellTypeMiddle;

        if (indexPath.row < mSatakams.count) {
            //Satakam row
            FTSatakam *satakam = [mSatakams objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@", satakam.satakamName];
        }
        else {
            //Fav row
            cell.textLabel.text = @"Faved";
        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FTAppDelegate *appDelegate = (FTAppDelegate *)[[UIApplication sharedApplication] delegate];
    UINavigationController *nagivationController = (UINavigationController *)appDelegate.revealController.frontViewController;
    if (indexPath.row < mSatakams.count) {
        FTSatakam *satakam = [mSatakams objectAtIndex:indexPath.row];
        [self.menuSelectionDelegate selectedSatakmWithId:satakam.satakamId];
    }
    else {
        //For Fav
        [self.menuSelectionDelegate selectedFav];
    }
    [appDelegate.revealController showViewController:nagivationController];
}

@end
