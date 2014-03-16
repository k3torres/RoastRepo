//
//  RoastAppMenuItemViewController.m
//  Roast
//
//  Created by Nicholas Variz on 2/24/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppMenuItemViewController.h"
#import "RoastAppMenuItemReviewController.h"
#import "RoastAppJSONHandler.h"



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

// Seque from MenuItem to Review screen, sets title and passes item ID
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    RoastAppMenuItemReviewController* reviewCtrlr = [segue destinationViewController];
    reviewCtrlr.title = self.item.name;
    reviewCtrlr.menuItemID = [self.item uid];
    reviewCtrlr.parentViewCtrlr = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(receiveReviewSubmitted:)
            name:@"ReviewSubmitted"
                object:nil];
}

//Refresh ratings when HTTP request returns
- (void)receiveReviewSubmitted:(NSNotificationCenter *)notification
{
    
    NSArray *reviewsForItem = [RoastAppJSONHandler makeJSONRequest:3 :self.item.uid];
    NSArray *userNames = [reviewsForItem objectAtIndex:3];
    NSArray *userRatings = [reviewsForItem objectAtIndex:2];
    NSString *reviewString = @"";
    NSInteger averageReview = 0;
    
    if( [userRatings count] > 0){
        
        int numRatings = [userRatings count];
        for(NSString *rating in userRatings){
            averageReview += [rating integerValue];
        }
        averageReview = averageReview / numRatings;
        [(UITextView *)[self.view viewWithTag:5] setText:[@"Average Rating: " stringByAppendingString:[NSString stringWithFormat: @"%d", (int)averageReview]]];
        
        int i = 0;
        for(NSString *currentString in [reviewsForItem objectAtIndex:1]){
            
            NSString *userName = [[userNames objectAtIndex:i] stringByAppendingString:@" :    "];
            userName = [userName stringByAppendingString:[userRatings objectAtIndex:i]];
            userName = [userName stringByAppendingString:@"/5   |    "];
            NSString *userRow = [userName stringByAppendingString:currentString];
            reviewString = [[reviewString stringByAppendingString:userRow] stringByAppendingString:@"\n\n"];
            i++;
        }
    }else{
        reviewString = @"There are no reviews for this item. Add one below!";
        [(UITextView *)[self.view viewWithTag:5] setText:@"Average Rating: N/A"];
    }
    [(UITextView *)[self.view viewWithTag:4] setText:reviewString];
    [self.view setNeedsDisplay];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
