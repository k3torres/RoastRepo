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
@synthesize scroll;

- (void)loadInitialData
{
    [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(320, 800)];
    self.starRating.canEdit = YES;
    self.starRating.maxRating = 5;
    self.starRating.minAllowedRating = 0;
    self.starRating.maxAllowedRating = 5;
    self.starRating.rating = 0;
    [self.textInfoView setScrollEnabled:NO];
    [self.textInfoView sizeToFit];
    CGRect frame = self.textInfoView.frame;
    self.rateButton.layer.borderWidth = 0.5f;
    self.rateButton.layer.cornerRadius = 5;
    [self.rateButton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    self.rateButton.layer.cornerRadius = 0;
    frame.size.width = 320;
    _textInfoView.frame = frame;
    
    [self.ratingTextView setScrollEnabled:NO];
    frame = self.ratingTextView.frame;
    
    self.ratingTextView.frame = CGRectMake(0, (self.textInfoView.frame.origin.y + self.textInfoView.frame.size.height + 15), 320, frame.size.height);
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}

// Seque from MenuItem to Review screen, sets title and passes item ID
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    RoastAppMenuItemReviewController* reviewCtrlr = [segue destinationViewController];
    reviewCtrlr.title = self.item.name;
    reviewCtrlr.menuItemID = [self.item uid];
    reviewCtrlr.parentViewCtrlr = self;
    reviewCtrlr.image = self.image;
    reviewCtrlr.fromSegueRating = self.starRating.rating;
    
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(receiveReviewSubmitted:)
            name:@"ReviewSubmitted"
                object:nil];

     self.textInfoView.text = [[self.item.description stringByAppendingString:@"\n\n"]stringByAppendingString:self.item.price];
    
    [self loadInitialData];
}

//Refresh ratings when HTTP request returns
- (void)receiveReviewSubmitted:(NSNotificationCenter *)notification
{
    
    NSArray *reviewsForItem = [RoastAppJSONHandler makeJSONRequest:3 :self.item.uid];
    NSArray *userNames = [reviewsForItem objectAtIndex:0];
    NSArray *userRatings = [reviewsForItem objectAtIndex:1];
    NSArray *userComments = [reviewsForItem objectAtIndex:2];
    
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
        for(NSString *currentString in userComments){
            
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
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"SOMEHOW IN HERE");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToMenuItemView:(UIStoryboardSegue *)unwindSegue
{
    
}
@end
