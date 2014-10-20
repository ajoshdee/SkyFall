//
//  GameOverViewController.h
//  SkyFall
//
//  Created by Josh Dee on 10/17/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOverViewController : UIViewController
@property(retain,nonatomic) NSMutableArray *scoreArray;
@property (nonatomic, assign) NSNumber *currentScore;
@property (nonatomic, assign) int highScore;

@end
