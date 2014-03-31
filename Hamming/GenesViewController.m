//
//  GenesViewController.m
//  Hamming
//
//  Created by Hugo Bastien on 2014-03-30.
//  Copyright (c) 2014 Hugo Bastien. All rights reserved.
//

#import "GenesViewController.h"
#import "AFNetworking.h"

@interface GenesViewController ()

@property (nonatomic, strong) NSArray *genes;

@end

@implementation GenesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self loadGenes];
    });
}

- (void)loadGenes {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *speciesId = [self.species objectForKey:@"id"];
    NSString *speciesGenesUrl = [NSString stringWithFormat:@"http://genome-api.herokuapp.com/species/%@.json", speciesId];
    [[AFHTTPSessionManager manager] GET:speciesGenesUrl
                             parameters:nil
                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        self.genes = responseObject;
                                        [self.tableView reloadData];
                                    });
                                }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    NSLog(@"ERROR %@", error);
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Received error from server"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil] show];
                                    });
                                }];
}


- (void)didReceiveMemoryWarnin {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.genes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"geneCellId" forIndexPath:indexPath];
    
    NSDictionary *gene = [self.genes objectAtIndex:indexPath.row];
    cell.textLabel.text = [gene objectForKey:@"gene"];
    cell.detailTextLabel.text = [gene objectForKey:@"translation"];
    CGRect frame = CGRectMake(10, 10, 20, 20);
    [cell.imageView setFrame:frame];
    
    return cell;
}

@end