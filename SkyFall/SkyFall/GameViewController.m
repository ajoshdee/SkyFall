//
//  GameViewController.m
//  SkyFall
//
//  Created by Josh Dee on 10/15/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "GameViewController.h"
#import "PlayerController.h"

// Character Properties
int const playerWidth = 32;
int const playerHeight = 54;
@interface GameViewController ()

@end

@implementation GameViewController
- (id)init
{
    self = [super init];
    if (self) {
        PlayerController *playerView = [[PlayerController alloc] initWithFrame:CGRectMake(10, 10, playerWidth , playerHeight)];
        playerView.image = [UIImage imageNamed:@"duck.png"];
       playerView.userInteractionEnabled = YES;
        
        [self.view addSubview:playerView];
        [playerView release];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
