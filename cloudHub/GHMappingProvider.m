//
//  GHMappingProvider.m
//  cloudHub
//
//  Created by Luke Kartsolis on 27/01/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import "GHMappingProvider.h"
#import <RestKit/RestKit.h>
#import "GHUser.h"
#import "GHRepository.h"

@implementation MappingProvider

+ (RKObjectMapping *)userMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[GHUser class]];
    NSDictionary *mappingDictionary = @{@"login": @"login",
                                        @"id": @"userId",
                                        @"avatar_url": @"avatarUrl",
                                        @"name": @"name",
                                        @"public_repos": @"publicReposCount",
                                        @"public_gists": @"publicGistsCount"
                                        };
    
    [mapping addAttributeMappingsFromDictionary:mappingDictionary];
    
    return mapping;
}

+ (RKObjectMapping *)repositoryMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Repository class]];
    NSDictionary *mappingDictionary = @{@"id": @"repositoryId",
                                        @"name": @"",
                                        @"full_name": @"fullName",
                                        @"description": @"description",
                                        @"url": @"apiUrl",
                                        @"stargazers_count": @"stargazersCount",
                                        @"watchers_count": @"watchersCount",
                                        @"private": @"isPrivateRepository",
                                        @"fork": @"isForkedRepository"};
    
    [mapping addAttributeMappingsFromDictionary:mappingDictionary];
    [mapping addRelationshipMappingWithSourceKeyPath:@"owner" mapping:[self userMapping]];
    
    return mapping;
}

@end
