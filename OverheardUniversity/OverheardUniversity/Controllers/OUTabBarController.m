//
//  OUTabBarController.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 7/29/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//
#import <Parse/Parse.h>

#import "OUTabBarController.h"

@implementation OUTabBarController

- (void)commonInit
{
//    self.selectedIndex = 2;
    if (![PFUser currentUser]) {
//        OUOnboardingViewController *onboardingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"onboardingVC"];
        //    [loginViewController setDelegate:self];
        //    loginViewController.fields = PFLogInFieldsFacebook;
        //    loginViewController.facebookPermissions = [NSArray arrayWithObjects:@"user_about_me", nil];

//        [self presentViewController:onboardingViewController animated:NO completion:nil];
        //[(AppDelegate*)[[UIApplication sharedApplication] delegate] presentOnboardingViewControllerAnimated:NO];
//        return;
//        self.selectedIndex = 0;
    }

}

- (id)init
{
    self = [super init];
    if (self){
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self commonInit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
