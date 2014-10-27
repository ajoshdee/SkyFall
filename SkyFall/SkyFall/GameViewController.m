//
//  GameViewController.m
//  SkyFall
//
//  Created by Josh Dee on 10/15/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "GameViewController.h"
#import "PlayerController.h"
#import "FallingObject.h"
#import "GameOverViewController.h"

#import "SharedScoreArray.h"

// Character Properties
int const playerWidth = 38;
int const playerHeight = 65;

//falling object property
int const numberOfObjects = 2;

//collison detection
double const fallingObjectInterval = 0.1;
double const floorCollisionInterval = 0.8;

@interface GameViewController ()
@property (retain, nonatomic) FallingObject *fallObject;
@property (retain, nonatomic) PlayerController *player;
@property (retain, nonatomic) NSTimer *fallingObjectCollisionTimer;
@property (retain, nonatomic) NSTimer *floorCollisionTimer;
@property (assign, nonatomic) CGRect playerFrame;
@property (nonatomic, assign) int score;
@end

@implementation GameViewController
- (id)init
{
    self = [super init];
    if (self) {
        
        self.playerFrame = CGRectMake(((self.view.frame.size.width/2)-(playerWidth/2)), (self.view.frame.size.height*0.70), playerWidth , playerHeight);
        PlayerController *playerView = [[PlayerController alloc] initWithFrame:self.playerFrame];
        
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
    self.fallObject = [[[FallingObject alloc] init] autorelease];
    int highScore = [[[[SharedScoreArray sharedScoreArray]allScores] firstObject] intValue];

    [self.highScoreLabel setText:[NSString stringWithFormat:@"%i", highScore]];
    
    

    self.fallingObjectCollisionTimer = [NSTimer scheduledTimerWithTimeInterval: fallingObjectInterval
                                     target: self
                                     selector: @selector(checkCollision)
                                     userInfo: nil
                                     repeats: YES];
    
    self.floorCollisionTimer = [NSTimer scheduledTimerWithTimeInterval: floorCollisionInterval
                                     target: self
                                     selector: @selector(addObject)
                                     userInfo: nil
                                     repeats: YES];

}

- (void)addObject
{
    [self.fallObject createFallingObject: self.view withCount:numberOfObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) checkCollision{
    
   NSInteger fallingObjectCount  =[self.fallObject.fallingObjectArray count];
   
    for(int i = 0; i < fallingObjectCount; i++) {
        UIImageView *theView = [self.fallObject.fallingObjectArray objectAtIndex:i];
        
        fallingObjectCount =[self.fallObject.fallingObjectArray count];
        
        if ([self isColliding:[[theView.layer presentationLayer] frame] withSecondFrame:self.player.frame]) {
          
            [self gameOver];
        }
   
        if (![self isColliding:[[theView.layer presentationLayer] frame] withSecondFrame:self.view.frame]){
            [self.fallObject.fallingObjectArray removeObjectAtIndex:i];
            
            _score++;
            [self.scoreLabel setText:[NSString stringWithFormat:@"%i", _score]];

        }
    }
}

- (BOOL) isColliding:(CGRect)firstFrame withSecondFrame:(CGRect)secondFrame {
    return CGRectIntersectsRect(firstFrame, secondFrame);
}

-(void)gameOver{
    
    GameOverViewController *gameOverViewController = [[GameOverViewController alloc] init];
   
    gameOverViewController.currentScore = [NSNumber numberWithInt:_score];
       
    [self.navigationController pushViewController:gameOverViewController animated:NO];
    
    [gameOverViewController release];
    gameOverViewController = nil;
    
    [self resetGame];
    

}

- (void)resetGame
{
    [self.fallingObjectCollisionTimer invalidate];
    [self.floorCollisionTimer invalidate];

    [self setScore:0];
    self.fallObject = nil;
    [self.scoreLabel setText:[NSString stringWithFormat:@"%i", _score]];
    self.player.frame = self.playerFrame;    

}

- (void)dealloc {
    self.highScoreLabel = nil;
    self.energyLabel = nil;
    self.scoreLabel = nil;
    
    [_fallingObjectCollisionTimer release];
    [_floorCollisionTimer release];
    
    [super dealloc];
}
@end
