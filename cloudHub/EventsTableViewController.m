//
//  EventsTableViewController.m
//  cloudHub
//
//  Created by Luke Kartsolis on 09/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import "EventsTableViewController.h"
#import "FollowingTableViewController.h"
#import "FollowersTableViewController.h"
#import "TableViewController.h"
#import "ViewController.h"
#import "WebViewController.h"
#import "GHUser.h"
#import "RestKit/Restkit.h"
#import "GHEvents.h"
#import "GHRepo.h"

@interface EventsTableViewController ()

@end

@implementation EventsTableViewController

GHUser *user;
GHRepo *repo;
GHEvents *events;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Title.
    self.title = @"Events";
    
    // Back button.
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)backButtonPressed
{
    // Dismiss this controller.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadView
{
    [super loadView];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[GHRepo class]];
    [userMapping addAttributeMappingsFromArray:@[@"id",
                                                 @"name",
                                                 @"url"
                                                 ]];
    
    // Register mappings with the provider using a response descriptor.
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"repo" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // Remove the optional parameter of the url.
    NSArray* urlParams = [[defaults objectForKey:@"events_url"] componentsSeparatedByString:@"{"];
    NSString* url = [urlParams objectAtIndex:0];
    
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        results = [[NSMutableArray alloc] initWithObjects: nil];
        
        // Add mapping result to array.
        for(int i = 0; i < [mappingResult count]; i++){
            repo = mappingResult.array[i];
            //[results addObject:repo.id];
            [results addObject:repo.name];
        }
        
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    
    /* ============================ SECOND MAPPING =====================================
    
    RKObjectMapping *eventsMapping = [RKObjectMapping mappingForClass:[GHEvents class]];
    [eventsMapping addAttributeMappingsFromArray:@[@"id",
                                                 @"type"
                                                 ]];
    
    // Register mappings with the provider using a response descriptor.
    RKResponseDescriptor *eventsResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:eventsMapping method:RKRequestMethodAny pathPattern:nil keyPath:@" " statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKObjectRequestOperation *eventsObjectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ eventsResponseDescriptor ]];
    [eventsObjectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *eventsOperation, RKMappingResult *eventsMappingResult) {
        
        eventsResults = [[NSMutableArray alloc] initWithObjects: nil];
        
        // Add mapping result to array.
        for(int i = 0; i < [eventsMappingResult count]; i++){
            events = eventsMappingResult.array[i];
            NSLog(@"wewe%@", events.id);
            [eventsResults addObject:events.id];
            [eventsResults addObject:events.type];
        }
        
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    ============================ SECOND MAPPING ===================================== */
    // Main Menu Interface
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
