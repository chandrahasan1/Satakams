//
//  FTSampleCollectionViewController.m
//  Satakams
//
//  Created by FabNeeraj on 11/2/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import "FTPoemsCollectionViewController.h"
#import "PKRevealController.h"
#import "FTDatabaseWrapper.h"
#import "FTPoem.h"
#import "FTSatakam.h"
#import "FTPoemsVerticalFlowLayout.h"
#import "FTPoemsHoriontalFlowLayout.h"
#import "FTPoemCollectionViewCell.h"

@interface FTPoemsCollectionViewController ()
{
    __strong FTPoemsVerticalFlowLayout *portFlowLayout;
    __strong FTPoemsHoriontalFlowLayout *landFlowLayout;
}
@property(nonatomic, strong) NSArray *poems;
@end

@implementation FTPoemsCollectionViewController
@synthesize poems = mPoems;

- (void)awakeFromNib
{
    portFlowLayout = [[FTPoemsVerticalFlowLayout alloc] init];
    landFlowLayout = [[FTPoemsHoriontalFlowLayout alloc] init];
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    self.collectionView.collectionViewLayout = UIInterfaceOrientationIsPortrait(interfaceOrientation)?portFlowLayout:landFlowLayout;
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        //Changing to landscape
        self.collectionView.collectionViewLayout = landFlowLayout;
        self.collectionView.alwaysBounceVertical = NO;
        self.collectionView.alwaysBounceHorizontal = YES;
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    else {
        //changing to portrait
        self.collectionView.collectionViewLayout = portFlowLayout;
        self.collectionView.alwaysBounceVertical = YES;
        self.collectionView.alwaysBounceHorizontal = NO;
        self.collectionView.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f];
    }
    self.collectionView.bounces = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.collectionView registerClass:[FTPoemCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    
    // Show poems of the first satakam.
    NSArray *satakams = [[FTDatabaseWrapper sharedInstance] allSatakams];
    [self selectedSatakmWithId:[[satakams objectAtIndex:0] satakamId]];
}


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        //Changing to landscape
        self.collectionView.collectionViewLayout = landFlowLayout;
        self.collectionView.alwaysBounceVertical = NO;
        self.collectionView.alwaysBounceHorizontal = NO;
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    else {
        //changing to portrait
        self.collectionView.collectionViewLayout = portFlowLayout;
        self.collectionView.alwaysBounceVertical = YES;
        self.collectionView.alwaysBounceHorizontal = NO;
        self.collectionView.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}


#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return mPoems.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView*)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    // Configure the cell...
    FTPoem *poem = [mPoems objectAtIndex:indexPath.row];
    FTPoemCollectionViewCell *fCell = (FTPoemCollectionViewCell *)cell;
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        fCell.style = kFTCollectionCellTypePort;
    }
    else {
        fCell.style = kFTCollectionCellTypeLand;
    }
    fCell.satakamTitle = [poem verse];
    
    if (indexPath.row == 0) {
        fCell.tableCellType = FabSettingsTableCellTypeFirst;
    }
    else if([mPoems count]-1 == indexPath.row){
        fCell.tableCellType = FabSettingsTableCellTypeLast;
    }
    else
        fCell.tableCellType = FabSettingsTableCellTypeMiddle;
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (void)showLeftView:(id)sender
{
    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController)
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
    }
    else
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    }
}

#pragma mark - Menu Selection Protocol methods

- (void)selectedSatakmWithId:(NSString *)satakamId {
    NSArray *poems = [[FTDatabaseWrapper sharedInstance] allPoemsForSatakamsWithId:satakamId];
    NSMutableArray *tempArray = [NSMutableArray array];
    [tempArray addObjectsFromArray:poems];
    [tempArray addObjectsFromArray:poems];
    [tempArray addObjectsFromArray:poems];
    [tempArray addObjectsFromArray:poems];
    mPoems = [NSArray arrayWithArray:tempArray];
    FTSatakam *satakam = [[FTDatabaseWrapper sharedInstance] getSatakamWithId:satakamId];
    dispatch_async(dispatch_get_main_queue(), ^{
         self.title = satakam.satakamName;
        [self.collectionView reloadData];
    });
}

- (void)selectedFav {
    mPoems = [[NSMutableArray alloc] initWithArray:[[FTDatabaseWrapper sharedInstance] allFavedPoems]];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.title = @"Faved";
        [self.collectionView reloadData];
    });
}

@end
