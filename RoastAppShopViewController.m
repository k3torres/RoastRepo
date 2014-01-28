//
//  RoastAppShopViewController.m
//  Roast
//
//  Created by Nicholas Variz on 1/27/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppShopViewController.h"
#import "RoastAppShopItem.h"
#import "RoastAppJSONHandler.h"

@interface RoastAppShopViewController ()

@end

@implementation RoastAppShopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadInitialData
{
    NSArray *queryResult = [RoastAppJSONHandler makeJSONRequest:1];
    
    if(queryResult != nil){
        
        int counter = 0;
        
        for(NSString *string in queryResult){
            RoastAppShopItem *temp = [[RoastAppShopItem alloc] init];
            temp.name = [queryResult objectAtIndex:counter];
            [self.shopItems addObject:temp];
            counter = counter + 1;
        }
        NSLog(@"shopItems Initialized!");
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.shopItems = [[NSMutableArray alloc] init];
    [self loadInitialData];
	// Do any additional setup after loading the view.
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
    return [self.shopItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    RoastAppShopItem *shopItem = [self.shopItems   objectAtIndex:indexPath.row];
    cell.textLabel.text = shopItem.name;
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
