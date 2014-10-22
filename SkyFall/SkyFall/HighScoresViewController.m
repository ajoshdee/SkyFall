//
//  HighScoresViewController.m
//  SkyFall
//
//  Created by Josh Dee on 10/20/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "HighScoresViewController.h"
#import "FileHandler.h"
@interface HighScoresViewController ()
@property(retain,nonatomic) NSMutableArray *scoreArray;
@property(retain,nonatomic) FileHandler *fileHandler;
@end

@implementation HighScoresViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
        self.fileHandler = [[[FileHandler alloc]init]autorelease];
        _scoreArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.fileHandler loadJSONFile];
    self.title = @"High Scores";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return [[self.fileHandler scoreArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    
    [cell.textLabel setText:[[self.fileHandler scoreArray] objectAtIndex:indexPath.row]];
    
    // Configure the cell...
    
    return cell;
    
 
}

@end
