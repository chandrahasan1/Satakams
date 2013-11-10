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
    cell.satakamTitle = [poem verse];
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
    mPoems = [[FTDatabaseWrapper sharedInstance] allFavedPoems];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.title = @"Fav Poems";
        [self.collectionView reloadData];
    });
}

@end
