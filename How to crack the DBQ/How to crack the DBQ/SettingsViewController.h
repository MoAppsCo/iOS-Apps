//
//  SettingsViewController.h
//  how to crack the dbq
//
//  Created by Varun Iyer on 1/2/14.
//  Copyright (c) 2014 MoAppsCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <StoreKit/StoreKit.h>
#import "PurchasedViewController.h"
#import <iAd/iAd.h>

@interface SettingsViewController : UITableViewController < MFMailComposeViewControllerDelegate, ADBannerViewDelegate> {
    IBOutlet ADBannerView *iadBanner;
    IBOutlet UILabel *Label;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
- (IBAction)PurchaseItem:(id)sender;
@property (strong, nonatomic) PurchasedViewController *purchaseController;
-(void)Purchased;

@end
