//
//  RoastAppFeedService.h
//  Roast
//
//  Created by Alexander Kissinger on 1/31/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FBRequestConnection.h>
#import "RoastAppFeedProfile.h"
#import "RoastAppFeedItem.h"

@interface RoastAppFeedService : NSObject

@property (nonatomic) RoastAppFeedProfile *feedProfile; //General Feed Settings
@property (nonatomic) NSDateFormatter *dateFormatter;
@property (nonatomic) NSMutableArray *feedArray;

- (id)init;
- (id)initWithProfile:(RoastAppFeedProfile *)newProfile;
- (UIImage *)getUIImageFromURLString:(NSString *)urlString;

/* Prototype */
//Retrieve new feeds; TODO: msg passing denote finished
- (void)retrieveNewFeeds;
@end

