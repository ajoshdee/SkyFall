//
//  GameOverViewController.m
//  SkyFall
//
//  Created by Josh Dee on 10/17/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "GameOverViewController.h"
<<<<<<< HEAD
#import "FileHandler.h"
=======

>>>>>>> dev_1.0
NSString *const dictionaryKey = @"high scores";

@interface GameOverViewController ()
@property (retain, nonatomic) UIAlertView *highScoreMessage;
<<<<<<< HEAD
@property (retain, nonatomic) FileHandler *fileHandler;
=======

>>>>>>> dev_1.0
@end

@implementation GameOverViewController
- (IBAction)showGameScreen:(id)sender {
    [self.navigationController popToViewController:[self.navigationController viewControllers][1] animated:NO];
}
- (IBAction)showMainMenu:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}
<<<<<<< HEAD
- (id)init
{
    self = [super init];
    if (self) {
        self.fileHandler = [[FileHandler alloc]init];
        _scoreArray = [[NSMutableArray alloc]init];
    }
    return self;
}

=======
/*- (id)init
{
    self = [super init];
    if (self) {
        <#statements#>
    }
    return self;
}
*/
>>>>>>> dev_1.0
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
<<<<<<< HEAD
    NSLog(@"%@", _currentScore);
    
    
   _scoreArray =  [self.fileHandler loadJSONFile:dictionaryKey];
    
    [self updateHighScore];

=======
>>>>>>> dev_1.0
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
<<<<<<< HEAD
    if([_scoreArray count] == 0){
        [_scoreArray insertObject:_currentScore atIndex:0];
        [self.fileHandler writeToJSONFile:_scoreArray usingKey:dictionaryKey];
    }
    for (int i = 0; i<=[_scoreArray count]; i++) {
        if( i == [_scoreArray count]){
            [_scoreArray addObject:_currentScore];
            [self.fileHandler writeToJSONFile:_scoreArray usingKey:dictionaryKey];
            NSLog(@"file saved2");
            return;
            
        }
        NSNumber *highScore = [_scoreArray objectAtIndex:i];
        
        NSLog(@"file will save %@", highScore);
        if([_currentScore intValue] > [highScore intValue]){
            [_scoreArray insertObject:_currentScore atIndex:i];
            if( [_scoreArray count] > 10){
            [_scoreArray removeLastObject];
            }
            [self showAlertView];
            [self.fileHandler writeToJSONFile:_scoreArray usingKey:dictionaryKey];
            NSLog(@"file saved1");
            return;
        }
    
        else{
            
            NSLog(@"file not saved");
        }
=======
    for (int i = 0; i<[_scoreArray count]; i++) {
        NSNumber *highScore = [_scoreArray objectAtIndex:i];
        if(_currentScore > highScore){
            [_scoreArray insertObject:_currentScore atIndex:i];
            [_scoreArray removeLastObject];
        }
      
>>>>>>> dev_1.0
    }
    
}

-(void)loadJSONFile
{
<<<<<<< HEAD
   NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[self JSONFilePath]];
     _scoreArray = [dictionary valueForKey:dictionaryKey];
=======
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[self JSONFilePath]];
    _scoreArray = [dictionary valueForKey:dictionaryKey];
>>>>>>> dev_1.0
    
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
<<<<<<< HEAD
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *filePath = [documentDirectories firstObject];
    
    filePath = [filePath stringByAppendingPathComponent: @"high_scores.json"];
    return filePath;
=======
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *filePath = [paths firstObject];
    
    return [filePath stringByAppendingPathComponent:@"high_scores.json"];
>>>>>>> dev_1.0
}

@end
