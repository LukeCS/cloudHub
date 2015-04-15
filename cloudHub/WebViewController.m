//
//  WebViewController.m
//  cloudHub
//
//  Created by Luke Kartsolis on 09/02/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//
#import "AppDelegate.h"
#import "ViewController.h"
#import "GHUser.h"
#import "WebViewController.h"
#import "RestKit/Restkit.h"
#import "JSON.h"

#define kCLIENTID @"0ddae62c917a6464ad4d"
#define kCLIENTSECRET @"45ab32f44791a9ca53175bf914a5b3233622c947"
#define kCALLBACK @"https://localhost:3000"

@interface WebViewController () <UIWebViewDelegate>


@end

@implementation WebViewController
@synthesize isLogin;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildWebView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buildWebView {
    
    // Initialise web view.
    self.loginWebView = [[UIWebView alloc] init];
    self.loginWebView.delegate = self;
    self.loginWebView.scalesPageToFit = YES;
    self.loginWebView.frame = CGRectMake(0, 20, 320, self.view.frame.size.height-20);
    self.loginWebView.backgroundColor = [UIColor grayColor];
    self.loginWebView.scrollView.scrollEnabled = YES;
    self.loginWebView.scrollView.bounces = YES;
    
    // Make the GET request.
    NSString *requestURL = [NSString stringWithFormat:@"https://github.com/login/oauth/authorize?response_type=code&client_id=%@&scope=user, user:email, user:follow, public_repo, repo, &redirect_uri=http://localhost:3000/callback", kCLIENTID];
    
    requestURL = [requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *websiteUrl = [NSURL URLWithString:requestURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    
    NSLog(@"\n%@", requestURL);
    
    [self.view addSubview:self.loginWebView];
    [self.loginWebView loadRequest:urlRequest];
}

- (void)userDidAuthorize:(NSString *)code {
    
    // Initialise label3.
    self.label3 = [[UILabel alloc] init];
    self.label3.frame = CGRectMake(0.0, 20.0, self.view.frame.size.width, 140.0);
    self.label3.font = [UIFont fontWithName:@"Helvetica Neue" size:24.0];
    self.label3.textColor = [UIColor darkGrayColor];
    self.label3.textAlignment = NSTextAlignmentCenter;
    self.label3.text = @"Authorized accepted";
    [self.view addSubview:self.label3];

    //[self dismissViewControllerAnimated:YES completion:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://github.com/login/oauth/access_token?client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=http://localhost:3000&code=%@", kCLIENTID, kCLIENTSECRET, code]]];

    [self.loginWebView loadRequest: request];
}

-(void)retry {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// -----------  Connection Methods -------------

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [receivedData appendData:data];
    NSLog(@"code %@",receivedData);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", error]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

// -----------  Connection Methods End ---------


// -----------  WebView Delegate Methods  -------------

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    
    // Get the URL and check for the code in the callback url.
    
    if ([[[request URL] host] isEqualToString:@"localhost"]) {
        
        // Extract code parameter from URL query
        NSString* code = nil;
        NSArray* urlParams = [[[request URL] query] componentsSeparatedByString:@"&"];
        for (NSString* param in urlParams) {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"code"]) {
                code = [keyValue objectAtIndex:1];
                
                NSLog(@"%@",code);
                break;
            }
        }
        
        // If code exists.
        if (code) {
            
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://github.com/login/oauth/access_token"]];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            
            // Make POST method request.
            [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:[[NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=http://localhost:3000&code=%@", kCLIENTID, kCLIENTSECRET, code] dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPMethod:@"POST"];
            NSError *error = nil; NSURLResponse *response = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            if (error) {
                NSLog(@"Error:%@", error.localizedDescription);
            }
            else { // Success
                NSString *htmlSTR = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSString* access_token = nil;
                NSArray* urlParams = [htmlSTR componentsSeparatedByString:@"&"];
                for (NSString* param in urlParams) {
                    NSArray* keyValue = [param componentsSeparatedByString:@"="];
                    NSString* key = [keyValue objectAtIndex:0];
                    if ([key isEqualToString:@"access_token"]) {
                        access_token = [keyValue objectAtIndex:1];
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        
                        [defaults setObject:access_token forKey:@"access_token"];
                        [defaults synchronize];
                        
                        NSLog(@"%@",access_token);
                        [self dismissViewControllerAnimated:YES completion:nil];
                        break;
                    }
                }
            }
        } else {
            // ERROR!
        }
        
        [self.loginWebView removeFromSuperview];
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)loginWebView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)loginWebView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)loginWebView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *errorString = [error localizedDescription];
    NSString *errorTitle = [NSString stringWithFormat:@"Error (%d)", error.code];
    
    // In this case, we need the error(-1004) to occur as we need the "code".
    if (error.code == -1009) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:0 forKey:@"offline"];

        [self.loginWebView removeFromSuperview];
        self.offlineLabel = [[UILabel alloc] init];
        self.offlineLabel.frame = CGRectMake(0.0, 50.0, self.view.frame.size.width, 440.0);
        self.offlineLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:24.0];
        self.offlineLabel.textColor = [UIColor darkGrayColor];
        self.offlineLabel.textAlignment = NSTextAlignmentCenter;
        self.offlineLabel.text = @":( Seems like you have no";
        
        self.offlineLabel2 = [[UILabel alloc] init];
        self.offlineLabel2.frame = CGRectMake(0.0, 50.0, self.view.frame.size.width, 540.0);
        self.offlineLabel2.font = [UIFont fontWithName:@"Helvetica Neue" size:24.0];
        self.offlineLabel2.textColor = [UIColor darkGrayColor];
        self.offlineLabel2.textAlignment = NSTextAlignmentCenter;
        self.offlineLabel2.text = @"internet connection";
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.backButton setTitle:@"Retry" forState:UIControlStateNormal];
        self.backButton.frame = CGRectMake(0, 20, 320, 40);
        self.backButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 50);
        self.backButton.backgroundColor = [UIColor clearColor];
        [self.backButton addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.backButton];
        [self.view addSubview:self.offlineLabel];
        [self.view addSubview:self.offlineLabel2];
        
    } else if (error.code != -1004 && error.code != 102) {
            UIAlertView *errorView =
            [[UIAlertView alloc] initWithTitle:errorTitle
                                       message:errorString delegate:self cancelButtonTitle:nil
                             otherButtonTitles:@"OK", nil];
            [errorView show];


    }
    
    // Carry on
}

// -----------  WebView Delegate Methods End  ---------

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
