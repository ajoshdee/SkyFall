//
//  SharedScoreArray.m
//  SkyFall
//
//  Created by Josh Dee on 10/24/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "SharedScoreArray.h"

@implementation SharedScoreArray
+(SharedScoreArray *)sharedScoreArray {
    static SharedScoreArray *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[SharedScoreArray alloc] init];
        if (!shared.scoreArray || !shared.nameArray) {
            NSNumber *zero = [NSNumber numberWithInt:0];
            NSString *name = @"";
            shared.nameArray = [[[NSMutableArray alloc]initWithObjects: name, nil]autorelease];
            shared.scoreArray = [[[NSMutableArray alloc]initWithObjects: zero, nil]autorelease];
            
        }

    });
    return shared;
}


@end
