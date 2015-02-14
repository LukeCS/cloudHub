//
//  WebViewController.h
//  cloudHub
//
//  Created by Luke Kartsolis on 09/02/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
{
    NSMutableData *receivedData;
}

@property (nonatomic, retain) UIWebView *loginView;
@property (nonatomic, retain) UILabel   *label3;
@end

