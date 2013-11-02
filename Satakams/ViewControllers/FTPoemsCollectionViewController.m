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
#import "FTPoemCollectionViewCell.h"

@interface FTPoemsCollectionViewController ()
@property(nonatomic, strong) NSArray *poems;
@end

@implementation FTPoemsCollectionViewController

@synthesize cellPrefix = mCellPrefix;
@synthesize poems = mPoems;

- (id)init
{
    FTPoemsVerticalFlowLayout *flowLayout = [[FTPoemsVerticalFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:flowLayout];
    if (self) {
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.alwaysBounceVertical = YES;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.collectionView registerClass:[FTPoemCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    if ([[FTDatabaseWrapper sharedInstance] allSatakams]) {
        self.cellPrefix = 1;
    }
    else {
        self.cellPrefix = -1;
        mPoems = nil;
    }
    UIImage *revealImagePortrait = [UIImage imageNamed:@"reveal_menu_icon_portrait"];
    UIImage *revealImageLandscape = [UIImage imageNamed:@"reveal_menu_icon_landscape"];
    // TODO: Check why navigationController is nil.
//    if (self.navigationController.revealController.type & PKRevealControllerTypeLeft)
//    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:revealImagePortrait landscapeImagePhone:revealImageLandscape style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
//    }
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return mPoems.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView*)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FTPoemCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    // Configure the cell...
    FTPoem *poem = [mPoems objectAtIndex:indexPath.row];
    cell.cellText = [poem verse];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Setters
- (void)setCellPrefix:(int)prefix {
    mCellPrefix = prefix;
    if (mCellPrefix > 0) {
        //For Normal Satakams
        mPoems = [[FTDatabaseWrapper sharedInstance] allPoemsForSatakamsWithId:[NSString stringWithFormat:@"%d",mCellPrefix]];
        FTSatakam *satakam = [[FTDatabaseWrapper sharedInstance] getSatakamWithId:[NSString stringWithFormat:@"%d",mCellPrefix]];
        self.title = satakam.satakamName;
    }
    else {
        mPoems = [[NSMutableArray alloc] initWithArray:[[FTDatabaseWrapper sharedInstance] allFavedPoems]];
        self.title = @"Fav Poems";
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
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


@end
