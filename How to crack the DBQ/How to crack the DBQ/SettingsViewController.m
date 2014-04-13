//
//  SettingsViewController.m
//  how to crack the dbq
//
//  Created by Varun Iyer on 1/2/14.
//  Copyright (c) 2014 MoAppsCo. All rights reserved.
//

#import "SettingsViewController.h"
#import "SWRevealViewController.h"
#define k_Save @"Saveitem1"


@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.7f];
    NSUserDefaults *saveapp = [NSUserDefaults standardUserDefaults];
    bool saved = [saveapp boolForKey:k_Save];
    if (!saved) {
        /// not save code here
    } else {
        ///saved code here
        Label.text = @"Item has been purchased.";
    }
    // Add pan gesture to hide the sidebar
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
	// Do any additional setup after loading the view.

}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    NSUserDefaults *saveapp = [NSUserDefaults standardUserDefaults];
    bool saved = [saveapp boolForKey:k_Save];
    if (!saved) {
        /// not save code here
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        [banner setAlpha:1];
        [UIView commitAnimations];
    } else {
        ///saved code here
    }
}
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}

 


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0 && indexPath.section == 3){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://howtocrackthedbq.blogspot.com/"]];
    } else if(indexPath.row == 1 && indexPath.section == 1){
             if ([MFMailComposeViewController canSendMail]) {
                 MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
                 mailViewController.mailComposeDelegate = self;
                 [mailViewController setSubject:@"[How to crack the DBQ] Support request"];
                 [mailViewController setToRecipients:[NSArray arrayWithObject:@"moappsco@gmail.com"]];
                 [self presentModalViewController:mailViewController animated:YES];
             }
              }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PurchaseItem:(id)sender {
    
    _purchaseController = [self.storyboard instantiateViewControllerWithIdentifier:@"PurchaseViewController"];
    _purchaseController.productID = @"com.moappsco.crackingthedbq.dbq1";
    [[SKPaymentQueue defaultQueue] addTransactionObserver:_purchaseController];
    [self presentViewController:_purchaseController animated:YES completion:NULL];
    [_purchaseController getProductID:self];
}

-(void)Purchased {
    Label.text = @"Item has been purchased.";
    iadBanner.hidden = YES;
    NSUserDefaults *saveapp = [NSUserDefaults standardUserDefaults];
    [saveapp setBool:TRUE forKey:k_Save];
    [saveapp synchronize];
}

@end
