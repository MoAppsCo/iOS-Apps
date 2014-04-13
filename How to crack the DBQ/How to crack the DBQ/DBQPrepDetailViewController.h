//
//  DBQPrepDetailViewController.h
//  how to crack the dbq
//
//  Created by Varun Iyer on 12/29/13.
//  Copyright (c) 2013 MoAppsCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBQ1.h"

@interface DBQPrepDetailViewController : UIViewController
{
    IBOutlet UIWebView *myWebView1;
}
@property (nonatomic, retain) IBOutlet UIWebView *myWebView1;

@property (nonatomic, strong) DBQ1 *prep;

@end
