//
//  RoastAppShopMenuViewController.m
//  Roast
//
//  Created by Nicholas Variz on 2/10/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppShopMenuViewController.h"
#import "RoastAppShopViewController.h"
#import "RoastAppJSONHandler.h"
#import "RoastAppServerImageHandler.h"
#import "RoastAppShopItem.h"
#import "RoastAppMenuItemViewController.h"

@interface RoastAppShopMenuViewController ()

@property NSMutableArray *shopList;
@property RoastAppMenuItemViewController *menuCtrlr;

@end

@implementation RoastAppShopMenuViewController

@synthesize menuChoice;
@synthesize shopChoice;

- (void)loadInitialData
{
    NSInteger requestType = 0;
    
    if([menuChoice isEqualToString:@"drinkMenu"]){
        self.title = @"Drinks";
        requestType = 0;
    }else if([menuChoice isEqualToString:@"foodMenu"]){
        self.title = @"Food";
        requestType = 1;
    }else if([menuChoice isEqualToString:@"gearMenu"]){
        self.title = @"Gear";
        requestType = 2;
    }
    
    NSArray *queryResult = [RoastAppJSONHandler makeJSONRequest:requestType :shopChoice];
    
    if(queryResult != nil){
        
        self.names = [queryResult objectAtIndex:0];
        self.descriptions = [queryResult objectAtIndex:1];
        self.prices = [queryResult objectAtIndex:2];
        self.imgNames = [queryResult objectAtIndex:3];
        self.ids = [queryResult objectAtIndex:4];

        int counter = 0;
        
        for(NSString *string in self.names){
            
            RoastAppShopItem *temp = [[RoastAppShopItem alloc] init];
            temp.name = [self.names objectAtIndex:counter];
            temp.description = [self.descriptions objectAtIndex:counter];
            temp.price = [self.prices objectAtIndex:counter];
            temp.shopImage = [RoastAppServerImageHandler requestCafeImages:[self.imgNames objectAtIndex:counter]];
            temp.uid = [self.ids objectAtIndex:counter];
            [self.shopList addObject:temp];
            counter = counter + 1;
        }
    }
    NSLog(@"shopItems Initialized!");
    
}

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
    self.imgNames = [[NSMutableArray alloc] init];
    self.descriptions = [[NSMutableArray alloc] init];
    self.prices = [[NSMutableArray alloc] init];
    self.names = [[NSMutableArray alloc] init];
    self.shopList = [[NSMutableArray alloc] init];
    self.ids = [[NSMutableArray alloc] init];
    [self loadInitialData];
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
    return [self.shopList count];
}

//Pass the name of the selected shop to the next view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    self.menuCtrlr = [segue destinationViewController];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    RoastAppShopItem *chosenItem = [self.shopList objectAtIndex:indexPath.row];
    
    self.menuCtrlr.item = chosenItem;
    [(UITextView *)[self.menuCtrlr.view viewWithTag:1] setText:[[chosenItem.description stringByAppendingString:@"\n\n"]stringByAppendingString:chosenItem.price]];
    [(UIImageView *)[self.menuCtrlr.view viewWithTag:3] setImage:chosenItem.shopImage];
    self.menuCtrlr.title = chosenItem.name;
    self.menuCtrlr.image = chosenItem.shopImage;
    
    NSArray *reviewsForItem = [RoastAppJSONHandler makeJSONRequest:3 :chosenItem.uid];
    NSArray *userNames = [reviewsForItem objectAtIndex:3];
    NSArray *userRatings = [reviewsForItem objectAtIndex:2];
    NSString *reviewString = @"";
    NSInteger averageReview = 0;
    
    if( [userRatings count] > 0){
    
        int numRatings = [userRatings count];
        for(NSString *rating in userRatings){
            averageReview += [rating integerValue];
        }
        averageReview = averageReview / numRatings;
        [(UITextView *)[self.menuCtrlr.view viewWithTag:5] setText:[@"Average Rating: " stringByAppendingString:[NSString stringWithFormat: @"%d", (int)averageReview]]];
        
        int i = 0;
        for(NSString *currentString in [reviewsForItem objectAtIndex:1]){
            NSString *userName = [[userNames objectAtIndex:i] stringByAppendingString:@" :    "];
            userName = [userName stringByAppendingString:[userRatings objectAtIndex:i]];
            userName = [userName stringByAppendingString:@"/5   |    "];
            NSString *userRow = [userName stringByAppendingString:currentString];
            reviewString = [[reviewString stringByAppendingString:userRow] stringByAppendingString:@"\n\n"];
            i++;
        }
    }else{
        reviewString = @"There are no reviews for this item. Add one below!";
        [(UITextView *)[self.menuCtrlr.view viewWithTag:5] setText:@"Average Rating: N/A"];
    }
    [(UITextView *)[self.menuCtrlr.view viewWithTag:4] setText:reviewString];
    
    [self.menuCtrlr.view setNeedsDisplay];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShopItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    RoastAppShopItem *shopItemAtIndex = [self.shopList objectAtIndex:indexPath.row];
    
    [(UILabel *)[cell.contentView viewWithTag:1] setText:shopItemAtIndex.name];
    [(UILabel *)[cell.contentView viewWithTag:2] setText:shopItemAtIndex.description];
    [(UILabel *)[cell.contentView viewWithTag:3] setText:shopItemAtIndex.price];
    [(UIImageView *)[cell.contentView viewWithTag:4] setImage:shopItemAtIndex.shopImage];
    
    return cell;
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
