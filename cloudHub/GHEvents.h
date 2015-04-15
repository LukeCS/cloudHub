//
//  GHEvents.h
//  cloudHub
//
//  Created by Luke Kartsolis on 09/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//
#import "GHRepo.h"

@interface GHEvents : NSObject {
    NSNumber* id;
    NSString* name;
    NSString* url;
}

@property (nonatomic, retain) NSNumber* id;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* url;

- (void)load;
- (void)save;

@end