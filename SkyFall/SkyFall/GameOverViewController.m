//
//  GameOverViewController.m
//  SkyFall
//
//  Created by Josh Dee on 10/17/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "GameOverViewController.h"

NSString *const dictionaryKey = @"high scores";

@interface GameOverViewController ()
@property (retain, nonatomic) UIAlertView *highScoreMessage;

@end

@implementation GameOverViewController
- (IBAction)showGameScreen:(id)sender {
    [self.navigationController popToViewController:[self.navigationController viewControllers][1] animated:NO];
}
- (IBAction)showMainMenu:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}
/*- (id)init
{
    self = [super init];
    if (self) {
        <#statements#>
    }
    return self;
}
*/
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
-(void)showAlertView
{
    self.highScoreMessage =[[[UIAlertView alloc ] initWithTitle:@"New High Score!"
                                                    message:@"Enter your name"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles: @"Done", nil] autorelease];
    self.highScoreMessage.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [self.highScoreMessage show];


}

-(void)updateHighScore
{
    for (int i = 0; i<[_scoreArray count]; i++) {
        NSNumber *highScore = [_scoreArray objectAtIndex:i];
        if(_currentScore > highScore){
            [_scoreArray insertObject:_currentScore atIndex:i];
            [_scoreArray removeLastObject];
        }
      
    }
    
}

-(void)loadJSONFile
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[self JSONFilePath]];
    _scoreArray = [dictionary valueForKey:dictionaryKey];
    
}

-(void)writeToJSONFile
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObject:_scoreArray
                                                                         forKey:dictionaryKey];
    [[NSString stringWithFormat:@"%@",dictionary] writeToFile:[self JSONFilePath]
                                                   atomically:YES
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    
}

-(NSString *)JSONFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *filePath = [paths firstObject];
    
    return [filePath stringByAppendingPathComponent:@"high_scores.json"];
}

@end
