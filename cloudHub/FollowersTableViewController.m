//
//  FollowersTableViewController.m
//  cloudHub
//
//  Created by Luke Kartsolis on 06/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import "FollowersTableViewController.h"
#import "TableViewController.h"
#import "ViewController.h"
#import "WebViewController.h"
#import "GHUser.h"
#import "RestKit/Restkit.h"
@interface FollowersTableViewController () <UITableViewDelegate, UITableViewDataSource> {
    
}

@end

@implementation FollowersTableViewController

GHUser *user;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadView
{
    [super loadView];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[TableViewController class]];
    [userMapping addAttributeMappingsFromArray:@[@"login",
                                                 @"id",
                                                 @"avatar_url",
                                                 @"gravatar_id",
                                                 @"url",
                                                 @"html_url",
                                                 @"followers_url",
                                                 @"following_url",
                                                 @"gists_url",
                                                 @"starred_url",
                                                 @"subscriptions_url",
                                                 @"organizations_url",
                                                 @"repos_url",
                                                 @"events_url",
                                                 @"received_events_url",
                                                 @"type",
                                                 @"public_repos",
                                                 @"followers",
                                                 @"following",
                                                 @"created_at",
                                                 @"updated_at",
                                                 
                                                 /*
                                                  NSString* private_gists;
                                                  NSString* total_private_repos;
                                                  NSString* owned_private_repos;
                                                  NSString* disk_usage;
                                                  NSString* collaborators;
                                                  NSString* plan;*/
                                                 ]];
    
    
    // register mappings with the provider using a response descriptor
    // Get user by name route. We create a class route here.
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: self.followersUrl]];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        array = [[NSMutableArray alloc] initWithObjects:@"", nil];
        
        // For loop for debuggind reasons
        for(int i = 0; i < [mappingResult count]; i++){
            user = mappingResult.array[i];
            
            NSLog(@"User name, %@", user.login);
            NSLog(@"User id, %@", user.id);
            NSLog(@"User repos url, %@", user.repos_url);
            //}
            [array addObject:user.login];
            NSLog(@"t%@",array[i]);
            
        }
        [self.tableView reloadData];
        NSLog(@"%@", array[0]);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    // Main Menu Interface
    [objectRequestOperation start];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier =@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@", [array objectAtIndex:indexPath.row]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
