//
//  RoastAppFeedViewController.m
//  Roast
//
//  Created by Alexander Kissinger on 1/24/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppFeedViewController.h"
#import "RoastAppFeedDetailViewController.h"
#import "RoastAppFeedItem.h"
#import "RoastAppFeedProfile.h"
#import "RoastAppFeedService.h"
#import "STTwitter.h"
#import "TransitionDelegate.h"

@interface RoastAppFeedViewController ()

@property (nonatomic, strong) TransitionDelegate *transitionController;

@end

@implementation RoastAppFeedViewController
@synthesize transitionController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.feedItems = [[NSMutableArray alloc] init];
    
    //TODO: Read from file
    RoastAppFeedProfile *feedProfile = [[RoastAppFeedProfile alloc] init];
    NSMutableArray *userFollowing = [[NSMutableArray alloc] init];
    NSMutableArray *tagFollowing = [[NSMutableArray alloc] init];
    
    [userFollowing addObject:@"birdrockcoffee"];
    [userFollowing addObject:@"candtcollective"];
    [userFollowing addObject:@"roastcoachsd"];
    [userFollowing addObject:@"younghickorysd"];
    [userFollowing addObject:@"SDCoffeeNetwork"];
    [userFollowing addObject:@"CaffeCalabria"];
    
    //adding tags for instagram
    [tagFollowing addObject:@"candtcollective"];
    [tagFollowing addObject:@"younghickorysd"];
    //[tagFollowing addObject:@"birdrockcoffeeroasters"];
    
    [feedProfile setTags:tagFollowing];
    [feedProfile setUsers:userFollowing];
    //[feedProfile.users addObject:[NSString @"coffee"]];
    [feedProfile setEnableFacebook:YES];
    [feedProfile setEnableInstagram:YES];
    [feedProfile setEnableTwitter:YES];
    
    self.feedService = [[RoastAppFeedService alloc] initWithProfile:feedProfile];
    
    //Start Query
    [self.feedService populateFeed:self.feedItems withTableView:self.tableView];
    self.feedDateFormat = @"EEE h:mm a MM.dd";
    
    [self.tableView reloadData];
    
    NSLog(@"feedItems Initialized!");
    NSLog(@"Current feedItems size:%u", [self.feedItems count]);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadList:)
                                                 name:@"TestNotification"
                                               object:nil];
    
    //Refresh on pull-down
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.feedViewTable addSubview:self.refreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.feedItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FeedItemCell";

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    // Configure the cell...
    RoastAppFeedItem *feedItemAtIndex = [self.feedItems objectAtIndex:indexPath.row];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:self.feedDateFormat];
     

    if ( [feedItemAtIndex.serviceName isEqualToString:@"Twitter"] || [feedItemAtIndex.serviceName isEqualToString:@"Facebook"])
    {
        [(UILabel *)[cell.contentView viewWithTag:12] setHidden:NO];
        [(UILabel *)[cell.contentView viewWithTag:12] setText:feedItemAtIndex.message];
        [(UIImageView *)[cell.contentView viewWithTag:15] setHidden:YES];
    }
    else
    {
        [(UIImageView *)[cell.contentView viewWithTag:15] setHidden:NO];
        [(UIImageView *)[cell.contentView viewWithTag:15] setImage:feedItemAtIndex.photo];
    }

 
    [(UILabel *)[cell.contentView viewWithTag:10] setText:feedItemAtIndex.userName];
    [(UIImageView *)[cell.contentView viewWithTag:11] setImage:feedItemAtIndex.serviceBadge];
    [(UILabel *)[cell.contentView viewWithTag:12] setText:feedItemAtIndex.message];
    [(UILabel *)[cell.contentView viewWithTag:13] setText:[formatter stringFromDate:feedItemAtIndex.timestamp]];
    [(UIImageView *)[cell.contentView viewWithTag:14] setImage:feedItemAtIndex.userPic];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RoastAppFeedItem *feedItemAtIndex = [self.feedItems objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RoastAppFeedDetailViewController *detailView = [storyboard instantiateViewControllerWithIdentifier:@"FeedDetailViewController"];
    
    UIView *snapshotView = [self.view snapshotViewAfterScreenUpdates:NO];
    [detailView.view addSubview:snapshotView];
    [detailView.view sendSubviewToBack:snapshotView];
    detailView.selectedFeedItem = feedItemAtIndex;
    [self presentViewController:detailView animated:YES completion:Nil];
}

- (void)reloadList:(NSNotificationCenter *)notification
{

    
    [self.feedItems sortUsingComparator:^NSComparisonResult(RoastAppFeedItem *item0, RoastAppFeedItem *item1)
     {
         return [item1.timestamp compare:item0.timestamp];
     }];

    [self.tableView reloadData];
     
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (IBAction)unwindToFeedListView:(UIStoryboardSegue *)unwindSegue
{
}

- (void)refresh:(id)sender
{
    // do your refresh here and reload the tablview
    NSLog(@"RELOADING!");
    
    //Start Query
    self.feedItems = Nil;
    self.feedItems = [[NSMutableArray alloc] init];
    [self.feedService populateFeed:self.feedItems withTableView:self.tableView];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

@end
