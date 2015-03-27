//
//  RepositoriesTableViewController.h
//  cloudHub
//
//  Created by Luke Kartsolis on 12/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepositoriesTableViewController : UITableViewController {
    NSMutableArray *results;
    NSMutableArray *urls;
    NSString *contentUrl;
}

@end
