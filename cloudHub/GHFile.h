//
//  GHFile.h
//  cloudHub
//
//  Created by Luke Kartsolis on 22/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

@interface GHFile : NSObject {
    NSString* name;
    NSString* path;
    NSString* sha;
    NSString* size;
    NSString* url;
    NSString* type;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* path;
@property (nonatomic, retain) NSString* sha;
@property (nonatomic, retain) NSString* size;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* content;

@end