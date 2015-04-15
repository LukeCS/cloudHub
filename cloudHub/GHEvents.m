//
//  GHEvents.m
//  cloudHub
//
//  Created by Luke Kartsolis on 09/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHEvents.h"


@implementation GHEvents : NSObject

- (void)load
{

}

- (void)save
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.id forKey:@"id"];
    [defaults setObject:self.name forKey:@"followers_url"];
    [defaults setObject:self.url forKey:@"following_url"];
}

@end