//
//  GameOverViewController.m
//  SkyFall
//
//  Created by Josh Dee on 10/17/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "GameOverViewController.h"
#import "FileHandler.h"

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
        self.fileHandler = [[[FileHandler alloc]init]autorelease];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.fileHandler loadJSONFile];
    [self checkHighScore];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlertView
{
    self.highScoreMessage =[[[UIAlertView alloc ] initWithTitle:alertTitle
                                                    message:alertMessage
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles: alertOption, nil] autorelease];
    self.highScoreMessage.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [self.highScoreMessage show];


}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self updateScore];
}

-(void)checkHighScore
{
   self.scoreArrayCount = [[self.fileHandler scoreArray] count];
    
    for (i = 0; i< self.scoreArrayCount; i++) {

        self.highScore = [[self.fileHandler scoreArray] objectAtIndex:i];
        
        if([_currentScore intValue] >= [self.highScore intValue] && self.scoreArrayCount <= topTen){
           
            [self showAlertView];
 
            return;
        }
    
    }
    self.fileHandler = nil;
}

-(void)updateScore
{
    self.playerName = [self.highScoreMessage textFieldAtIndex:0].text;
    NSLog(@"Myname %@", self.playerName);
    [[self.fileHandler nameArray] insertObject:self.playerName atIndex:i];
    NSLog(@"name %@", [self.fileHandler nameArray]);
    [[self.fileHandler scoreArray] insertObject:_currentScore atIndex:i];
    
    if([self.highScore intValue] == 0){
        [[self.fileHandler scoreArray] removeLastObject];
        [[self.fileHandler nameArray] removeLastObject];
    }
    
    
    [self.fileHandler writeToJSONFile];
}

- (void)dealloc {
    i = 0;

    [super dealloc];
}

@end
