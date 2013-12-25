//
//  DBQExamplesViewController.m
//  How to crack the DBQ
//
//  Created by Varun Iyer on 12/5/13.
//  Copyright (c) 2013 MoAppsCo. All rights reserved.
//

#import "DBQExamplesViewController.h"
#import "SWRevealViewController.h"
#import "DBQDetailViewController.h"
#import "DBQ.h"

@interface DBQExamplesViewController ()



@end



@implementation DBQExamplesViewController {

NSArray *dbqs;
    
}

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
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.5f alpha:0.2f];
    
    // Add pan gesture to hide the sidebar
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    
    DBQ *dbq1 = [DBQ new];
    dbq1.DBQNameCell = @"2011 Green Revolution";
    dbq1.DBQDescriptionCell = @"Annotated";
    dbq1.DBQImage = @"2011 DBQ Annotated.pdf";
    
    
    
    dbqs = [NSArray arrayWithObjects: dbq1, Nil];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

        return [dbqs count];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display recipe in the table cell
    DBQ *dbq = [dbqs objectAtIndex:indexPath.row];
    
    UILabel *DBQNameLabel = (UILabel *)[cell viewWithTag:100];
    DBQNameLabel.text = dbq.DBQNameCell;
    
    UILabel *DBQDescriptionLabel = (UILabel *)[cell viewWithTag:101];
    DBQDescriptionLabel.text = dbq.DBQDescriptionCell;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDBQDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DBQDetailViewController *destViewController = segue.destinationViewController;
        destViewController.dbq = [dbqs objectAtIndex:indexPath.row];
    }
}



@end