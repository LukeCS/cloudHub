//
//  GHRepository.h
//  cloudHub
//
//  Created by Luke Kartsolis on 27/01/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GHUser;

@interface Repository : NSObject

@property (nonatomic, strong) NSNumber *repositoryId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *apiUrl;
@property (nonatomic, strong) NSString *starsCount;
@property (nonatomic, strong) NSNumber *privateRepository;
@property (nonatomic, strong) NSNumber *forkRepository;
@property (nonatomic, strong) User *owner;

@end
