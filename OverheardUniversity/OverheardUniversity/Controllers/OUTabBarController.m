//
//  OUTabBarController.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 7/29/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//
#import <Parse/Parse.h>

#import "OUTabBarController.h"
#import "OUTheme.h"

@interface OUTabBarController ()

@property (nonatomic, retain) UIButton* searchButton;
@property (nonatomic, retain) UIButton* profileButton;

@end

@implementation OUTabBarController

- (void)commonInit
{
    UIView* headerBar = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 100.0f)];
    headerBar.backgroundColor = [OUTheme brandColor];

    [self.view insertSubview:headerBar atIndex:1];
//    self.selectedIndex = 0;
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
    self.view.backgroundColor = [UIColor blueColor];
   
    
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
