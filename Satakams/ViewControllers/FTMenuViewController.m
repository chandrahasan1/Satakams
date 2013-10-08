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

@interface FTMenuViewController ()

@end

@implementation FTMenuViewController

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Satakams";
    
    self.clearsSelectionOnViewWillAppear = NO;
 
    mSatakams = [[FTDatabaseWrapper sharedInstance] allSatakams];
    
    [self.tableView registerClass:[UITableViewCell class]forCellReuseIdentifier:@"Cell"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (mSatakams.count) {
       return mSatakams.count + 1; // +1 for Fav poems.
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (mSatakams.count) {
        if (indexPath.row < mSatakams.count) {
            //Satakam row
            FTSatakam *satakam = [mSatakams objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@", satakam.satakamName];
        }
        else {
            //Fav row
            cell.textLabel.text = @"Fav";
        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Not sure about this logic of sending messages between controllers.
    FTAppDelegate *appDelegate = (FTAppDelegate *)[[UIApplication sharedApplication] delegate];
    UINavigationController *nagivationController = (UINavigationController *)appDelegate.revealController.frontViewController;
    FTPoemsViewController *frontViewController = (FTPoemsViewController *)[nagivationController.viewControllers objectAtIndex:0];
    if (indexPath.row < mSatakams.count) {
        FTSatakam *satakam = [mSatakams objectAtIndex:indexPath.row];
        frontViewController.cellPrefix = satakam.satakamId.intValue;
    }
    else {
        //For Fav
        frontViewController.cellPrefix = -1;
    }
    [appDelegate.revealController showViewController:nagivationController];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
