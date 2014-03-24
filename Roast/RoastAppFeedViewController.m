//
//  RoastAppFeedViewController.m
//  Roast
//
//  Created by Alexander Kissinger on 1/24/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppFeedViewController.h"
#import "RoastAppFeedDetailViewController.h"
#import "RoastAppHomeScreenTabViewController.h"
#import "RoastAppFeedItem.h"
#import "RoastAppFeedProfile.h"
#import "RoastAppFeedService.h"
#import "RoastAppTwitterFeedService.h"
#import "RoastAppFacebookFeedService.h"
#import "RoastAppInstagramFeedService.h"
#import "STTwitter.h"
#import "TransitionDelegate.h"

@interface RoastAppFeedViewController ()

@property (nonatomic, strong) TransitionDelegate *transitionController;

@end

@implementation RoastAppFeedViewController
@synthesize transitionController;
NSString * const DATE_FORMAT = @"EEE h:mm a MM.dd";


- (id)init:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.feedItems = [[NSMutableArray alloc] init];
    
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
    [tagFollowing addObject:@"birdrockcoffeeroasters"];
    
    [feedProfile setTags:tagFollowing];
    [feedProfile setUsers:userFollowing];
    [feedProfile setEnableFacebook:YES];
    [feedProfile setEnableInstagram:YES];
    [feedProfile setEnableTwitter:YES];
    
    self.feedServices = [NSMutableArray arrayWithObjects:
                         [[RoastAppTwitterFeedService alloc] initWithProfile:feedProfile],
                         [[RoastAppFacebookFeedService alloc] initWithProfile:feedProfile],
                         [[RoastAppInstagramFeedService alloc] initWithProfile:feedProfile],
                         nil];
    
    //Start Query
    for (RoastAppFeedService *currentService in self.feedServices)
    {
        [currentService retrieveNewFeeds];
    }
    
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadList:)
                                                 name:@"IncomingFeedItem"
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
    formatter.dateFormat = DATE_FORMAT;
    

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
    
    cell.contentView.backgroundColor = self.tabBarController.tabBar.barTintColor;

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

- (void)reloadList:(NSNotification *)notification
{
    /* Sorted Insertion */
    NSUInteger index =
    [self.feedItems indexOfObject:notification.object
                    inSortedRange:(NSRange){0, [self.feedItems count]}
                    options:NSBinarySearchingInsertionIndex
                    usingComparator: ^NSComparisonResult(RoastAppFeedItem *item0, RoastAppFeedItem *item1)
    {
        return [item1.timestamp compare:item0.timestamp];
    }];
    
    [self.feedItems insertObject:notification.object atIndex:index];
    [self.tableView reloadData];
    
    //If refresh wheel is spinning, end it
    [self.refreshControl endRefreshing];
     
}

- (IBAction)swipeLeft:(id)sender
{
    RoastAppHomeScreenTabViewController *tmp = ((RoastAppHomeScreenTabViewController *)self.tabBarController);
    
    [UIView transitionFromView:[self view]
                        toView:[tmp.profileTabBarArray[0] view]
                      duration:0.25
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:nil];
    
    [self.tabBarController setViewControllers:tmp.profileTabBarArray];
}

- (IBAction)SwipeRight:(id)sender
{
    RoastAppHomeScreenTabViewController *tmp = ((RoastAppHomeScreenTabViewController *)self.tabBarController);
    
    [UIView transitionFromView:[self view]
                        toView:[tmp.shopListTabBarArray[0] view]
                      duration:0.25
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:nil];
    
    [self.tabBarController setViewControllers:tmp.shopListTabBarArray];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)unwindToFeedListView:(UIStoryboardSegue *)unwindSegue
{
}

- (void)refresh:(id)sender
{
    /* Clear Table Data and retrieve new feeds */
    self.feedItems = [[NSMutableArray alloc] init];
    for (RoastAppFeedService *currentService in self.feedServices)
    {
        [currentService retrieveNewFeeds];
    }
}

@end
