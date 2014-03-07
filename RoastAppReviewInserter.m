//
//  RoastAppReviewInserter.m
//  Roast
//
//  Created by Nicholas Variz on 2/26/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppReviewInserter.h"

@implementation RoastAppReviewInserter


+(void) insertNewReview:(NSString *)id :(NSString *)comments :(NSString *)rating :(NSString *)userName{
    if(rating == nil)
        return;
    NSString *fullURL = [[[[[[[@"http://54.201.5.175:8080/roast/PutReview?id=" stringByAppendingString:id] stringByAppendingString:@"&comments="] stringByAppendingString:comments] stringByAppendingString:@"&rating="] stringByAppendingString:rating] stringByAppendingString:@"&user="] stringByAppendingString:userName];
    
    NSString* formattedURL = [fullURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection
     sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:formattedURL]]
     queue:[[NSOperationQueue alloc] init]
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error)
     {
         
         if (error != nil){
             NSLog(@"Error = %@", error);
         }
         else{
             NSLog(@"Successfully inserted review into DB");
         }
         
     }];
    /*
    NSURLResponse *response;
    NSError *error;
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:fullURL]];
    //send it synchronous
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    // check for an error. If there is a network error, you should handle it here.
    if(!error)
    {
        //log response
        NSLog(@"Response from server = %@", responseString);
    }*/
}

@end
