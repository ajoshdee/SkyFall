//
//  fallingObject.m
//  SkyFall
//
//  Created by Josh Dee on 10/16/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "FallingObject.h"
int const fallingObjectWidth = 53;
int const fallingObjectHeight = 53;

@implementation FallingObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.screenWidth = [UIScreen mainScreen].bounds.size.width;
        self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    }
    return self;
}

- (void)createFallingObject: (UIView*)view withCount:(int)objectCount
{
    
    for (int i = 0; i< objectCount ; i++) {
        
        
        self.objectRandomPosition = arc4random() % self.screenWidth;
        
        // If the food will be falling outside the left side of the screen, move it inside the screen
        if (self.objectRandomPosition < 0){
            self.objectRandomPosition = fallingObjectWidth;
        }
        
        // If the food will be falling outside the right side of the screen, move it inside the screen
        if(self.objectRandomPosition > self.screenWidth - fallingObjectWidth){
            self.objectRandomPosition = self.screenWidth  - fallingObjectWidth;
        }
        
        self.object = [[[UIImageView alloc] initWithFrame:CGRectMake(self.objectRandomPosition, 0, fallingObjectWidth, fallingObjectHeight)] autorelease];
        self.object.image = [UIImage imageNamed:@"meteor.png"];
        [view addSubview:self.object];
        
        [self.fallingObjectArray addObject:self.object];
        
        float speed = [self generateRandomNumberBetweenMin:1.0 Max:2.0];
        [self makeObjectFall:speed];
    }
    
}

- (void)makeObjectFall:(float)speed
{
    [UIView animateWithDuration:speed animations:^{
        self.object.frame = CGRectMake(self.objectRandomPosition, self.screenHeight, fallingObjectWidth, fallingObjectHeight);
    }];
}

//generate random numbers within range
-(int)generateRandomNumberBetweenMin:(int)min Max:(int)max
{
    return ( (arc4random() % (max-min+1)) + min );
}

- (NSMutableArray *) fallingObjectArray
{
    if (!_fallingObjectArray) {
        _fallingObjectArray = [NSMutableArray new];
    }
    return _fallingObjectArray;

}
- (void)dealloc {
    [_fallingObjectArray release];
    [super dealloc];
}

@end
