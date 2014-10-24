//
//  GameOverViewController.m
//  SkyFall
//
//  Created by Josh Dee on 10/17/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "GameOverViewController.h"
#import "FileHandler.h"
#import "SharedScoreArray.h"

NSString *const alertTitle = @"New High Score!";
NSString *const alertMessage = @"Enter your name";
NSString *const alertOption = @"Done";
NSInteger const topTen = 10;

@interface GameOverViewController ()
{
    int i;
}
@property (retain, nonatomic) UIAlertView *highScoreMessage;
@property (retain, nonatomic) FileHandler *fileHandler;
@property (retain, nonatomic) NSString *playerName;
@property (assign, nonatomic) NSInteger scoreArrayCount;
@property (assign, nonatomic) NSNumber *highScore;

@end

@implementation GameOverViewController
- (IBAction)showGameScreen:(id)sender {
    [self.navigationController popToViewController:[self.navigationController viewControllers][1] animated:NO];
}

- (IBAction)showMainMenu:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.fileHandler = [[FileHandler alloc]init];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self checkHighScore];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlertView
{
    self.highScoreMessage =[[UIAlertView alloc ] initWithTitle:alertTitle
                                                    message:alertMessage
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles: alertOption, nil] ;
    self.highScoreMessage.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [self.highScoreMessage show];
    [_highScoreMessage release];

}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [self updateScore];
}

-(void)checkHighScore
{
   self.scoreArrayCount = [[SharedScoreArray sharedScoreArray].scoreArray count];
    
    for (i = 0; i< self.scoreArrayCount; i++) {

        self.highScore = [[SharedScoreArray sharedScoreArray].scoreArray objectAtIndex:i];
        
        if([_currentScore intValue] >= [self.highScore intValue] && self.scoreArrayCount <= topTen){
           
            [self showAlertView];
 
            return;
        }
    
    }
    
}

-(void)updateScore
{
    self.playerName = [self.highScoreMessage textFieldAtIndex:0].text;
    if((!self.playerName) || ([self.playerName  isEqual: @""])){
        [self showAlertView];
        return;
    }
    [[SharedScoreArray sharedScoreArray].nameArray insertObject:self.playerName atIndex:i];
    
    [[SharedScoreArray sharedScoreArray].scoreArray insertObject:_currentScore atIndex:i];
    NSInteger newScoreArrayCount = [[SharedScoreArray sharedScoreArray].scoreArray count];
   
    if(newScoreArrayCount > topTen ||[self.highScore intValue] == 0){
        [[SharedScoreArray sharedScoreArray].scoreArray removeLastObject];
        [[SharedScoreArray sharedScoreArray].nameArray removeLastObject];
    }
    
    [self.fileHandler writeToJSONFile];
    [_playerName release];
    [_highScore release];
}

- (void)dealloc {
    i = 0;
    
    [super dealloc];
}

@end
