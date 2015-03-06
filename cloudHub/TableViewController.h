//
//  TableViewController.h
//  cloudHub
//
//  Created by Luke Kartsolis on 03/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController {
    NSMutableArray *array;
}

@property (nonatomic, retain) UITableView *tableView;

@property (strong, nonatomic) UITableViewCell *firstNameCell;
@property (strong, nonatomic) UITableViewCell *lastNameCell;
@property (strong, nonatomic) UITableViewCell *shareCell;

@property (strong, nonatomic) UITextField *firstNameText;
@property (strong, nonatomic) UITextField *lastNameText;



@property (nonatomic, retain) NSString* login;
@property (nonatomic, retain) NSNumber* id;
@property (nonatomic, retain) NSString* avatar_url;
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
@property (nonatomic, retain) NSString* private_gists;
@property (nonatomic, retain) NSString* total_private_repos;
@property (nonatomic, retain) NSString* owned_private_repos;
@property (nonatomic, retain) NSString* disk_usage;
@property (nonatomic, retain) NSString* collaborators;
@property (nonatomic, retain) NSString* plan;

@end
