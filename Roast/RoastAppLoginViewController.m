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
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)segueToFeed:(id)sender
{
    [self performSegueWithIdentifier:@"login" sender:self];
    self.navigationController.navigationBarHidden = NO;
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

- (IBAction)unwindToLogin:(UIStoryboardSegue *)unwindSegue
{
    self.navigationController.navigationBarHidden = YES;
}

@end
