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
        rating = @"0";
    NSString *fullURL = [[[[[[[@"http://54.201.5.175:8080/roast/PutReview?id=" stringByAppendingString:id] stringByAppendingString:@"&comments="] stringByAppendingString:comments] stringByAppendingString:@"&rating="] stringByAppendingString:rating] stringByAppendingString:@"&user="] stringByAppendingString:userName];
    
    NSString* formattedURL = [fullURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLResponse *response;
    NSError *error;
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:formattedURL]];
    //send it synchronous
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    // check for an error
    if(!error)
    {
        //log response
        NSLog(@"Remote server responded to review insert request");
    }
}

@end
