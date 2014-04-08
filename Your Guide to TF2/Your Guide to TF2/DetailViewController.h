//
//  DetailViewController.h
//  Your Guide to TF2
//
//  Created by Varun Iyer on 4/6/14.
//  Copyright (c) 2014 MoAppsCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UIWebViewDelegate> {
    NSDictionary *item;
}

@property (retain, nonatomic) NSDictionary *item;
@property (retain, nonatomic) IBOutlet UIWebView *itemSummary;

@end
