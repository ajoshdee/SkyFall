//
//  GameViewController.m
//  SkyFall
//
//  Created by Josh Dee on 10/15/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "GameViewController.h"
#import "PlayerController.h"
#import "fallingObject.h"
// Character Properties
int const playerWidth = 32;
int const playerHeight = 54;


@interface GameViewController ()
@property (retain, nonatomic) fallingObject *fallObject;
@property (retain, nonatomic) PlayerController *player;
@end

@implementation GameViewController
- (id)init
{
    self = [super init];
    if (self) {
        PlayerController *playerView = [[PlayerController alloc] initWithFrame:CGRectMake(((self.view.frame.size.width/2)-(playerWidth/2)), (self.view.frame.size.height*0.75), playerWidth , playerHeight)];
        
          self.fallObject = [[[fallingObject alloc] init] autorelease];
        playerView.image = [UIImage imageNamed:@"duck.png"];
       playerView.userInteractionEnabled = YES;
        self.player = playerView;
        
        [self.view addSubview:self.player];
        
       
        
        [playerView release];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [NSTimer scheduledTimerWithTimeInterval: 0.3
                                     target: self
                                   selector: @selector(checkCollision:)
                                   userInfo: nil
                                    repeats: YES];
    [NSTimer scheduledTimerWithTimeInterval: 0.8
                                     target: self
                                   selector: @selector(addObject)
                                   userInfo: nil
                                    repeats: YES];

}

- (void)addObject
{
[self.fallObject createFallingObject: self.view withCount:1];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) checkCollision: (NSTimer *) theTimer{
    for(int i = 0; i < [self.fallObject.fallingObjectArray count]; i++) {
        UIImageView *theView = [self.fallObject.fallingObjectArray objectAtIndex:i];
        if (CGRectIntersectsRect([[theView.layer presentationLayer] frame], self.player.frame)) {
           NSLog(@"HIT");
        }
        else if (!CGRectIntersectsRect([[theView.layer presentationLayer] frame], self.view.frame)){
            [self.fallObject.fallingObjectArray removeObjectAtIndex:i];

            score++;
            [self.scoreLabel setText:[NSString stringWithFormat:@"%i", score]];

        }
            }
}


- (void)dealloc {
    [_highScoreLabel release];
    [_energyLabel release];
    [_scoreLabel release];
    [super dealloc];
}
@end
