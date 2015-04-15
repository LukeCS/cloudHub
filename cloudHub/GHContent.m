//
//  GHContent.m
//  cloudHub
//
//  Created by Luke Kartsolis on 23/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHContent.h"

@implementation GHContent :NSObject

- (void)load
{
    
    
}


- (void)save
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.name forKey:@"name"];
    [defaults setObject:self.path forKey:@"path"];
    [defaults setObject:self.type forKey:@"type"];
    [defaults setObject:self.content forKey:@"content"];
}

@end