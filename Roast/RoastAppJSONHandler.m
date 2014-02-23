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

// Function for making JSON requests, paramaterized by query type as described above
+(NSArray *) makeJSONRequest:(int)queryType :(NSString *)cafe{
    
    switch (queryType)
    {
        case 0:
            
            return [RoastAppJSONHandler requestCafeDrinks:cafe];
            
            break;
            
        case 1:
            
            return [RoastAppJSONHandler requestCafeFoods:cafe];
            break;
            
        case 2:
            
            return [RoastAppJSONHandler requestCafeGear:cafe];
            break;
            
        default:
            
            break;
    }
    
    //Fall-through case
    return nil;
}

//Query: Select * from roast.cafes where cafeName like '% cafe %'
+(NSArray *)requestCafeDrinks:(NSString*)cafeName{
    
    NSString *cafePrefix = [cafeName substringToIndex:3];
    
    NSString *fullURL = [[baseURL stringByAppendingString:@"GetCafeDrinks?cafe="] stringByAppendingString:cafePrefix];
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:fullURL]];
    NSError *error;
    NSDictionary *dictionaryFromResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSArray *jsonArray = [dictionaryFromResponse allValues];
    
    return jsonArray;
}

//Query: Select * from roast.drinks where foodName like '% cafe %'
+(NSArray *)requestCafeFoods:(NSString *)cafeName{
    
    NSString *cafePrefix = [cafeName substringToIndex:3];
    NSString *fullURL = [[baseURL stringByAppendingString:@"GetCafeFoods?cafe="] stringByAppendingString:cafePrefix];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:fullURL]];
    NSDictionary *dictionaryFromResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *jsonArray = [dictionaryFromResponse allValues];
    
    return jsonArray;
}

//Query: Select * from roast.drinks where foodName like '% cafe %'
+(NSArray *)requestCafeGear:(NSString *)cafeName{
    
    NSString *cafePrefix = [cafeName substringToIndex:3];
    NSString *fullURL = [[baseURL stringByAppendingString:@"GetCafeGear?cafe="] stringByAppendingString:cafePrefix];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:fullURL]];
    NSDictionary *dictionaryFromResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *jsonArray = [dictionaryFromResponse allValues];
    
    return jsonArray;
}

@end
