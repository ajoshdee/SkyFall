//
//  FileHandler.m
//  SkyFall
//
//  Created by Josh Dee on 10/20/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "FileHandler.h"
NSString *const scoreKey = @"high scores";
NSString *const nameKey = @"player names";

@implementation FileHandler

-(void)loadJSONFile
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[self JSONFilePath]];
    
    self.scoreArray = [dictionary valueForKey:scoreKey];
    self.nameArray = [dictionary valueForKey:nameKey];
    if (!self.scoreArray || !self.nameArray) {
        NSNumber *zero = [NSNumber numberWithInt:0];
        NSString *name = @"";
        self.nameArray = [[[NSMutableArray alloc]initWithObjects: name, nil]autorelease];
        self.scoreArray = [[[NSMutableArray alloc]initWithObjects: zero, nil]autorelease];
        
        
    }

}

-(void)writeToJSONFile
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.scoreArray,
                                                                         scoreKey,self.nameArray,nameKey, nil];
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
