//
//  SpeciesViewController.m
//  Hamming
//
//  Created by Hugo Bastien on 2014-03-30.
//  Copyright (c) 2014 Hugo Bastien. All rights reserved.
//

#import "SpeciesViewController.h"
#import "GenesViewController.h"
#import "AFNetworking.h"

@interface SpeciesViewController ()

@property (nonatomic, strong) NSArray *species;
@property (nonatomic, strong) NSDictionary *selectedSpecies;

@end

@implementation SpeciesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self loadSpecies];
    });
}

- (void)loadSpecies {
    [[AFHTTPSessionManager manager] GET:@"http://genome-api.herokuapp.com/species.json"
                             parameters:nil
                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        self.species = responseObject;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.species.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"
                                                            forIndexPath:indexPath];
    
    NSDictionary *species = [self.species objectAtIndex:indexPath.row];
    cell.textLabel.text = [species objectForKey:@"name"];
    cell.detailTextLabel.text = @"Bacteria";
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GenesViewController *controller = [segue destinationViewController];
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    self.selectedSpecies = [self.species objectAtIndex:path.row];
    controller.species = self.selectedSpecies;
}

@end
