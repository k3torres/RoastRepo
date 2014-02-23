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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE h:mm a MM.dd"];
    
    
    if ( [self.selectedFeedItem.serviceName isEqualToString:@"Instagram"])
    {
        [self.postPicture setImage:self.selectedFeedItem.photo];
    }
    
    [(UILabel *)[self.view viewWithTag:30] setText:self.detailName];
    [self.userName setText:self.selectedFeedItem.userName];
    [self.comment setText:self.selectedFeedItem.message];
    [self.profilePicture setImage:self.selectedFeedItem.userPic];
    //[ viewWithTag:13] setText:[formatter stringFromDate:feedItemAtIndex.timestamp]];
}

- (void)handleGesture
{
    [self dismissViewControllerAnimated:YES
                             completion:Nil];
}

@end
