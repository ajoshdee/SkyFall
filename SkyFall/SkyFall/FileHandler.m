//
//  FileHandler.m
//  SkyFall
//
//  Created by Josh Dee on 10/20/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "FileHandler.h"

@implementation FileHandler

-(NSMutableArray *)loadJSONFile: (NSString*) key
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[self JSONFilePath]];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    array = [dictionary valueForKey:key];
    return array;
}

-(void)writeToJSONFile:(NSMutableArray*) array usingKey: (NSString*) key
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObject:array
                                                                         forKey:key];
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
