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
            
        case 3:
            
            return [RoastAppJSONHandler requestCafeInfo:cafe];
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

//Query: Select * from roast.drinks where foodName like '% cafe %'
+(NSArray *)requestCafeInfo:(NSString *)cafeName{
    
    NSString *str1 = @"PlaceholderForInfo";
    NSString *str2 = @"";
    NSString *str3 = @"";
    NSString *str4 = @"";
    NSMutableArray *mut = [[NSMutableArray alloc] init];
    NSMutableArray *ar1 = [[NSMutableArray alloc] init];
    NSMutableArray *ar2 = [[NSMutableArray alloc] init];
    NSMutableArray *ar3 = [[NSMutableArray alloc] init];
    NSMutableArray *ar4 = [[NSMutableArray alloc] init];
    
    [ar1 addObject:str1];
    [ar2 addObject:str2];
    [ar3 addObject:str3];
    [ar4 addObject:str4];
    
    [mut addObject:ar1];
    [mut addObject:ar2];
    [mut addObject:ar3];
    [mut addObject:ar4];
    
    NSArray *jsonArray = [[NSArray alloc] initWithArray:mut];
    
    return jsonArray;
}


@end
