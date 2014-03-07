//
//  RoastAppMenuItemReviewController.m
//  Roast
//
//  Created by Nicholas Variz on 3/3/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppMenuItemReviewController.h"
#import "RoastAppReviewInserter.h"
#import "RoastAppJSONHandler.h"

@interface RoastAppMenuItemReviewController ()

@property UIStepper* ratingStepper;
@property UILabel* currentRating;
@property NSString* rating;

@end


@implementation RoastAppMenuItemReviewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [(UITextView*)[self.view viewWithTag:1] setDelegate:self];
    self.currentRating = (UILabel *)[self.view viewWithTag:2];
    self.ratingStepper = (UIStepper *)[self.view viewWithTag:3];

}
- (IBAction)stepperValueChanged:(UIStepper *)sender {
    
    self.currentRating.text = [@((int)sender.value) stringValue];
    self.rating = [@((int)sender.value) stringValue];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
//Pass the name of the selected shop to the next view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    UIViewController* target = [segue destinationViewController];
    NSLog(@"Called prepare for segue in Review Controller");
    NSArray *reviewsForItem = [RoastAppJSONHandler makeJSONRequest:3 :[self menuItemID]];
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
        [(UITextView *)[target.view viewWithTag:5] setText:[@"Average Rating: " stringByAppendingString:[NSString stringWithFormat: @"%d", (int)averageReview]]];
        
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
        [(UITextView *)[target.view viewWithTag:5] setText:@"Average Rating: N/A"];
    }
    [(UITextView *)[target.view viewWithTag:4] setText:reviewString];
    
    [target.view setNeedsDisplay];
}
-(IBAction)submitReview:(UIButton *)sender{

    UITextView *comm = (UITextView*)[self.view viewWithTag:1];
    NSString* comments = comm.text;
    [RoastAppReviewInserter insertNewReview:self.menuItemID :comments :self.rating:@"DefaultUser"];

    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)cancelAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
