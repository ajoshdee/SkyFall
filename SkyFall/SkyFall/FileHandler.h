//
//  FileHandler.h
//  SkyFall
//
//  Created by Josh Dee on 10/20/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHandler : NSObject

-(NSMutableArray *)loadJSONFile: (NSString*) key;
-(void)writeToJSONFile:(NSMutableArray*) array usingKey: (NSString*) key;
@end
