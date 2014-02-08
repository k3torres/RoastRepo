//
//  RoastAppJSONHandler.h
//  Roast
//
//  Created by Nicholas Variz on 1/24/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoastAppJSONHandler : NSObject

@property (strong) NSArray *queryResult;

+(NSArray *) makeJSONRequest:(int)queryType :(NSString *)cafe;

@end
