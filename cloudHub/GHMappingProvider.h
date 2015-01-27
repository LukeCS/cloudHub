//
//  GHMappingProvider.h
//  cloudHub
//
//  Created by Luke Kartsolis on 27/01/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface MappingProvider : NSObject

+ (RKObjectMapping *) userMapping;
+ (RKObjectMapping *) repositoryMapping;

@end
