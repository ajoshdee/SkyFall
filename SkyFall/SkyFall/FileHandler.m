//
//  FileHandler.m
//  SkyFall
//
//  Created by Josh Dee on 10/20/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "FileHandler.h"
#import "SharedScoreArray.h"

NSString *const scoreKey = @"high scores";
NSString *const nameKey = @"player names";

@implementation FileHandler

-(void)loadJSONFile
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[self JSONFilePath]];
    if(dictionary){
        [SharedScoreArray sharedScoreArray].scoreArray = [dictionary valueForKey:scoreKey];
        [SharedScoreArray sharedScoreArray].nameArray = [dictionary valueForKey:nameKey];
    }
    
}

-(void)writeToJSONFile
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[SharedScoreArray sharedScoreArray].scoreArray,scoreKey,[SharedScoreArray sharedScoreArray].nameArray,nameKey, nil];
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
