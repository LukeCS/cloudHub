//
//  ViewController.m
//  Gitty
//
//  Created by Luke Kartsolis on 09/02/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "GHUser.h"
#import "RestKit/Restkit.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.loginButton setTitle:@"Sign in with Git" forState:UIControlStateNormal];
    self.loginButton.frame = CGRectMake(0, 20, 320, 40);
    self.loginButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 50);
    self.loginButton.backgroundColor = [UIColor lightGrayColor];
    [self.loginButton addTarget:self action:@selector(Signin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)Signin {
    WebViewController *webView = [[WebViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:webView animated:YES completion:NULL];
    [self.loginButton removeFromSuperview];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.loginButton setTitle:@"Let me in" forState:UIControlStateNormal];
    self.loginButton.frame = CGRectMake(0, 20, 320, 40);
    self.loginButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 50);
    self.loginButton.backgroundColor = [UIColor lightGrayColor];
    
   

    [self.loginButton addTarget:self action:@selector(buildTableView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
}

- (IBAction)buildTableView {
    [self.loginButton removeFromSuperview];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [defaults objectForKey:@"access_token"];
    
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[GHUser class]];
    [userMapping addAttributeMappingsFromArray:@[@"login",
                                                      @"id",
                                                      @"avatar_url",
                                                      @"gravatar_id",
                                                      @"url",
                                                      @"html_url",
                                                      @"followers_url",
                                                      @"following_url"
                                                      ]];
    
    
    // register mappings with the provider using a response descriptor
    // Get user by name route. We create a class route here.
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.github.com/user?access_token=%@", accessToken]]];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        // For loop for debuggind reasons
        for(int i = 0; i < [mappingResult count]; i++){
            GHUser *user = mappingResult.array[i];
            //if ([user.login isEqualToString:@"LukeCS"]) {
            NSLog(@"User name, %@", user.login);
            NSLog(@"User id, %@", user.id);
            //}
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    
    // Main Menu Interface
    
    [objectRequestOperation start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
