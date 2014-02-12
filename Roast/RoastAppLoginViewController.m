//
//  RoastAppLoginViewController.m
//  Roast
//
//  Created by Alexander Kissinger on 2/8/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppLoginViewController.h"

@interface RoastAppLoginViewController ()

@end

@implementation RoastAppLoginViewController

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
    //[NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(segueToFeed:) userInfo:nil repeats:NO];
    
}

- (void)segueToFeed:(id)sender
{
    [self performSegueWithIdentifier:@"login" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"You're logged in as";
    NSLog(@"LOGGED IN.");
    [self segueToFeed:self];
}

@end
