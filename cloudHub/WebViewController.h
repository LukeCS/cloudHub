//
//  WebViewController.h
//  cloudHub
//
//  Created by Luke Kartsolis on 09/02/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthConsumer.h"
#import "AppDelegate.h"
#import "SBJsonParser.h"


@interface WebViewController : UIViewController
{
    OAConsumer* consumer;
    OAToken* requestToken;
    OAToken* accessToken;
    NSMutableData *receivedData;
}

@property (nonatomic, retain) UIWebView *loginWebView;
@property (nonatomic, retain) UILabel   *label3;
@property (nonatomic, retain) NSString *isLogin;
@end

