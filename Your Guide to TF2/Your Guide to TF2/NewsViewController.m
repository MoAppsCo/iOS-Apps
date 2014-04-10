//
//  NewsViewController.m
//  Your Guide to TF2
//
//  Created by Varun Iyer on 3/30/14.
//  Copyright (c) 2014 MoAppsCo. All rights reserved.
//

#import "NewsViewController.h"
#define NewsFeed @"http://www.teamfortress.com/rss.xml"
#import "XMLParser.h"
#import "DetailViewController.h"


@interface NewsViewController ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *arrNewsData;
@property (nonatomic, strong) NSString *dataFilePath;
-(void)refreshData;
-(void)performNewFetchedDataActionsWithDataArray:(NSArray *)dataArray;

@end

@implementation NewsViewController

@synthesize items, itemArray;


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
    // 1. Make self the delegate and datasource of the table view.
    [self.tblNews setDelegate:self];
    [self.tblNews setDataSource:self];
    
    // 2. Specify the data storage file path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    self.dataFilePath = [docDirectory stringByAppendingPathComponent:@"newsdata"];
    
    // 3. Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self
                            action:@selector(refreshData)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.tblNews addSubview:self.refreshControl];
    
    
    // 4. Load any saved data.
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.dataFilePath]) {
        self.arrNewsData = [[NSMutableArray alloc] initWithContentsOfFile:self.dataFilePath];
        
        [self.tblNews reloadData];
    }
    
}

- (IBAction)removeDataFile:(id)sender {
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.dataFilePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:self.dataFilePath error:nil];
        
        self.arrNewsData = nil;
        
        [self.tblNews reloadData];
    }
}

-(void)refreshData{
    XMLParser *xmlParser = [[XMLParser alloc] initWithXMLURLString:NewsFeed];
    [xmlParser startParsingWithCompletionHandler:^(BOOL success, NSArray *dataArray, NSError *error) {
        
        if (success) {
            [self performNewFetchedDataActionsWithDataArray:dataArray];
            
            [self.refreshControl endRefreshing];
        }
        else{
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

-(void)performNewFetchedDataActionsWithDataArray:(NSArray *)dataArray{
    // 1. Initialize the arrNewsData array with the parsed data array.
    if (self.arrNewsData != nil) {
        self.arrNewsData = nil;
    }
    self.arrNewsData = [[NSArray alloc] initWithArray:dataArray];
    
    // 2. Reload the table view.
    [self.tblNews reloadData];
    
    // 3. Save the data permanently to file.
    if (![self.arrNewsData writeToFile:self.dataFilePath atomically:YES]) {
        NSLog(@"Couldn't save data.");
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrNewsData.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellNewsTitle"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idCellNewsTitle"];
    }
    
    NSDictionary *dict = [self.arrNewsData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dict objectForKey:@"title"];
    cell.detailTextLabel.text = [dict objectForKey:@"pubDate"];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}




- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"detail"]){
        
        
        DetailViewController *detail = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tblNews indexPathForSelectedRow];
        detail.item = [self.arrNewsData objectAtIndex:indexPath.row];
        
    }
}

-(void)fetchNewDataWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    XMLParser *xmlParser = [[XMLParser alloc] initWithXMLURLString:NewsFeed];
    [xmlParser startParsingWithCompletionHandler:^(BOOL success, NSArray *dataArray, NSError *error) {
        if (success) {
            NSDictionary *latestDataDict = [dataArray objectAtIndex:0];
            NSString *latestTitle = [latestDataDict objectForKey:@"title"];
            
            NSDictionary *existingDataDict = [self.arrNewsData objectAtIndex:0];
            NSString *existingTitle = [existingDataDict objectForKey:@"title"];
            
            if ([latestTitle isEqualToString:existingTitle]) {
                completionHandler(UIBackgroundFetchResultNoData);
                
                NSLog(@"No new data found.");
            }
            else{
                [self performNewFetchedDataActionsWithDataArray:dataArray];
                
                completionHandler(UIBackgroundFetchResultNewData);
                
                NSLog(@"New data was fetched.");
            }
        }
        else{
            completionHandler(UIBackgroundFetchResultFailed);
            
            NSLog(@"Failed to fetch new data.");
        }
    }];
}

@end
