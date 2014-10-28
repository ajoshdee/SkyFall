//
//  SharedScoreArray.m
//  SkyFall
//
//  Created by Josh Dee on 10/24/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "SharedScoreArray.h"

NSString *const scoreKey = @"high scores";
NSString *const nameKey = @"player names";

@interface SharedScoreArray ()

@property (nonatomic, retain) NSMutableArray *scoreArray;
@property (nonatomic, retain) NSMutableArray *nameArray;

@end

@implementation SharedScoreArray

+(SharedScoreArray *)sharedScoreArray {
    static SharedScoreArray *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[SharedScoreArray alloc] init];


    });
    return shared;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self loadJSONFile];
    
    }
    return self;
}

- (NSArray *)allScores
{
    
    return [[_scoreArray copy]autorelease];
}

- (NSArray *)allNames
{
    return [[_nameArray copy]autorelease];
}


- (void)addscore:(NSNumber *) score atIndex:(int) index
{
    
    [_scoreArray insertObject:score atIndex:index];
    

}

- (void)addName:(NSString *) name atIndex:(int) index
{
    [_nameArray insertObject:name atIndex:index];
    
}

- (void)removeScore
{
    [self.scoreArray removeLastObject];
    [self.nameArray removeLastObject];
}

-(void)loadJSONFile
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[self JSONFilePath]];
    
    if(dictionary){
        _scoreArray = [[dictionary valueForKey:scoreKey]copy];
        _nameArray = [[dictionary valueForKey:nameKey]copy];
    }
    
    if (_scoreArray == nil || _nameArray == nil) {
        NSNumber *zero = [NSNumber numberWithInt:0];
        NSString *name = @"";
        _nameArray = [[NSMutableArray alloc]initWithObjects: name, nil];
        _scoreArray = [[NSMutableArray alloc]initWithObjects: zero, nil];
    }
    
}

-(void)writeToJSONFile
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:_scoreArray,scoreKey,_nameArray,nameKey, nil];
    [[NSString stringWithFormat:@"%@",dictionary] writeToFile:[self JSONFilePath]
                                                   atomically:YES
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    
}

-(NSString *)JSONFilePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask,
                                                                       YES);
    NSString *filePath = [documentDirectories firstObject];
    
    filePath = [filePath stringByAppendingPathComponent: @"high_scores.json"];
    return filePath;
}



@end
