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
//  2) ...
//

#import "RoastAppJSONHandler.h"

@implementation RoastAppJSONHandler

//All server requests have this base URL
NSString *baseURL = @"http://54.201.5.175:8080/roast/";

//Function for making JSON requests, paramaterized by query type as described above
+(NSArray *) makeJSONRequest:(int)queryType {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    switch (queryType)
    {
        case 0:
            
            return [RoastAppJSONHandler requestAllCafes:session];
            
            break;
            
        case 1:
            
            return [RoastAppJSONHandler requestAllDrinks:session];
            break;
            
        default:
            
            break;
    }
    
    //Fall-through case
    return nil;
}

//Query: Select * from roast.cafes
+(NSArray *)requestAllCafes:(NSURLSession *)session {
    
    NSString *fullURL = [baseURL stringByAppendingString:@"ListAllCafes"];
    __block NSArray *queryResults;
    
    [[session dataTaskWithURL:[NSURL URLWithString:fullURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                NSDictionary *dictionaryFromResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                NSArray *jsonArray = [dictionaryFromResponse allValues];
                
                NSLog(@"json array is nil?%d", [jsonArray isEqual:nil]);
                queryResults = [jsonArray objectAtIndex:0];
                NSLog(@"Connected to Server");
                
            }] resume];
    
    return queryResults;
}

//Query: Select * from roast.drinks
+(NSArray *)requestAllDrinks:(NSURLSession *)session {
    
    NSString *fullURL = [baseURL stringByAppendingString:@"ListAllDrinks"];
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
