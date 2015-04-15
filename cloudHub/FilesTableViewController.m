//
//  FilesTableViewController.m
//  cloudHub
//
//  Created by Luke Kartsolis on 19/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import "FilesTableViewController.h"
#import "TableViewController.h"
#import "ViewController.h"
#import "GHUser.h"
#import "RestKit/Restkit.h"
#import "GHRepo.h"
#import "GHFile.h"
#import "GHContent.h"
#import "ContentViewController.h"

@interface FilesTableViewController () {
    
}

@end
@implementation FilesTableViewController

GHFile *files;
NSString *fileType;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Title.
    self.title = @"Files";
    
    // Back button.
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadView
{
    [super loadView];
    
    [self reloadResultsWithPathExtension:@""];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [results objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self typeOfRowAtIndexPath:indexPath] == GHContentTypeFile) {
        
        // fileName
        
        ContentViewController *contentController = [[ContentViewController alloc] initWithNibName:nil bundle:nil];
        
        [self.navigationController pushViewController:contentController animated:YES];
    }
    else {
     
        NSString *cellName = [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        
        [self reloadResultsWithPathExtension:cellName];
        
        [self.tableView reloadData];
    }
    
}

- (NSUInteger)typeOfRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (NSURL *)urlWithPathExtension:(NSString *)pathExtension
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray* urlParams = [[defaults objectForKey:@"contents_url"] componentsSeparatedByString:@"{"];
    
    NSLog(@"%@", [defaults objectForKey:@"contents_url"]);
    
    NSLog(@"1: %@ 2: %@", [urlParams objectAtIndex:0], pathExtension);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [urlParams objectAtIndex:0], pathExtension]];
    
    return url;
}

- (void)reloadResultsWithPathExtension:(NSString *)pathExtension
{
    
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[GHFile class]];
    
    [userMapping addAttributeMappingsFromArray:@[@"name",
                                                 @"path",
                                                 @"sha",
                                                 @"size",
                                                 @"url",
                                                 @"type"
                                                 ]];
    
    // Register mappings with the provider using a response descriptor.
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:nil
                                                                                           keyPath:@""
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // Remove the optional parameter
    //NSString* url = @"https://api.github.com/repos/LukeCS/cloudHub/contents"
    
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:[self urlWithPathExtension:pathExtension]];
    
    NSLog(@"String: %@", [self urlWithPathExtension:pathExtension].absoluteString);
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        results = [[NSMutableArray alloc] initWithObjects: nil];
        
        // Add mapping result to array.
        for(int i = 0; i < [mappingResult count]; i++){
            files = mappingResult.array[i];
            [results addObject:files.name];
            [types addObject:files.type];
        }
        
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    [objectRequestOperation start];
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
