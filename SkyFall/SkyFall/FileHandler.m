//
//  FileHandler.m
//  SkyFall
//
//  Created by Josh Dee on 10/20/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "FileHandler.h"
NSString *const scoreKey = @"high scores";

@implementation FileHandler

-(NSMutableArray *)loadJSONFile
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[self JSONFilePath]];
    
    NSMutableArray *array = [dictionary valueForKey:scoreKey];
    if (!array) {
        NSNumber *zero = [[NSNumber alloc] initWithInt:0];
        array = [[[NSMutableArray alloc]initWithObjects: zero, nil]autorelease];
        [zero release];
        
    }

   
    return array;
}

-(void)writeToJSONFile:(NSMutableArray*) array
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObject:array
                                                                         forKey:scoreKey];
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