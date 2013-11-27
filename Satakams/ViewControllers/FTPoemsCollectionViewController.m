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

- (id)init
{
    portFlowLayout = [[FTPoemsVerticalFlowLayout alloc] init];
    landFlowLayout = [[FTPoemsHoriontalFlowLayout alloc] init];
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    self = [super initWithCollectionViewLayout:UIInterfaceOrientationIsPortrait(interfaceOrientation)?portFlowLayout:landFlowLayout];
    if (self) {
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            //Changing to landscape
            self.collectionView.collectionViewLayout = landFlowLayout;
            self.collectionView.alwaysBounceVertical = NO;
            self.collectionView.alwaysBounceHorizontal = YES;
        }
        else {
            //changing to portrait
            self.collectionView.collectionViewLayout = portFlowLayout;
            self.collectionView.alwaysBounceVertical = YES;
            self.collectionView.alwaysBounceHorizontal = NO;
        }
        self.collectionView.bounces = YES;
        self.collectionView.showsHorizontalScrollIndicator = NO;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.collectionView registerClass:[FTPoemCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    UIImage *revealImagePortrait = [UIImage imageNamed:@"reveal_menu_icon_portrait"];
    UIImage *revealImageLandscape = [UIImage imageNamed:@"reveal_menu_icon_landscape"];
    // TODO: Check why navigationController is nil.
//    if (self.navigationController.revealController.type & PKRevealControllerTypeLeft)
//    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:revealImagePortrait landscapeImagePhone:revealImageLandscape style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
//    }
    
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
    }
    else {
        //changing to portrait
        self.collectionView.collectionViewLayout = portFlowLayout;
        self.collectionView.alwaysBounceVertical = YES;
        self.collectionView.alwaysBounceHorizontal = NO;
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
    cell.backgroundColor = [UIColor clearColor];
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
    mPoems = [[FTDatabaseWrapper sharedInstance] allPoemsForSatakamsWithId:satakamId];
    FTSatakam *satakam = [[FTDatabaseWrapper sharedInstance] getSatakamWithId:satakamId];
    dispatch_async(dispatch_get_main_queue(), ^{
         self.title = satakam.satakamName;
        [self.collectionView reloadData];
    });
}

- (void)selectedFav {
    mPoems = [[NSMutableArray alloc] initWithArray:[[FTDatabaseWrapper sharedInstance] allFavedPoems]];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.title = @"Fav Poems";
        [self.collectionView reloadData];
    });
}

@end
