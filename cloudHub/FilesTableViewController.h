//
//  FilesTableViewController.h
//  cloudHub
//
//  Created by Luke Kartsolis on 19/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

typedef enum : NSUInteger {
    GHContentTypeFile,
    GHContentTypeDirectory,
} GHContentType;

#import <UIKit/UIKit.h>

@interface FilesTableViewController : UITableViewController {
    NSMutableArray *results;
    NSMutableArray *types;
}

- (void)reloadResultsWithPathExtension:(NSString *)pathExtension;

@end
