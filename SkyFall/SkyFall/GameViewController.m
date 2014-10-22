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
#import "FileHandler.h"
// Character Properties
int const playerWidth = 32;
int const playerHeight = 54;
double const fallingObjectInterval = 0.1;
double const floorCollisionInterval = 0.8;

@interface GameViewController ()
@property (retain, nonatomic) FallingObject *fallObject;
@property (retain, nonatomic) PlayerController *player;
@property (retain, nonatomic) NSTimer *fallingObjectCollisionTimer;
@property (retain, nonatomic) NSTimer *floorCollisionTimer;
@property (assign, nonatomic) CGRect playerFrame;
@property (assign, nonatomic) NSInteger fallingObjectCount;
@property (retain, nonatomic) FileHandler *fileHandler;
@end

@implementation GameViewController
- (id)init
{
    self = [super init];
    if (self) {
        self.fileHandler = [[[FileHandler alloc]init]autorelease];
        
        self.playerFrame = CGRectMake(((self.view.frame.size.width/2)-(playerWidth/2)), (self.view.frame.size.height*0.75), playerWidth , playerHeight);
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
    
    [self.fileHandler loadJSONFile];
    
    int highScore = [[[self.fileHandler scoreArray] firstObject] intValue];

    [self.highScoreLabel setText:[NSString stringWithFormat:@"%i", highScore]];
    
    self.fallObject = [[[FallingObject alloc] init] autorelease];

    self.fallingObjectCollisionTimer = [NSTimer scheduledTimerWithTimeInterval: fallingObjectInterval
                                     target: self
                                     selector: @selector(checkCollision:)
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
[self.fallObject createFallingObject: self.view withCount:2];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) checkCollision: (NSTimer *) theTimer{
   _fallingObjectCount =[self.fallObject.fallingObjectArray count];
   
    for(int i = 0; i < _fallingObjectCount; i++) {
        UIImageView *theView = [self.fallObject.fallingObjectArray objectAtIndex:i];
        _fallingObjectCount =[self.fallObject.fallingObjectArray count];
        
        if (CGRectIntersectsRect([[theView.layer presentationLayer] frame], self.player.frame)) {
          
            [self gameOver];
        }
        
        if (!CGRectIntersectsRect([[theView.layer presentationLayer] frame], self.view.frame)){
            [self.fallObject.fallingObjectArray removeObjectAtIndex:i];
            
            _score++;
            [self.scoreLabel setText:[NSString stringWithFormat:@"%i", _score]];

        }
    }
}

-(void)gameOver{
    
    GameOverViewController *gameOverViewController = [[GameOverViewController alloc] init];
   
    NSLog(@"score: %i", _score);
    
   
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
    [self.scoreLabel setText:[NSString stringWithFormat:@"%i", _score]];
    

}

- (void)dealloc {
    self.highScoreLabel = nil;
    self.energyLabel = nil;
    self.scoreLabel = nil;
    [super dealloc];
}
@end
