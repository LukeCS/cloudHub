//
//  ViewController.h
//  Gitty
//
//  Created by Luke Kartsolis on 09/02/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHUser;
@interface ViewController : UIViewController {
    
}

- (IBAction)Signin;

@property (nonatomic, retain) UIButton  *loginButton;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UILabel *welcomeLabel;
//@property (nonatomic, retain) NSString *accessToken;

@end

