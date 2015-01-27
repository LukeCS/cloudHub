//
//  ViewController.h
//  cloudHub
//
//  Created by Luke Kartsolis on 25/10/2014.
//  Copyright (c) 2014 Luke Kartsolis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate, NSURLConnectionDataDelegate>

typedef enum {
    httpMethod_GET,
    httpMethod_POST,
    httpMethod_DELETE,
    httpMethod_PUT
} HTTP_Method;

@property (nonatomic, retain) UIWebView *loginView;
@property (nonatomic, retain) UIButton  *loginButton;
@property (nonatomic, retain) UILabel   *label1;
@property (nonatomic, retain) UILabel   *label2;
@property (nonatomic, retain) UILabel   *label3;
@property (nonatomic, retain) UITapGestureRecognizer *tapArea;

@end

