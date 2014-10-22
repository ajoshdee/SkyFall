//
//  MainMenuViewController.m
//  SkyFall
//
//  Created by Josh Dee on 10/17/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "MainMenuViewController.h"
#import "GameViewController.h"
#import "HighScoresViewController.h"
@interface MainMenuViewController ()

@end

@implementation MainMenuViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playButton:(id)sender {
    GameViewController *gameViewController = [[GameViewController alloc] init];
    [self.navigationController pushViewController:gameViewController animated:NO];
    [gameViewController release];
    gameViewController = nil;
}
- (IBAction)showHighScore:(id)sender {
    HighScoresViewController *highScoreVC = [[HighScoresViewController alloc]init];
    [self.navigationController pushViewController:highScoreVC animated:NO];
    [highScoreVC release];
    highScoreVC = nil;
}

@end
