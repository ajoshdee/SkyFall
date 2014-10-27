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

#import "SharedScoreArray.h"

NSString *const errorTitle = @"Error";
NSString *const errorMessage = @"No High Score to Show";
NSString *const errorOption = @"Ok";

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
    
}

- (IBAction)showHighScore:(id)sender {
    
    NSString *firstNameInArray = [NSString stringWithFormat:@"%@",[[[SharedScoreArray sharedScoreArray]allNames] firstObject]];
    if ([firstNameInArray isEqualToString:@""]) {
        [self showAlertView];
    }
    else{
        HighScoresViewController *highScoreVC = [[HighScoresViewController alloc]init];
        [self.navigationController pushViewController:highScoreVC animated:NO];
        [highScoreVC release];
        
    }
}

-(void)showAlertView
{
    UIAlertView *errorAlert;
    errorAlert =[[[UIAlertView alloc ] initWithTitle:errorTitle
                                                        message:errorMessage
                                                        delegate:self
                                                        cancelButtonTitle:nil
                                                        otherButtonTitles: errorOption, nil] autorelease];
    
    [errorAlert show];
    
    
}

@end
