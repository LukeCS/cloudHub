//
//  GHRepo.m
//  cloudHub
//
//  Created by Luke Kartsolis on 09/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHRepo.h"

@implementation GHRepo : NSObject

- (void)load
{
    
    
}


- (void)save
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.id forKey:@"id"];
    [defaults setObject:self.name forKey:@"name"];
    [defaults setObject:self.url forKey:@"url"];
    [defaults setObject:self.contents_url forKey:@"contents_url"];
}

@end