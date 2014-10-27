//
//  SharedScoreArray.h
//  SkyFall
//
//  Created by Josh Dee on 10/24/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedScoreArray : NSObject

@property (nonatomic, retain) NSArray *allScores;
@property (nonatomic, retain) NSArray *allNames;

+(SharedScoreArray*)sharedScoreArray;
- (void)addscore:(NSNumber *) score atIndex:(int) index;
- (void)addName:(NSString *) name atIndex:(int) index;
- (void)removeScore;
-(void)writeToJSONFile;
@end