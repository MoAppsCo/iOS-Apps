//
//  PurchasedViewController.h
//  how to crack the dbq
//
//  Created by Varun Iyer on 1/7/14.
//  Copyright (c) 2014 MoAppsCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface PurchasedViewController : UIViewController<SKPaymentTransactionObserver,SKProductsRequestDelegate> {
}
@property (strong, nonatomic) SKProduct *product;
@property (strong, nonatomic) NSString *productID;
@property (strong, nonatomic) IBOutlet UILabel *productTitle;
@property (strong, nonatomic) IBOutlet UITextView *productDescription;
@property (strong, nonatomic) IBOutlet UIButton *buyButton;

- (IBAction)Restore:(id)sender;
- (IBAction)BuyProduct:(id)sender;
- (IBAction)GoBack:(id)sender;

-(void)getProductID:(UIViewController *)viewController;

@end
