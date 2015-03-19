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
    NSString* type;
    NSString* url;
    NSString* repo;
    NSString* gravatar_id;
    NSString* html_url;
    NSString* followers_url;
    NSString* following_url;
    NSString* gists_url;
    NSString* starred_url;
    NSString* subscriptions_url;
    NSString* organizations_url;
    NSString* repos_url;
    NSString* events_url;
    NSString* received_events_url;
    NSString* site_admin;
    NSString* public_repos;
    NSString* public_gists;
    NSString* followers;
    NSString* following;
    NSString* created_at;
    NSString* updated_at;
    NSString* private_gists;
    NSString* total_private_repos;
    NSString* owned_private_repos;
    NSString* disk_usage;
    NSString* collaborators;
    NSString* plan;
}


@property (nonatomic, retain) NSNumber* id;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* repo;
@property (nonatomic, retain) NSString* gravatar_id;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) NSString* html_url;
@property (nonatomic, retain) NSString* followers_url;
@property (nonatomic, retain) NSString* following_url;
@property (nonatomic, retain) NSString* gists_url;
@property (nonatomic, retain) NSString* starred_url;
@property (nonatomic, retain) NSString* subscriptions_url;
@property (nonatomic, retain) NSString* organizations_url;
@property (nonatomic, retain) NSString* repos_url;
@property (nonatomic, retain) NSString* events_url;
@property (nonatomic, retain) NSString* received_events_url;
@property (nonatomic, retain) NSString* site_admin;
@property (nonatomic, retain) NSString* public_repos;
@property (nonatomic, retain) NSString* public_gists;
@property (nonatomic, retain) NSString* followers;
@property (nonatomic, retain) NSString* following;
@property (nonatomic, retain) NSString* created_at;
@property (nonatomic, retain) NSString* updated_at;
@property (nonatomic, retain) NSString* private_gists;
@property (nonatomic, retain) NSString* total_private_repos;
@property (nonatomic, retain) NSString* owned_private_repos;
@property (nonatomic, retain) NSString* disk_usage;
@property (nonatomic, retain) NSString* collaborators;
@property (nonatomic, retain) NSString* plan;

@end