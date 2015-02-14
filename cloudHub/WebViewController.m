//
//  WebViewController.m
//  cloudHub
//
//  Created by Luke Kartsolis on 09/02/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//
#import "AppDelegate.h"
#import "ViewController.h"
#import "GHuser.h"
#import "WebViewController.h"
#import "RestKit/Restkit.h"
//#import "JSON.h"

#define kCLIENTID @"0ddae62c917a6464ad4d"
#define kCLIENTSECRET @"45ab32f44791a9ca53175bf914a5b3233622c947"

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic) BOOL codeReceived;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self configureRestKit];
    [self buildWebView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureRestKit
{
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://github.com/"]];
    objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
    [RKObjectManager setSharedManager:objectManager];
}

-(void)buildWebView
{
    self.loginView = [[UIWebView alloc] init];
    self.loginView.delegate = self;
    self.loginView.scalesPageToFit = YES;
    self.loginView.frame = CGRectMake(0, 20, 320, self.view.frame.size.height-20);
    self.loginView.backgroundColor = [UIColor grayColor];
    self.loginView.scrollView.scrollEnabled = YES;
    self.loginView.scrollView.bounces = YES;
    
    
    //NSString *requestURL = [NSString stringWithFormat:@"https://github.com/login/oauth/authorize?response_type=token&client_id=%@&client_secret=%@", kCLIENTID, kCLIENTSECRET];
    
    NSString *requestURL = [NSString stringWithFormat:@"https://github.com/login/oauth/authorize?response_type=code&client_id=%@&scope=user, user:email, user:follow, public_repo, repo, &redirect_uri=http://localhost:3000/callback", kCLIENTID];
    
    requestURL = [requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *websiteUrl = [NSURL URLWithString:requestURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    
    NSLog(@"\n%@", requestURL);
    //[[UIApplication sharedApplication] openURL:websiteUrl];
    [self.view addSubview:self.loginView];
    [self.loginView loadRequest:urlRequest];
    
    
}

- (void)userDidAuthorize:(NSString *)code{
    
    self.label3 = [[UILabel alloc] init];
    self.label3.frame = CGRectMake(0.0, 20.0, self.view.frame.size.width, 140.0);
    self.label3.font = [UIFont fontWithName:@"Helvetica Neue" size:24.0];
    self.label3.textColor = [UIColor darkGrayColor];
    self.label3.textAlignment = NSTextAlignmentCenter;
    self.label3.text = @"Authorized accepted";
    [self.view addSubview:self.label3];
    
    //    [UIView animateWithDuration:1.0 animations:^{
    //
    //        self.loginView.alpha = 0.0;
    //
    //        self.label3.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 270.0);
    //        self.label3.alpha = 1.0;
    //    }];
    // [self loadUser];
    
    
    //[[UIApplication sharedApplication] openURL:websiteUrl];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://github.com/login/oauth/access_token?client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=http://localhost:3000&code=%@", kCLIENTID, kCLIENTSECRET, code]]];
    
    
    /***
     NSURL *url = [NSURL URLWithString: requestURL];
     NSString *body = [NSString stringWithFormat: @"access_token=%@&token_type=%@", @"access_token",@"token_type"];
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
     [request setHTTPMethod: @"POST"];
     [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
     [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
     [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
     [self.loginView loadRequest: request];
     *****/
    
    [self.loginView loadRequest: request];
    
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // Get the url and check for the code in the callback url
    
    if ([[[request URL] host] isEqualToString:@"localhost"]) {
        
        // Extract oauth_verifier from URL query
        NSString* verifier = nil;
        NSArray* urlParams = [[[request URL] query] componentsSeparatedByString:@"&"];
        for (NSString* param in urlParams) {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"code"]) {
                verifier = [keyValue objectAtIndex:1];
                
                NSLog(@"%@",verifier);
                break;
            }
        }
        
        if (verifier) {
            NSString *data = [NSString stringWithFormat:@"code=%@&client_id=%@&client_secret=%@&redirect_uri=http://localhost:3000&grant_type=authorization_code", verifier, kCLIENTID, kCLIENTSECRET, verifier];
            NSString *url = [NSString stringWithFormat:@"https://github.com/oauth2/access_token"];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
            NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
            receivedData = [[NSMutableData alloc] init];
            NSLog(@"%@",receivedData);
        } else {
            // ERROR!
        }
        
        [self.loginView removeFromSuperview];
        
        return NO;
    }
    
    return YES;
    
    /*
     NSURL *url = request.URL;
     if ([url.scheme isEqual:@"http"]) {
     
     NSString* verifier = nil;
     NSString *URLString = [[request URL] absoluteString];
     
     if ([URLString rangeOfString:@"code="].location != NSNotFound) {
     
     // Store the code in the user defaults
     NSString *code = [[URLString componentsSeparatedByString:@"="] lastObject];
     NSLog(@"Code is : %@", code); // This will be used to fetch the personal token of the user
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     
     [defaults setObject:code forKey:@"code"];
     
     [defaults synchronize];
     
     //[self userDidAuthorize:code];
     
     } else if ([URLString rangeOfString:@"access_token="].location != NSNotFound){
     NSLog(@"WOWW");
     }
     
     
     } else {
     NSLog(@"https://");
     }
     */
    
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
    }// Carry on
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
