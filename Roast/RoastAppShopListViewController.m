//
//  RoastAppShowListViewController.m
//  Roast
//
//  Created by Alexander Kissinger on 2/4/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppShopListViewController.h"
#import "RoastAppShopViewController.h"
#import "RoastAppFeedViewController.h"
#import "RoastAppHomeScreenTabViewController.h"

@interface RoastAppShopListViewController ()

@end

@implementation RoastAppShopListViewController

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
    
    //Images should be 550x225
    self.shopImages = [[NSMutableArray alloc] init];
    [self.shopImages addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                                [UIImage imageNamed:@"birdrock.png"], @"image",
                                @"Bird Rock Coffee Roasters", @"name",
                                Nil]];
    [self.shopImages addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                                [UIImage imageNamed:@"coffeeandteacollective.jpg"], @"image",
                                @"Coffee & Tea Collective", @"name",
                                Nil]];
    [self.shopImages addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                                [UIImage imageNamed:@"caffecalabria.jpg"], @"image",
                                @"Caffe Calabria", @"name",
                                Nil]];
    [self.shopImages addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                                [UIImage imageNamed:@"cafemoto.png"], @"image",
                                @"Cafe Moto", @"name",
                                Nil]];
    
    self.tableView.backgroundColor = self.tabBarController.tabBar.barTintColor;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Pass the name of the selected shop to the next view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    RoastAppShopViewController *shopCtrlr = [segue destinationViewController];
    
    shopCtrlr.shopChoice = [self selectedShop];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSDictionary *shopAtIndex = [self.shopImages objectAtIndex:indexPath.row];
    
    self.selectedShop = shopAtIndex[@"name"];
    
    [self performSegueWithIdentifier:@"shopSegue" sender:cell];
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
    return [self.shopImages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShopListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *shopAtIndex = [self.shopImages objectAtIndex:indexPath.row];
    
    [(UILabel *)[cell.contentView viewWithTag:11] setText:shopAtIndex[@"name"]];
    [(UIImageView *)[cell.contentView viewWithTag:10] setImage:shopAtIndex[@"image"]];

    return cell;
}

- (IBAction)SwipeLeft:(id)sender {
    RoastAppHomeScreenTabViewController *tmp = ((RoastAppHomeScreenTabViewController *)self.tabBarController);
    
    [UIView transitionFromView:[self view]
     toView:[tmp.feedTabBarArray[0] view]
     duration:0.25
     options:UIViewAnimationOptionTransitionFlipFromRight
     completion:nil];
    
    [self.tabBarController setViewControllers:tmp.feedTabBarArray];
}
- (IBAction)swipeRight:(id)sender {
    RoastAppHomeScreenTabViewController *tmp = ((RoastAppHomeScreenTabViewController *)self.tabBarController);
    
    [UIView transitionFromView:[self view]
                        toView:[tmp.profileTabBarArray[0] view]
                      duration:0.25
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:nil];
    
    [self.tabBarController setViewControllers:tmp.profileTabBarArray];
}

@end
