//
//  fallingObject.h
//  SkyFall
//
//  Created by Josh Dee on 10/16/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FallingObject : UIImageView

@property (retain, nonatomic) UIImageView *object;
@property (nonatomic) NSInteger objectRandomPosition;
@property (nonatomic) NSInteger screenWidth;
@property (nonatomic) NSInteger screenHeight;
@property (retain, nonatomic) NSMutableArray *fallingObjectArray;

- (void)createFallingObject:(UIView *)view withCount:(int)objectCount;

@end
