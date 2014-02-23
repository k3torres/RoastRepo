//
//  RoastAppShopViewController.m
//  Roast
//
//  Created by Nicholas Variz on 1/26/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppShopViewController.h"
#import "RoastAppShopMenuViewController.h"
#import "RoastAppJSONHandler.h"
#import "RoastAppShopItem.h"

@interface RoastAppShopViewController ()

@end

@implementation RoastAppShopViewController

@synthesize shopChoice;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.shopList1 = [[NSMutableArray alloc] init];
    self.shopList2 = [[NSMutableArray alloc] init];
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
    
    if(tableView == [self.view viewWithTag:1])
    {
        return [self.shopList1 count];
    }
    else {
        return [self.shopList2 count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(tableView == [self.view viewWithTag:1]){
        RoastAppShopItem *shopItem = [self.shopList1   objectAtIndex:indexPath.row];
        cell.textLabel.text = shopItem.name;
    }
    else{
        RoastAppShopItem *shopItem = [self.shopList2   objectAtIndex:indexPath.row];
        cell.textLabel.text = shopItem.name;
    }
    return cell;
}

- (IBAction)unwindToShopList:(UIStoryboardSegue *)segue

{
    
    NSLog(@"Calling unwindToShopList");
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get reference to the ShopMenu view controller (destination)
    RoastAppShopMenuViewController *menuCtrlr = [segue destinationViewController];
    menuCtrlr.shopChoice = [self shopChoice];
    //Inform the menu VC which type of menu should be displayed
    if ([[segue identifier] isEqualToString:@"drinkMenuSegue"])
        menuCtrlr.menuChoice = @"drinkMenu";
    else if ([[segue identifier] isEqualToString:@"foodMenuSegue"])
        menuCtrlr.menuChoice = @"foodMenu";
    else if ([[segue identifier] isEqualToString:@"gearMenuSegue"])
        menuCtrlr.menuChoice = @"gearMenu";
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