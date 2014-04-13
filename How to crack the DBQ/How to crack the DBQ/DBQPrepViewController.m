//
//  DBQPrepViewController.m
//  how to crack the dbq
//
//  Created by Varun Iyer on 12/29/13.
//  Copyright (c) 2013 MoAppsCo. All rights reserved.
//

#import "DBQPrepViewController.h"
#import "SWRevealViewController.h"
#import "DBQPrepDetailViewController.h"
#import "DBQ1.h"

@interface DBQPrepViewController ()

@end

@implementation DBQPrepViewController

NSArray *preps;

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
    [self.tableView1 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
    self.tableView1.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.7f];
    
    // Add pan gesture to hide the sidebar
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    
    DBQ1 *prep1 = [DBQ1 new];
    prep1.DBQNameCell1 = @"DBQ Organization Chart";
    prep1.DBQPdf1 = @"DBQOrganizationChart";
    
    DBQ1 *prep2 = [DBQ1 new];
    prep2.DBQNameCell1 = @"Must Dos - DBQ";
    prep2.DBQPdf1 = @"Must Do Essay Checklist DBQ";
    
    DBQ1 *prep3 = [DBQ1 new];
    prep3.DBQNameCell1 = @"Thesis Killer Words";
    prep3.DBQPdf1 = @"Thesis Killer Words (3)";
    
    DBQ1 *prep4 = [DBQ1 new];
    prep4.DBQNameCell1 = @"DBQ Progression Chart";
    prep4.DBQPdf1 = @"DBQ Progression";
    
    DBQ1 *prep5 = [DBQ1 new];
    prep5.DBQNameCell1 = @"AP World History Writing Packet";
    prep5.DBQPdf1 = @"Writing Packet 2013";
    
    
    preps = [NSArray arrayWithObjects: prep1, prep2, prep3, prep4, prep5, Nil];

	// Do any additional setup after loading the view.
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

- (void)bannerView:(ADBannerView *)
banner didFailToReceiveAdWithError:(NSError *)error
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [preps count];
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display recipe in the table cell
    DBQ1 *prep = [preps objectAtIndex:indexPath.row];
    
    UILabel *PrepNameLabel = (UILabel *)[cell viewWithTag:100];
    PrepNameLabel.text = prep.DBQNameCell1;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPrepDetail"]) {
        NSIndexPath *indexPath = [self.tableView1 indexPathForSelectedRow];
        DBQPrepDetailViewController *destViewController = segue.destinationViewController;
        destViewController.prep = [preps objectAtIndex:indexPath.row];
    }
}


@end
