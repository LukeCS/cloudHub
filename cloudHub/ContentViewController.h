//
//  ContentViewController.h
//  cloudHub
//
//  Created by Luke Kartsolis on 23/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHUser.h"

@interface ContentViewController : UIViewController {
    NSMutableArray *results;
    NSString *content;
}

@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) UITextView *textView;
@end
