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

//@synthesize rateView;

@implementation RoastAppMenuItemReviewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{

    self.rateView.canEdit = YES;
    self.rateView.maxRating = 5;
    self.rateView.minAllowedRating = 0;
    self.rateView.maxAllowedRating = 5;
    self.rateView.rating = 5;
    
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
    NSLog(@"star rating value ---------------> %f", self.rateView.rating);
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(IBAction)submitReview:(UIButton *)sender{

    UITextView *comm = (UITextView*)[self.view viewWithTag:1];
    NSString* comments = comm.text;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *user = [prefs stringForKey:@"myName"];
    NSString *rating = [[NSNumber numberWithFloat:self.rateView.rating] stringValue];
    [RoastAppReviewInserter insertNewReview:self.menuItemID :comments :rating:user];

    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ReviewSubmitted"
     object:self];
  
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
