//
//  TableViewController.m
//  cloudHub
//
//  Created by Luke Kartsolis on 03/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import "TableViewController.h"
#import "FollowingTableViewController.h"
#import "FollowersTableViewController.h"
#import "EventsTableViewController.h"
#import "RepositoriesTableViewController.h"
#import "ViewController.h"
#import "WebViewController.h"
#import "GHUser.h"
#import "RestKit/Restkit.h"
#import "GHEvents.h"

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource>


@end

@implementation TableViewController

GHUser *user;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self buildTableView];
}

- (void)loadView
{
    [super loadView];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [defaults objectForKey:@"access_token"];
    
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[GHUser class]];
    [userMapping addAttributeMappingsFromArray:@[@"login",
                                                 @"id",
                                                 @"avatar_url",
                                                 @"followers_url",
                                                 @"following_url",
                                                 @"starred_url",
                                                 @"repos_url",
                                                 @"events_url",
                                                 @"followers",
                                                 @"following",
                                                 ]];
    
    
    // Register mappings with the provider using a response descriptor
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.github.com/user?access_token=%@", accessToken]]];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        for(int i = 0; i < [mappingResult count]; i++){
            user = mappingResult.array[i];
            results = [[NSMutableArray alloc] initWithObjects: @"Events", @"Organizations", @"Followers", @"Following", @"Repositories", @"Gists", nil];
            
            [self.tableView reloadData];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSLog(@"%@", user.following_url);
            
            [userDefaults setObject:user.followers_url forKey:@"followers_url"];
            [userDefaults setObject:user.following_url forKey:@"following_url"];
            [userDefaults setObject:user.events_url forKey:@"events_url"];
            [userDefaults setObject:user.repos_url forKey:@"repos_url"];
            [userDefaults synchronize];
        }
        
        [self buildTableView];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];

    [objectRequestOperation start];
}

- (void)buildTableView {
    
    // set the title
    self.title = @"Profile";
    
    // construct first name cell, section 0, row 0
    self.firstNameCell = [[UITableViewCell alloc] init];
    //self.firstNameCell.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f];
    [self.firstNameCell.contentView addSubview:self.firstNameText];
    
    // construct last name cell, section 0, row 1
    self.lastNameCell = [[UITableViewCell alloc] init];
    self.lastNameCell.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f];
    [self.lastNameCell addSubview:self.lastNameText];
    
    // construct share cell, section 1, row 00
    self.shareCell = [[UITableViewCell alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch(section)
    {
        case 0:  return 6;  // section 0 has 1 row
        default: return 0;
    };
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier =@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@", [results objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

// Customize the section headings for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section)
    {
        case 0: return user.login;
    }
    return nil;
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    // Events Cell
    if (indexPath.row == 0) {
        EventsTableViewController *eventsTableView = [[EventsTableViewController alloc] initWithNibName:nil bundle:nil];
    
        // Pass the selected object to the new view controller.
    
        // Push the view controller.
    
        UINavigationController* theNavController = [[UINavigationController alloc] initWithRootViewController:eventsTableView];
        [self presentViewController:theNavController animated:YES completion:NULL];
    // Followers Cell
    } else if (indexPath.row == 2) {
        
        FollowersTableViewController *followersTableView = [[FollowersTableViewController alloc] initWithNibName:nil bundle:nil];
    
        // Pass the selected object to the new view controller.
    
        // Push the view controller.
        followersTableView.followersUrl = user.followers_url;
        
        UINavigationController* theNavController = [[UINavigationController alloc] initWithRootViewController:followersTableView];
        [self presentViewController:theNavController animated:YES completion:NULL];
    // Following Cell
    } else if (indexPath.row == 3) {
        FollowingTableViewController *followingTableView = [[FollowingTableViewController alloc] initWithNibName:nil bundle:nil];
        
        // Pass the selected object to the new view controller.
        
        // Push the view controller.
        
        UINavigationController* theNavController = [[UINavigationController alloc] initWithRootViewController:followingTableView];
        [self presentViewController:theNavController animated:YES completion:NULL];
    // Repositories Cell
    } else if (indexPath.row == 4) {
        RepositoriesTableViewController *repositoriesTableView = [[RepositoriesTableViewController alloc] initWithNibName:nil bundle:nil];
        
        // Pass the selected object to the new view controller.
        
        // Push the view controller.
        
        UINavigationController* theNavController = [[UINavigationController alloc] initWithRootViewController:repositoriesTableView];
        [self presentViewController:theNavController animated:YES completion:NULL];    
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
