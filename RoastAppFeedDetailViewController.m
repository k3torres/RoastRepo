//
//  RoastAppFeedDetailViewController.m
//  Roast
//
//  Created by KT on 2/14/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppFeedDetailViewController.h"

@interface RoastAppFeedDetailViewController ()


@end

@implementation RoastAppFeedDetailViewController

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
    self.title = @"Detail";
	// Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    [(UILabel *)[self.view viewWithTag:30] setText:self.detailName];
}
@end
