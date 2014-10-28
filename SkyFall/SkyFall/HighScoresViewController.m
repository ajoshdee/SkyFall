//
//  HighScoresViewController.m
//  SkyFall
//
//  Created by Josh Dee on 10/20/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "HighScoresViewController.h"
#import "SharedScoreArray.h"

NSString *const title = @"High Scores";

@interface HighScoresViewController ()

@end

@implementation HighScoresViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = title;
    self.tableView.scrollEnabled = NO;
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
    
    return [[[SharedScoreArray sharedScoreArray] allScores] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier]autorelease];
    }
    
    NSArray *scores = [[SharedScoreArray sharedScoreArray]allScores];
    NSArray *names = [[SharedScoreArray sharedScoreArray]allNames];
    
    [cell.textLabel setText:[names objectAtIndex:indexPath.row]];
    
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",[scores objectAtIndex:indexPath.row]]];
    
    return cell;
    
 
}

@end
