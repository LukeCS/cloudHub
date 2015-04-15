//
//  GHUser.m
//  cloudHub
//
//  Created by Luke Kartsolis on 25/10/2014.
//  Copyright (c) 2014 Luke Kartsolis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHUser.h"

@implementation GHUser : NSObject

- (void)load
{
    
}


- (void)save
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.login forKey:@"login"];
    [defaults setObject:self.id forKey:@"id"];
    [defaults setObject:self.followers_url forKey:@"followers_url"];
    [defaults setObject:self.following_url forKey:@"following_url"];
    [defaults setObject:self.repos_url forKey:@"repos_url"];
    [defaults setObject:self.events_url forKey:@"events_url"];
    [defaults setObject:self.followers forKey:@"followers"];
    [defaults setObject:self.following forKey:@"following"];
}

@end