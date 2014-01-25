//
//  RoastAppJSONHandler.m
//  Roast
//
//  Created by Nicholas Variz on 1/24/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//
//  Request Encoding:
//  0) List All Cafes
//  1) List All Drinks
//  2) Cafe contains search...
//

#import "RoastAppJSONHandler.h"

@implementation RoastAppJSONHandler

//All server requests have this base URL
NSString *baseURL = @"http://54.201.5.175:8080/roast/";

//
-(NSArray *) makeJSONRequest:(int)queryType {
    NSURLSession *session = [NSURLSession sharedSession];
    
    switch (queryType)
    {
        case 0:
            
            return [RoastAppJSONHandler requestAllCafes:session];
            
            break;
            
        default:
            
            break;
    }
    
    //Fall-through case
    return nil;
}

+(NSArray *)requestAllCafes:(NSURLSession *)session {
    
    NSString *fullURL = [baseURL stringByAppendingString:@"ListAllCafes"];
    __block NSArray *queryResults;
    
    [[session dataTaskWithURL:[NSURL URLWithString:fullURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                NSDictionary *dictionaryFromResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                NSArray *jsonArray = [dictionaryFromResponse allValues];
                
                
                queryResults = [jsonArray objectAtIndex:0];
                
            }] resume];
    
    return queryResults;
}

@end
