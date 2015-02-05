//
//  ViewController.m
//  cloudHub
//
//  Created by Luke Kartsolis on 25/10/2014.
//  Copyright (c) 2014 Luke Kartsolis. All rights reserved.
//
//  Client ID
//  0ddae62c917a6464ad4d
//  Client Secret
//  e9f611058979231b54263f7704323b63c72e0cf1
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GHuser.h"
#import "RestKit/Restkit.h"

#define kCLIENTID @"0ddae62c917a6464ad4d"
#define kCLIENTSECRET @"45ab32f44791a9ca53175bf914a5b3233622c947"

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic, strong) NSArray *info;

@end

@implementation ViewController
@synthesize loginView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self viewIntroScreen];
    [self configureRestKit:@"/login/oauth/authorize"];
    //[self loadUser];
}

-(void)viewIntroScreen {
    
    
    // Sort out labels
    self.label1 = [[UILabel alloc] init];
    self.label1.frame = CGRectMake(0.0, 20.0, self.view.frame.size.width, 270.0);
    self.label1.font = [UIFont fontWithName:@"Helvetica Neue" size:24.0];
    self.label1.textColor = [UIColor darkGrayColor];
    self.label1.textAlignment = NSTextAlignmentCenter;
    self.label1.text = @"Welcome to cloudHub";
    [self.view addSubview:self.label1];
    
    self.label2 = [[UILabel alloc] init];
    self.label2.frame = CGRectMake(0.0, 20.0, self.view.frame.size.width, 270.0);
    self.label2.font = [UIFont fontWithName:@"Helvetica Neue" size:24.0];
    self.label2.textColor = [UIColor darkGrayColor];
    self.label2.textAlignment = NSTextAlignmentCenter;
    self.label2.text = @"Sign in with GitHub";
    self.label2.alpha = 0.0;
    [self.view addSubview:self.label2];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.loginButton setTitle:@"Sign in" forState:UIControlStateNormal];
    [self.loginButton sizeToFit];
    self.loginButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    self.loginButton.backgroundColor = [UIColor whiteColor];
    self.loginButton.alpha = 0.0;
    [self.view addSubview:self.loginButton];
    [self.loginButton addTarget:self action:@selector(authUser) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.tapArea = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped)];
    [self.view addGestureRecognizer:self.tapArea];
}

- (void)userTapped {
    
    // Animation
    [UIView animateWithDuration:1.4 animations:^{
        
        self.label1.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 140.0);
        self.label1.alpha = 0.0;
        
        self.label2.alpha = 1.0;
        
        self.loginButton.alpha = 1.0;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureRestKit:(NSString *)str
{
    // Initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"https://github.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    // Initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // Setup object mappings
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[GHUser class]];
    [userMapping addAttributeMappingsFromArray:@[@"id"]];
    // Register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping
                                                 method:RKRequestMethodPOST
                                                 pathPattern:str
                                                 keyPath:nil
                                                 statusCodes:[NSIndexSet indexSetWithIndex:200]];

    [objectManager addResponseDescriptor:responseDescriptor];
}

- (void)authUser
{
    
    self.loginView = [[UIWebView alloc] init];
    self.loginView.delegate = self;
    self.loginView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20);
    self.loginView.backgroundColor = [UIColor grayColor];
    self.loginView.alpha = 0.0;
    self.loginView.scrollView.scrollEnabled = YES;
    self.loginView.scrollView.bounces = NO;
    [self.view addSubview:self.loginView];
    
    [UIView animateWithDuration:1.0 animations:^{
        
        self.label2.alpha = 0.0;
        
        self.loginButton.alpha = 0.0;
        
        self.loginView.alpha = 1.0;
    }];
    
    //NSString *requestURL = [NSString stringWithFormat:@"https://github.com/login/oauth/authorize?response_type=token&client_id=%@&client_secret=%@", kCLIENTID, kCLIENTSECRET];
    
    NSString *requestURL = [NSString stringWithFormat:@"https://github.com/login/oauth/authorize?response_type=cod&client_id=%@&redirect_uri=http://localhost:3000/callback", kCLIENTID];
    
    
    requestURL = [requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *websiteUrl = [NSURL URLWithString:requestURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];

    NSLog(@"\n%@", requestURL);
    //[[UIApplication sharedApplication] openURL:websiteUrl];
    [self.loginView loadRequest:urlRequest];
}

- (void)userAuthorized{
    
    self.label3 = [[UILabel alloc] init];
    self.label3.frame = CGRectMake(0.0, 20.0, self.view.frame.size.width, 140.0);
    self.label3.font = [UIFont fontWithName:@"Helvetica Neue" size:24.0];
    self.label3.textColor = [UIColor darkGrayColor];
    self.label3.textAlignment = NSTextAlignmentCenter;
    self.label3.text = @"Authorized accepted";
    self.label3.alpha = 0.0;
    [self.view addSubview:self.label3];
    
//    [UIView animateWithDuration:1.0 animations:^{
//        
//        self.loginView.alpha = 0.0;
//        
//        self.label3.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 270.0);
//        self.label3.alpha = 1.0;
//    }];
    [self loadUser];
    
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"%@", request);
    
        
    // 8. get the url and check for the access token in the callback url
    NSLog(@"In callback if statement: %@", request);
        
        NSString *URLString = [[request URL] absoluteString];
        
        if ([URLString rangeOfString:@"code="].location != NSNotFound) {
            
            // 9. Store the access token in the user defaults
            
            NSString *accessToken = [[URLString componentsSeparatedByString:@"="] lastObject];
            NSLog(@"Access token: %@", accessToken); // This will be used to fetch the personal token of the user
            [self userAuthorized];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:accessToken forKey:@"code"];
            
            [defaults synchronize];
            
            // 10. dismiss the view controller
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    loginView.delegate = nil;
    [loginView stopLoading];
}

- (void)webViewDidStartLoad:(UIWebView *)loginView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)loginView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)loginView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *errorString = [error localizedDescription];
    NSString *errorTitle = [NSString stringWithFormat:@"Error (%d)", error.code];
    
    // In this case, we need the error(-1004) to occur as we need the "code".
    if (error.code != -1004) {
        UIAlertView *errorView =
        [[UIAlertView alloc] initWithTitle:errorTitle
                                   message:errorString delegate:self cancelButtonTitle:nil
                         otherButtonTitles:@"OK", nil];
        [errorView show];
    }
    // Carry on

    
}


- (void)loadUser
{
    // setup object mappings
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[GHUser class]];
    [userMapping addAttributeMappingsFromDictionary:@{@"login" : @"login",
                                                      @"id" : @"id",
                                                      @"avatar_url" : @"avatar_url",
                                                      @"gravatar_id" : @"gravatar_id",
                                                      @"url" : @"url",
                                                      @"html_url" : @"html_url",
                                                      @"followers_url" : @"followers_url",
                                                      @"following_url" : @"following_url",
                                                      @"gists_url" : @"gists_url",
                                                      @"starred_url" : @"starred_url",
                                                      @"subscriptions_url" : @"subscriptions_url",
                                                      @"organizations_url" : @"organizations_url",
                                                      @"repos_url" : @"repos_url",
                                                      @"events_url" : @"events_url",
                                                      @"received_events_url": @"received_events_url",
                                                      @"type": @"type",
                                                      @"site_admin": @"site_admin",
                                                      @"public_repos": @"public_repos",
                                                      @"public_gists": @"public_gists",
                                                      @"followers": @"followers",
                                                      @"following": @"following",
                                                      @"created_at": @"created_at",
                                                      @"updated_at": @"updated_at",
                                                      }];
    
    // register mappings with the provider using a response descriptor
    // Get user by name route. We create a class route here.
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // **Need to make token a parameter in this method**
    NSURL *baseURL = [NSURL URLWithString:@"https://api.github.com/user?access_token=3e62aed905e3f4aa85c3211f63108126484e3dbc"];
    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
    
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



@end
