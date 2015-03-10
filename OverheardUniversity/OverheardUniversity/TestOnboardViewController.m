//
//  TestOnboardViewController.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 3/8/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import <CLHoppingViewController/CLHoppingViewController.h>
#import "TestOnboardViewController.h"

@interface TestOnboardViewController ()

@end

@implementation TestOnboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onboardingFinished:(id)sender
{
    [self.hoppingViewController unhop];
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
