//
//  GHFile.m
//  cloudHub
//
//  Created by Luke Kartsolis on 22/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHFile.h"

@implementation GHFile : NSObject

- (void)load
{
    
    
}


- (void)save
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.name forKey:@"name"];
    [defaults setObject:self.path forKey:@"path"];
    [defaults setObject:self.url forKey:@"url"];
    [defaults setObject:self.type forKey:@"type"];
}

@end