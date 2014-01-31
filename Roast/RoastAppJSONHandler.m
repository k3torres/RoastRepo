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
#import "RoastAppShopViewController.h"

@implementation RoastAppJSONHandler

//All server requests have this base URL
NSString *baseURL = @"http://54.201.5.175:8080/roast/";

NSArray *queryResult;

//Function for making JSON requests, paramaterized by query type as described above
+(NSArray *) makeJSONRequest:(int)queryType {
    
    switch (queryType)
    {
        case 0:
            
            return [RoastAppJSONHandler requestAllCafes];
            
            break;
            
        case 1:
            
            return [RoastAppJSONHandler requestAllDrinks];
            break;
            
        default:
            
            break;
    }
    
    //Fall-through case
    return nil;
}

//Query: Select * from roast.cafes
+(NSArray *)requestAllCafes{
    
    NSString *fullURL = [baseURL stringByAppendingString:@"ListAllCafes"];
    
    //Create a default configuration for the NSURLSession
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //Create an NSURLSession and use RoastAPPJSONHandler as default session delegate
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:config
                                  delegate:self
                             delegateQueue:nil];
    
    NSURLSessionTask *queryDB =
        [session dataTaskWithURL:[NSURL URLWithString:fullURL]
      
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                //perform database query, retreive JSON
                NSDictionary *dictionaryFromResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                NSArray *jsonArray = [dictionaryFromResponse allValues];
                NSArray *innerElements = [jsonArray objectAtIndex:0];
                
                /*dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //store DB for later retrieval
                    NSLog(@"here");
                    queryResult = [jsonArray objectAtIndex:0];
                });*/
                
                queryResult = [[NSArray alloc] initWithArray:innerElements];
                
            }];
     
    [queryDB resume];
     
    return queryResult;
}

//Query: Select * from roast.drinks
+(NSArray *)requestAllDrinks{
    
    NSString *fullURL = [baseURL stringByAppendingString:@"ListAllDrinks"];
    //Create a default configuration for the NSURLSession
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //Create an NSURLSession and use RoastAPPJSONHandler as default session delegate
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:config
                                  delegate:self
                             delegateQueue:nil];
    
    NSURLSessionTask *queryDB =
    [session dataTaskWithURL:[NSURL URLWithString:fullURL]
     
           completionHandler:^(NSData *data,
                               NSURLResponse *response,
                               NSError *error) {
               
               //perform database query, retreive JSON
               NSDictionary *dictionaryFromResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
               NSArray *jsonArray = [dictionaryFromResponse allValues];
               NSArray *innerElements = [jsonArray objectAtIndex:0];
               
               /*dispatch_async(dispatch_get_main_queue(), ^{
                
                //store DB for later retrieval
                NSLog(@"here");
                queryResult = [jsonArray objectAtIndex:0];
                });*/
               
               queryResult = [[NSArray alloc] initWithArray:innerElements];
               
           }];
    
    [queryDB resume];
    
    return queryResult;
}

@end
