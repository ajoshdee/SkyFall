//
//  PlayerController.m
//  SkyFall
//
//  Created by Josh Dee on 10/15/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "PlayerController.h"

@implementation PlayerController

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image])
        self.userInteractionEnabled = YES;
    return self;
}
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    // When a touch starts, get the current location in the view
    currentPoint = [[touches anyObject] locationInView:self];
}
- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    // Get active location upon move
    CGPoint activePoint = [[touches anyObject] locationInView:self];
    
    // Determine new point based on where the touch is now located
    CGPoint newPoint = CGPointMake(self.center.x + (activePoint.x - currentPoint.x),
                                   self.center.y + (activePoint.y - currentPoint.y));
    
    
    // Make sure we stay within the bounds of the parent view
    
    float midPointX = CGRectGetMidX(self.bounds);
    CGFloat pointX = newPoint.x;
    
    float midPointY = CGRectGetMidY(self.bounds);
    CGFloat pointY = newPoint.y;
    
    
    newPoint.x = [self playerBounds:pointX MidPoint:midPointX Size:self.superview.bounds.size.width];
    
    newPoint.y = [self playerBounds:pointY MidPoint:midPointY Size:self.superview.bounds.size.height];
    
    /*
    // right screen bounds
    if (newPoint.x > self.superview.bounds.size.width  - midPointX)
        newPoint.x = self.superview.bounds.size.width - midPointX;
    else if (newPoint.x < midPointX)  // left screen bounds
        newPoint.x = midPointX;
    
    
    // bottom screen bounds
    if (newPoint.y > self.superview.bounds.size.height  - midPointY)
        newPoint.y = self.superview.bounds.size.height - midPointY;
    else if (newPoint.y < midPointY)  // top screen bounds
        newPoint.y = midPointY;
    */
    // Set new center location
    self.center = newPoint;
}

- (CGFloat)playerBounds:(CGFloat)newPoint MidPoint:(float)midPoint Size:(CGFloat)bounds

{
    if (newPoint > bounds  - midPoint)
        newPoint = bounds - midPoint;
    else if (newPoint < midPoint)
        newPoint = midPoint;
    
    return newPoint;
}

@end
