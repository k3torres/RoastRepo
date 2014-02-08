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
+(NSArray *) makeJSONRequest:(int)queryType :(NSString *)cafe{
    
    switch (queryType)
    {
        case 0:
            
            return [RoastAppJSONHandler requestCafeDrinks:cafe];
            
            break;
            
        case 1:
            
            return [RoastAppJSONHandler requestCafeFoods:cafe];
            break;
            
        default:
            
            break;
    }
    
    //Fall-through case
    return nil;
}

//Query: Select * from roast.cafes where cafeName like '% cafe %'
+(NSArray *)requestCafeDrinks:(NSString*)cafeName{
    
    NSString *fullURL = [[baseURL stringByAppendingString:@"GetCafeDrinks?cafe="] stringByAppendingString:cafeName];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:fullURL]];
    NSDictionary *dictionaryFromResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *jsonArray = [dictionaryFromResponse allValues];
    NSArray *innerElements = [jsonArray objectAtIndex:0];
    
    queryResult = [[NSArray alloc] initWithArray:innerElements];
    
    return queryResult;
}

//Query: Select * from roast.drinks where foodName like '% cafe %'
+(NSArray *)requestCafeFoods:(NSString *)cafeFood{
    
    NSString *fullURL = [[baseURL stringByAppendingString:@"GetCafeFoods?cafe="] stringByAppendingString:cafeFood];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:fullURL]];
    NSDictionary *dictionaryFromResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *jsonArray = [dictionaryFromResponse allValues];
    NSArray *innerElements = [jsonArray objectAtIndex:0];
    
    queryResult = [[NSArray alloc] initWithArray:innerElements];
    
    return queryResult;
}

@end
