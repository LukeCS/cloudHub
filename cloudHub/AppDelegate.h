//
//  AppDelegate.h
//  cloudHub
//
//  Created by Luke Kartsolis on 25/10/2014.
//  Copyright (c) 2014 Luke Kartsolis. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const OADTokenDefaultsName = @"OADTokenDefaultsName";
static NSString *const OADUsernameDefaultsName = @"OADUsernameDefaultsName";
static NSString *const OADTokenExpirationDefaultsName = @"OADTokenExpirationDefaultsName";
static NSString *const OADNewTokenAvailable = @"OADNewTokenAvailable";

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

