//
//  ShipViewController.h
//  FTL Survival Guide
//
//  Created by Rohan on 1/10/14.
//  Copyright (c) 2014 Rohan Patel, Nishanth Shanmugham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShipViewController : UITableViewController
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
