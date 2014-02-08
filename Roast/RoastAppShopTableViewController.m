//
//  RoastAppShopTableViewController.m
//  Roast
//
//  Created by KT on 2/4/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppShopTableViewController.h"
#import "RoastAppShopItem.h"

@interface RoastAppShopTableViewController ()
@property  NSMutableArray *shops;
@property  RoastAppShopItem *shopItem1;
@property   UIButton *button;
@property  int counter;
@end

@implementation RoastAppShopTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    

    
    return self;
}
-(void)loadInitial
{
    self.shopItem1 = [[RoastAppShopItem alloc] init];
    self.shopItem1.shopImage = [UIImage imageNamed:@"CaffeCalabria1.png"];
    [self.shops addObject:self.shopItem1];
    
    NSMutableArray *buttonArray = [[NSMutableArray alloc] init];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setFrame:CGRectMake(0,0,30,30)];
    [self.button setTitle:@"Drinks" forState:UIControlStateNormal];
    [buttonArray addObject:self.button];
    [self.shops addObject:buttonArray];
    [self.shops addObject:@"Text Field"];
    self.counter = 0;
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
     self.shops = [[NSMutableArray alloc] init];
    [self loadInitial];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.shops count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    // Configure the cell...
    NSLog(@"what is indexPath = %i", (int)indexPath);
    NSLog(@"counter = %i", self.counter);
    if (self.counter < 1) {
        self.counter++;
        static NSString *CellIdentifier1 = @"picCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1 forIndexPath:indexPath];
        [(UIImageView *)[cell.contentView viewWithTag:101] setImage:self.shopItem1.shopImage];
        return cell;
    }
    else if ( self.counter == 1 ){
        self.counter++;
        static NSString *CellIdentifier2 = @"menuCell";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
        [cell1 addSubview:self.button];

        return cell1;
    }
    else {
        static NSString *CellIdentifier3 = @"textCell";
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3 forIndexPath:indexPath];
        [cell2.contentView viewWithTag:101];
        
        return cell2;
    }
    
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
