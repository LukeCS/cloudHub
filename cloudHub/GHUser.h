//
//  GHUser.h
//  cloudHub
//
//  Created by Luke Kartsolis on 25/10/2014.
//  Copyright (c) 2014 Luke Kartsolis. All rights reserved.
//

@interface GHUser : NSObject

@property (nonatomic, retain) NSString* login;
@property (nonatomic, retain) NSString* id;
@property (nonatomic, retain) NSString* avatar_url;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *publicReposCount;
@property (nonatomic, strong) NSNumber *publicGistsCount;
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
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* site_admin;
@property (nonatomic, retain) NSString* public_repos;
@property (nonatomic, retain) NSString* public_gists;
@property (nonatomic, retain) NSString* followers;
@property (nonatomic, retain) NSString* following;
@property (nonatomic, retain) NSString* created_at;
@property (nonatomic, retain) NSString* updated_at;


@end
