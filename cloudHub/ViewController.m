//
//  ViewController.m
//  cloudHub
//
//  Created by Luke Kartsolis on 25/10/2014.
//  Copyright (c) 2014 Luke Kartsolis. All rights reserved.
//

#import "ViewController.h"
#import "GHuser.h"
#import "RestKit/Restkit.h"

@interface ViewController ()



@end

@implementation ViewController
{
    NSArray *arrItems;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [arrItems objectAtIndex:indexPath.row];
    return cell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self configureRestKit];
    [self loadUser];
    arrItems = [[NSArray alloc] initWithObjects:@"Item 1",@"Item 2",@"Item3", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"https://api.github.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
   
    

}

- (void)loadUser
{
    // setup object mappings
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[GHUser class]];
    [userMapping addAttributeMappingsFromDictionary:@{@"login" : @"login",
                                                      @"id" : @"id",
                                                      @"avatar_url" : @"avatar_url",
                                                      @"gravatar_id" : @"gravatar_id",
                                                      @"url" : @"url",
                                                      @"html_url" : @"html_url",
                                                      @"followers_url" : @"followers_url",
                                                      @"following_url" : @"following_url",
                                                      @"gists_url" : @"gists_url",
                                                      @"starred_url" : @"starred_url",
                                                      @"subscriptions_url" : @"subscriptions_url",
                                                      @"organizations_url" : @"organizations_url",
                                                      @"repos_url" : @"repos_url",
                                                      @"events_url" : @"events_url",
                                                      @"received_events_url": @"received_events_url",
                                                      @"type": @"type",
                                                      @"site_admin": @"site_admin",
                                                      @"public_repos": @"public_repos",
                                                      @"public_gists": @"public_gists",
                                                      @"followers": @"followers",
                                                      @"following": @"following",
                                                      @"created_at": @"created_at",
                                                      @"updated_at": @"updated_at",
                                                      }];
    
    // register mappings with the provider using a response descriptor
    // Get user by name route. We create a class route here.
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *baseURL = [NSURL URLWithString:@"https://api.github.com/users"];
    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
    
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        // For loop for debuggind reasons
        for(int i = 0; i < [mappingResult count]; i++){
            GHUser *user = mappingResult.array[i];
            if ([user.login isEqualToString:@"LukeCS"]) {
                NSLog(@"User name, %@", user.login);
                NSLog(@"User id, %@", user.id);
            }
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    
    [objectRequestOperation start];
}

@end
