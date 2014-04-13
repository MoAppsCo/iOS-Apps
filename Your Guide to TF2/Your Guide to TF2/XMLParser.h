//
//  XMLParser.h
//  Your Guide to TF2
//
//  Created by Varun Iyer on 3/30/14.
//  Copyright (c) 2014 MoAppsCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParser : NSObject <NSXMLParserDelegate> {
    NSMutableDictionary *item;
    NSMutableString * currentLink;
}

@property (retain, nonatomic) NSMutableString *currentLink;

-(id)initWithXMLURLString:(NSString *)xmlUrlString;
-(void)startParsingWithCompletionHandler:(void(^)(BOOL success, NSArray *dataArray, NSError *error))completionHandler;

@end
