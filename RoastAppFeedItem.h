//
//  RoastAppFeedItem.h
//  Roast
//
//  Created by Alexander Kissinger on 1/24/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoastAppFeedItem : NSObject

@property NSString *serviceName;
@property NSNumber *idNum;
@property UIImage *serviceBadge;
@property UIImage *userPic;
@property NSString *userName;
@property NSString *message;
@property NSDate *timestamp;
@property NSURL *url;

@end