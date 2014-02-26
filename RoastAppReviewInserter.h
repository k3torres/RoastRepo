//
//  RoastAppReviewInserter.h
//  Roast
//
//  Created by Nicholas Variz on 2/26/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoastAppReviewInserter : NSObject

+(BOOL) insertNewReview:(NSString *)id :(NSString *)comment :(NSString *)rating :(NSString *)userName;

@end
