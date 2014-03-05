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
    
    NSURLResponse *response;
    NSError *error;
    [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:fullURL]] returningResponse:&response error:&error];
}

@end
