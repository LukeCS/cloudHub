//
//  FollowersTableViewController.h
//  cloudHub
//
//  Created by Luke Kartsolis on 06/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowersTableViewController : UITableViewController {
    NSMutableArray *results;
}

@property (nonatomic, retain) NSString* followersUrl;

@end
