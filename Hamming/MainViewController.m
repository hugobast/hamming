//
//  MainViewController.m
//  Hamming
//
//  Created by Hugo Bastien on 2014-03-27.
//  Copyright (c) 2014 Hugo Bastien. All rights reserved.
//

#import "MainViewController.h"
#import "Hamming.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)calculateDistance:(id)sender {
    NSUInteger distance = [Hamming compute:self.firstFragment.text against:self.secondFragment.text];
    
    self.distanceResult.text = [NSString stringWithFormat:@"%d", distance];
}

@end
