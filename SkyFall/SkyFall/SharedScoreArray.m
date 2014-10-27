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
        //if (!shared.scoreArray || !shared.nameArray) {
            
            
       // }

    });
    return shared;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSNumber *zero = [NSNumber numberWithInt:0];
        NSString *name = @"";
        _nameArray = [[NSMutableArray alloc]initWithObjects: name, nil];
        _scoreArray = [[NSMutableArray alloc]initWithObjects: zero, nil];
    }
    return self;
}

- (NSArray *)allScores
{
    return [self.scoreArray copy];
}

- (void)addscore:(NSNumber *) score atIndex:(int) index
{
    
    [_scoreArray insertObject:score atIndex:index];
    

}

- (void)addName:(NSString *) name atIndex:(int) index
{
    [_nameArray insertObject:name atIndex:index];
    
}

- (void)removeScoreAtIndex:(int)index
{
    [self.scoreArray removeLastObject];
    [self.nameArray removeLastObject];
}

@end
