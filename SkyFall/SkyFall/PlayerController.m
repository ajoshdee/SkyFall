//
//  PlayerController.m
//  SkyFall
//
//  Created by Josh Dee on 10/15/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "PlayerController.h"

@interface PlayerController ()
@property (nonatomic, assign) CGPoint currentPoint;
@end

@implementation PlayerController


- (id)initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image])
    {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    // When a touch starts, get the current location in the view
    _currentPoint = [[touches anyObject] locationInView:self];
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    // Get active location upon move
    CGPoint activePoint = [[touches anyObject] locationInView:self];
    
    // Determine new point based on where the touch is now located
    CGPoint newPoint = CGPointMake(self.center.x + (activePoint.x - _currentPoint.x),
                                   self.center.y + (activePoint.y - _currentPoint.y));
    
    
    // Make sure we stay within the bounds of the parent view
    
    float midPointX = CGRectGetMidX(self.bounds);
    CGFloat pointX = newPoint.x;
    
    float midPointY = CGRectGetMidY(self.bounds);
    CGFloat pointY = newPoint.y;
    
    
    newPoint.x = [self playerBounds:pointX MidPoint:midPointX Size:self.superview.bounds.size.width];
    
    newPoint.y = [self playerBounds:pointY MidPoint:midPointY Size:self.superview.bounds.size.height];
    

    self.center = newPoint;
}

- (CGFloat)playerBounds:(CGFloat)oldPoint MidPoint:(float)midPoint Size:(CGFloat)bounds

{
    if (oldPoint > bounds  - midPoint){
        oldPoint = bounds - midPoint;
    }
    else if (oldPoint < midPoint){
        oldPoint = midPoint;
    }
    
    return oldPoint;
}

@end
