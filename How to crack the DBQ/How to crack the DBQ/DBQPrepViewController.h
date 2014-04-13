//
//  DBQPrepViewController.h
//  how to crack the dbq
//
//  Created by Varun Iyer on 12/29/13.
//  Copyright (c) 2013 MoAppsCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface DBQPrepViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) IBOutlet UITableView *tableView1;

@end
