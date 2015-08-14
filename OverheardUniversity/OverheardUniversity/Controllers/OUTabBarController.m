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
#import "OUFooterView.h"

static const CGFloat kHeaderBarHeight = 70.0f;
static const CGFloat kFooterBarHeight = 48.0f;

@interface OUTabBarController () <UITextViewDelegate, OUFooterViewDelegate>

@property (nonatomic, retain) UIButton* searchButton;
@property (nonatomic, retain) UIButton* profileButton;

@property (nonatomic, retain) UIView* headerBar;

@end

@implementation OUTabBarController

- (void)commonInit
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    
    [self createHeaderViewWithWidth:screenWidth];
    
    
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
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createHeaderViewWithWidth:(CGFloat)width {
    
    self.headerBar = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, kHeaderBarHeight)];
    self.headerBar.backgroundColor = [OUTheme brandColor];
    
    [self.view insertSubview:self.headerBar atIndex:TopLevel];
    
    UIButton* search = [UIButton buttonWithType:UIButtonTypeCustom];
    search.frame = CGRectMake(16.0f, 26.0f, 32.0f, 32.0f);
    search.backgroundColor = [UIColor whiteColor];
    
    [self.headerBar insertSubview:search atIndex:BaseLevel];
    
    UIButton* refresh = [UIButton buttonWithType:UIButtonTypeCustom];
    refresh.frame = CGRectMake(width - 48.0f, 26.0f, 32.0f, 32.0f);
    refresh.backgroundColor = [UIColor whiteColor];
    
    [self.headerBar insertSubview:refresh atIndex:BaseLevel];
    
    UIImageView* logo = [[UIImageView alloc]initWithFrame:CGRectMake((width / 2.0f) - 50.5, 24, 101, 36)];
    logo.image = [UIImage imageNamed:@"overheardLogo"];
    
    [self.headerBar insertSubview:logo atIndex:BaseLevel];
}

@end
