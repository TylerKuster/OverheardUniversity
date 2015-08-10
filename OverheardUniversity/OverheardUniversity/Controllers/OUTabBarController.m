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
#import "OUCreatePostTextView.h"

static const CGFloat kHeaderBarHeight = 70.0f;
static const CGFloat kFooterBarHeight = 48.0f;

@interface OUTabBarController ()

@property (nonatomic, retain) UIButton* searchButton;
@property (nonatomic, retain) UIButton* profileButton;

@property (nonatomic, retain) UIView* headerBar;
@property (nonatomic, retain) OUCreatePostTextView* postTextView;
@property (nonatomic, retain) UIView* footerBar;

@end

@implementation OUTabBarController

- (void)commonInit
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    [self createHeaderViewWithWidth:screenWidth];
    [self createFooterViewWithWidth:screenWidth andHeight:screenHeight];
    
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

- (void)createFooterViewWithWidth:(CGFloat)width andHeight:(CGFloat)height {
    
    self.footerBar = [[UIView alloc] initWithFrame:CGRectMake(0.0f, height - kFooterBarHeight, width, kFooterBarHeight)];
    self.footerBar.backgroundColor = [OUTheme brandColor];
    
    [self.view insertSubview:self.footerBar atIndex:TopLevel];
    
    UIButton* postMap = [UIButton buttonWithType:UIButtonTypeCustom];
    postMap.frame = CGRectMake(16.0f, 8.0f, 32.0f, 32.0f);
    postMap.backgroundColor = [UIColor whiteColor];
    
    [self.footerBar insertSubview:postMap atIndex:BaseLevel];
    
    UIButton* profile = [UIButton buttonWithType:UIButtonTypeCustom];
    profile.frame = CGRectMake(width - 48.0f, 8.0f, 32.0f, 32.0f);
    profile.backgroundColor = [UIColor whiteColor];
    
    [self.footerBar insertSubview:profile atIndex:BaseLevel];
    
    UITextView* postTextView = [[UITextView alloc]initWithFrame:CGRectMake((width / 2.0f) - 99.5, 10.0f, 199, 28)];
    
    
    [self.footerBar addSubview:postTextView];

}

@end
