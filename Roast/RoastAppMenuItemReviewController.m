//
//  RoastAppMenuItemReviewController.m
//  Roast
//
//  Created by Nicholas Variz on 3/3/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppMenuItemReviewController.h"
#import "RoastAppReviewInserter.h"

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
