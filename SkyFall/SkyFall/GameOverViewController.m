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

@interface GameOverViewController ()
@property (retain, nonatomic) UIAlertView *highScoreMessage;
@property (retain, nonatomic) FileHandler *fileHandler;
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
    [self updateHighScore];

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
    
}

-(void)updateHighScore
{
    NSInteger scoresArrayCount = [[self.fileHandler scoreArray] count];
    
    for (int i = 0; i<= scoresArrayCount; i++) {
        if( i == scoresArrayCount){
            [[self.fileHandler scoreArray] addObject:_currentScore];
            
            [self.fileHandler writeToJSONFile];
            
            return;
            
        }
        NSNumber *highScore = [[self.fileHandler scoreArray] objectAtIndex:i];
        
        
        if([_currentScore intValue] >= [highScore intValue]){
           
            [self showAlertView];
            
            NSString *playerName = [self.highScoreMessage textFieldAtIndex:0].text;
            
            [[self.fileHandler nameArray] insertObject:playerName atIndex:i];
            NSLog(@"name %@", [self.fileHandler nameArray]);
            [[self.fileHandler scoreArray] insertObject:_currentScore atIndex:i];
            
            if( scoresArrayCount > 10 || [highScore intValue] == 0){
                [[self.fileHandler scoreArray] removeLastObject];
                [[self.fileHandler nameArray] removeLastObject];
            }
            
            
           [self.fileHandler writeToJSONFile];
            
           
            return;
        }
    
    }
    self.fileHandler = nil;
}

@end
