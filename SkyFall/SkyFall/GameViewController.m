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
#import "GameOverViewController.h"
// Character Properties
int const playerWidth = 32;
int const playerHeight = 54;


@interface GameViewController ()
@property (retain, nonatomic) fallingObject *fallObject;
@property (retain, nonatomic) PlayerController *player;
@property (retain, nonatomic) NSTimer *fallingObjectCollisionTimer;
@property (retain, nonatomic) NSTimer *floorCollisionTimer;
@end

@implementation GameViewController
- (id)init
{
    self = [super init];
    if (self) {
        PlayerController *playerView = [[PlayerController alloc] initWithFrame:CGRectMake(((self.view.frame.size.width/2)-(playerWidth/2)), (self.view.frame.size.height*0.75), playerWidth , playerHeight)];
        
        
        playerView.image = [UIImage imageNamed:@"duck.png"];
       playerView.userInteractionEnabled = YES;
        self.player = playerView;
        
        [self.view addSubview:self.player];
        
        [self.scoreLabel setText:[NSString stringWithFormat:@"%i", _score]];
        
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
    self.fallObject = [[[fallingObject alloc] init] autorelease];

    self.fallingObjectCollisionTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1
                                     target: self
                                   selector: @selector(checkCollision:)
                                   userInfo: nil
                                    repeats: YES];
    self.floorCollisionTimer = [NSTimer scheduledTimerWithTimeInterval: 0.8
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
            [self gameOver];
        }
        else if (!CGRectIntersectsRect([[theView.layer presentationLayer] frame], self.view.frame)){
            [self.fallObject.fallingObjectArray removeObjectAtIndex:i];
            //[self.fallObject destroyFallingObject];
            _score++;
            [self.scoreLabel setText:[NSString stringWithFormat:@"%i", _score]];

        }
            }
}

-(void)gameOver{
    GameOverViewController *gameOverViewController = [[GameOverViewController alloc] init];
    NSLog(@"score: %i", _score);
    NSNumber *score = [[NSNumber alloc]initWithInt:_score];
    [gameOverViewController setCurrentScore:score];
     [self.navigationController pushViewController:gameOverViewController animated:NO];
    [gameOverViewController release];
    gameOverViewController = nil;
    [self resetGame];
    [score release];

}

- (void)resetGame
{
    [self.fallingObjectCollisionTimer invalidate];
    [self.floorCollisionTimer invalidate];
    [self setScore:0];
    [self.scoreLabel setText:[NSString stringWithFormat:@"%i", _score]];
    

}

- (void)dealloc {
    [_highScoreLabel release];
    [_energyLabel release];
    [_scoreLabel release];
    [super dealloc];
}
@end
