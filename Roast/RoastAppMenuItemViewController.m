//
//  RoastAppMenuItemViewController.m
//  Roast
//
//  Created by Nicholas Variz on 2/24/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppMenuItemViewController.h"

@interface RoastAppMenuItemViewController ()

@end

@implementation RoastAppMenuItemViewController

- (void)loadInitialData
{
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear: (BOOL) animated {
    //[self loadInitialData];
    [self.view setNeedsDisplay];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
