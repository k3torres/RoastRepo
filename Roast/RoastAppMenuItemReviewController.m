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

@synthesize textViewArea;
@synthesize scroll;
@synthesize cancelButton;
@synthesize submitButton;
@synthesize image;
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
    //self.currentRating = (UILabel *)[self.view viewWithTag:2];
    //self.ratingStepper = (UIStepper *)[self.view viewWithTag:3];
    [scroll setScrollEnabled:YES];
    //[scroll setContentSize:CGSizeMake(320, 800)];
    //self.backgroundtest = [NSMutableArray arrayWithObjects:@"Wood-Desktop-Wallpaper3.png", nil];

    self.rateView.layer.cornerRadius = 5.0;
    self.rateView.layer.borderWidth = 0.5f;
    [self.rateView.layer setBorderColor:[[UIColor whiteColor]CGColor]];
    cancelButton.layer.borderWidth = 0.5f;
    cancelButton.layer.cornerRadius = 5;
    [cancelButton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    cancelButton.layer.cornerRadius = 0;
    submitButton.layer.borderWidth = 0.5f;
    submitButton.layer.cornerRadius = 5;
    [submitButton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    submitButton.layer.cornerRadius = 0;
    
    self.rateView.canEdit = YES;
    self.rateView.maxRating = 5;
    self.rateView.minAllowedRating = 0;
    self.rateView.maxAllowedRating = 5;
    self.rateView.rating = 5;

    self.menuImage.image = self.image;

    
    

}



-(IBAction)submitReview:(UIButton *)sender{

    UITextView *comm = (UITextView*)[self.view viewWithTag:1];
    NSString* comments = comm.text;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *user = [prefs stringForKey:@"myName"];
    NSLog(@"USER NAME --------------------> %@", user); 
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

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    scroll.frame = CGRectMake(scroll.frame.origin.x, -160, scroll.frame.size.width, scroll.frame.size.height);
    [UIView commitAnimations];
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        scroll.frame = CGRectMake(scroll.frame.origin.x, 0, scroll.frame.size.width, scroll.frame.size.height);
        [UIView commitAnimations];
        return NO;
    }
    return YES;
}












@end
