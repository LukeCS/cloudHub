//
//  ViewController.m
//  Gitty
//
//  Created by Luke Kartsolis on 09/02/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "TableViewController.h"
#import "GHUser.h"
#import "RestKit/Restkit.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.welcomeLabel = [[UILabel alloc] init];
    self.welcomeLabel.frame = CGRectMake(0.0, 50.0, self.view.frame.size.width, 540.0);
    self.welcomeLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:24.0];
    self.welcomeLabel.textColor = [UIColor darkGrayColor];
    self.welcomeLabel.textAlignment = NSTextAlignmentCenter;
    self.welcomeLabel.text = @"Welcome, please sign in";
    [self.view addSubview:self.welcomeLabel];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.loginButton setTitle:@"Sign in via GitHub" forState:UIControlStateNormal];
    self.loginButton.frame = CGRectMake(0, 20, 320, 40);
    self.loginButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 50);
    self.loginButton.backgroundColor = [UIColor clearColor];
    [self.loginButton addTarget:self action:@selector(Signin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)Signin {
    WebViewController *webView = [[WebViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:webView animated:YES completion:NULL];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];


    NSString *internetStatus = [userDefaults objectForKey:@"offline"];
    if ([internetStatus isEqualToString:@"0"]) {
        [self.loginButton removeFromSuperview];
    
        self.loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.loginButton setTitle:@"Let me in" forState:UIControlStateNormal];
        self.loginButton.frame = CGRectMake(0, 20, 320, 40);
        self.loginButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 50);
        self.loginButton.backgroundColor = [UIColor clearColor];
    
        [self.loginButton addTarget:self action:@selector(buildTableView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.loginButton];
    }
}

- (IBAction)buildTableView {
    TableViewController *tableView = [[TableViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController*  theNavController = [[UINavigationController alloc] initWithRootViewController:tableView];
    [self presentViewController:theNavController animated:YES completion:NULL];
    [self.loginButton removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
