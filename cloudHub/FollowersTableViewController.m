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
    self.title = @"Followers";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)backButtonPressed
{
    // write your code to prepare popview
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadView
{
    [super loadView];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[TableViewController class]];
    [userMapping addAttributeMappingsFromArray:@[@"login",
                                                 
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
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[defaults objectForKey:@"followers_url"]]];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        results = [[NSMutableArray alloc] initWithObjects: nil];
        
        // Add mapping result to array.
        for(int i = 0; i < [mappingResult count]; i++){
            user = mappingResult.array[i];
            [results addObject:user.login];
        }
        [self.tableView reloadData];    
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    [objectRequestOperation start];    
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
    return results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier =@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@", [results objectAtIndex:indexPath.row]];
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
