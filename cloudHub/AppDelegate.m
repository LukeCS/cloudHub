//
//  AppDelegate.m
//  cloudHub
//
//  Created by Luke Kartsolis on 25/10/2014.
//  Copyright (c) 2014 Luke Kartsolis. All rights reserved.
//

#import "AppDelegate.h"
#import <RestKit/RestKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

- (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"URL: %@", url);
    if([[url host] isEqualToString:@"auth"]) {
        NSDictionary *params = [self parseQueryString:[[url fragment] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        // Store the access token
        NSLog(@"Saving new token: %@", params);
        [[NSUserDefaults standardUserDefaults] setObject:[params objectForKey:@"access_token"] forKey:OADTokenDefaultsName];
        
        // Calculate the expiration date so we know if the token is invalid
        NSDate *expDate = [NSDate dateWithTimeIntervalSinceNow:[[params objectForKey:@"expires_in"] integerValue]];
        NSLog(@"Expires at: %@", expDate);
        [[NSUserDefaults standardUserDefaults] setObject:expDate forKey:OADTokenExpirationDefaultsName];
        
        // Store the username
        [[NSUserDefaults standardUserDefaults] setObject:[params objectForKey:@"username"] forKey:OADUsernameDefaultsName];
        
        // Save
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // Notify the view that a new token is available
        [[NSNotificationCenter defaultCenter] postNotificationName:OADNewTokenAvailable object:self];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
