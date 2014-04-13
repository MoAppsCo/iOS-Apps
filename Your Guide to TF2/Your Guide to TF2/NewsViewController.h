//
//  NewsViewController.h
//  Your Guide to TF2
//
//  Created by Varun Iyer on 3/30/14.
//  Copyright (c) 2014 MoAppsCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
NSArray *items;
NSMutableArray *itemArray;
}

@property (retain, nonatomic) NSArray *items;
@property (retain, nonatomic) NSMutableArray *itemArray;
@property (weak, nonatomic) IBOutlet UITableView *tblNews;

- (IBAction)removeDataFile:(id)sender;

-(void)fetchNewDataWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end
