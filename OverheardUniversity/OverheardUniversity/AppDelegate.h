//
//  AppDelegate.h
//  OverheardUniversity
//
//  Created by Tyler Kuster on 7/28/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "OUTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, /*PFLogInViewControllerDelegate, PF_FBRequestDelegate,*/ NSURLConnectionDataDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) OUTabBarController *tabBarController;
@property (nonatomic, strong) UINavigationController *navController;

@property (nonatomic, readonly) int networkStatus;

- (BOOL)isParseReachable;

- (void)presentOnboardingViewController;
- (void)presentOnboardingViewControllerAnimated:(BOOL)animated;
- (void)presentTabBarController;

- (void)logOut;

@end
