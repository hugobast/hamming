//
//  MainViewController.h
//  Hamming
//
//  Created by Hugo Bastien on 2014-03-27.
//  Copyright (c) 2014 Hugo Bastien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *calculate;
@property (weak, nonatomic) IBOutlet UITextField *firstFragment;
@property (weak, nonatomic) IBOutlet UITextField *secondFragment;
@property (weak, nonatomic) IBOutlet UITextField *distanceResult;

@end

