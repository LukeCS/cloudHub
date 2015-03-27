//
//  ContentViewController.m
//  cloudHub
//
//  Created by Luke Kartsolis on 23/03/2015.
//  Copyright (c) 2015 Luke Kartsolis. All rights reserved.
//

#import "ContentViewController.h"
#import "RestKit/Restkit.h"
#import "GHFile.h"
@interface ContentViewController ()

@end

@implementation ContentViewController
@synthesize content;

GHFile *file;
- (void)viewDidLoad {
    [super viewDidLoad];
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(45, 30, 200, 100)];
    tf.textColor = [UIColor whiteColor];
    // Title.
    self.title = @"Files";
    [self.view addSubview:tf];
    // Back button.
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.navigationItem.leftBarButtonItem = backButton;
    // Do any additional setup after loading the view from its nib.
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
    
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[GHFile class]];
    [userMapping addAttributeMappingsFromArray:@[@"name",
                                                 @"path",
                                                 @"sha",
                                                 @"size",
                                                 @"url",
                                                 @"type",
                                                 @"content"
                                                 ]];
    
    
    // Register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    // Remove the optional parameter
    NSArray* urlParams = [[defaults objectForKey:@"content"] componentsSeparatedByString:@"{"];
    NSString* url = @"https://api.github.com/repos/LukeCS/cloudHub/contents/README.md?ref=master";
    NSLog(@"URL = %@", url);
    
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        results = [[NSMutableArray alloc] initWithObjects: nil];
        
        // Add mapping result to array.
        for(int i = 0; i < [mappingResult count]; i++){
            file = mappingResult.array[i];
            [results addObject:file.content];
            content = file.content;
            NSLog(@"%@", content);
            // NSData from the Base64 encoded str
            NSData *nsdataFromBase64String = [[NSData alloc]
                                              initWithBase64EncodedString:content options:0];
            
            // Decoded NSString from the NSData
            NSString *base64Decoded = [[NSString alloc]
                                       initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
            NSLog(@"Decoded: %@", base64Decoded);
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    [objectRequestOperation start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
