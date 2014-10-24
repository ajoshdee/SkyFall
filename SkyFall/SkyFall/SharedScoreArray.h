//
//  SharedScoreArray.h
//  SkyFall
//
//  Created by Josh Dee on 10/24/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedScoreArray : NSObject

@property (nonatomic, retain) NSMutableArray *scoreArray;
@property (nonatomic, retain) NSMutableArray *nameArray;

+(SharedScoreArray*)sharedScoreArray;

@end
