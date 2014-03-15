//
//  RoastAppMainTabBarControllerViewController.m
//  Roast
//
//  Created by Alexander Kissinger on 3/5/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppMainTabBarControllerViewController.h"

@interface RoastAppMainTabBarControllerViewController ()

@end

@implementation RoastAppMainTabBarControllerViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleGesture
{
    [self dismissViewControllerAnimated:YES
                             completion:Nil];
}

@end
