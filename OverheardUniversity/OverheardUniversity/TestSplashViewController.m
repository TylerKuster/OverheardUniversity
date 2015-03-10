//
//  TestSplashViewController.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 3/8/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import <CLHoppingViewController/CLHoppingViewController.h>
#import "TestSplashViewController.h"

@interface TestSplashViewController ()

@end

@implementation TestSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startActivityIndicator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startActivityIndicator {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.hoppingViewController unhop];
    });
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
