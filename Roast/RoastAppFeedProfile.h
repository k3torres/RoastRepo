//
//  RoastAppFeedProfile.h
//  Roast
//
//  Created by Alexander Kissinger on 1/31/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoastAppFeedProfile : NSObject

@property NSMutableArray *users;
@property NSMutableArray *tags;

@property BOOL enableFacebook;
@property BOOL enableInstagram;
@property BOOL enableTwitter;


@end
