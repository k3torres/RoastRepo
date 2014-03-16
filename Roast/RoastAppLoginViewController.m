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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"Roast Login Screen";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat values[4] = {1.0, 1.0, 1.0, 1.0};
    CGColorRef white = CGColorCreate(rgbColorspace, values);
    self.navigationController.navigationBarHidden = YES;
    self.skipButton.layer.borderWidth = 0.5f;
    self.skipButton.layer.cornerRadius = 5;
    self.skipButton.layer.borderColor = white;
    self.skipButton.layer.cornerRadius = 0;
}

- (IBAction)skipButtonClicked:(id)sender {
    [self segueToFeed:self];
}


- (void)segueToFeed:(id)sender
{
    [self performSegueWithIdentifier:@"login" sender:self];
    //self.navigationController.navigationBarHidden = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.nameLabel.text = user.name;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:user.name forKey:@"myName"];
    [userDefaults synchronize];
    
    NSLog(@"UserInfo Fetched");
    [self segueToFeed:self];
}
/*
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"You're logged in as";
    NSLog(@"LOGGED IN.");
    [self segueToFeed:self];
}
*/
- (IBAction)unwindToLogin:(UIStoryboardSegue *)unwindSegue
{
    //self.navigationController.navigationBarHidden = YES;
}

@end
