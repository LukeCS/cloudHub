//
//  GHUserManager.h
//  cloudHub
//
//  Created by Luke Kartsolis on 27/01/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import "AKObjectManager.h"

@class GHUser;

@interface UserManager : AKObjectManager

- (void) loadAuthenticatedUser:(void (^)(GHUser *user))success failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

@end
