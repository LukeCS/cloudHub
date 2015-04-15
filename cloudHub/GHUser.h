//
//  GHUser.h
//  cloudHub
//
//  Created by Luke Kartsolis on 25/10/2014.
//  Copyright (c) 2014 Luke Kartsolis. All rights reserved.
//

@interface GHUser : NSObject {
    NSString* login;
    NSNumber* id;
    NSString* avatar_url;
    NSString* followers_url;
    NSString* following_url;
    NSString* starred_url;
    NSString* repos_url;
    NSString* events_url;
    NSString* followers;
    NSString* following;
}

@property (nonatomic, retain) NSString* login;
@property (nonatomic, retain) NSNumber* id;
@property (nonatomic, retain) NSString* avatar_url;
@property (nonatomic, retain) NSString* followers_url;
@property (nonatomic, retain) NSString* following_url;
@property (nonatomic, retain) NSString* starred_url;
@property (nonatomic, retain) NSString* repos_url;
@property (nonatomic, retain) NSString* events_url;
@property (nonatomic, retain) NSString* followers;
@property (nonatomic, retain) NSString* following;


- (void)load;
- (void)save;

@end
