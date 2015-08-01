//
//  OUWelcomeViewController.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 7/30/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import <Parse/Parse.h>

#import "AppDelegate.h"
#import "OUWelcomeViewController.h"

@interface OUWelcomeViewController ()

@end

@implementation OUWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // If not logged in, present login view controller
    if ([PFUser currentUser]) {
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] presentLoginViewControllerAnimated:NO];
        return;
    }
    // Present Anypic UI
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] presentTabBarController];
    
    // Refresh current user with server side data -- checks if user is still valid and so on
    [[PFUser currentUser] fetchInBackgroundWithTarget:self selector:@selector(refreshCurrentUserCallbackWithResult:error:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ()

- (void)fetchCurrentUserCallbackWithResult:(PFObject *)refreshedObject error:(NSError *)error {
    // A kPFErrorObjectNotFound error on currentUser refresh signals a deleted user
    if (error && error.code == kPFErrorObjectNotFound) {
        NSLog(@"User does not exist.");
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] logOut];
        return;
    }
    
//    [PFFacebookUtils extendAccessTokenIfNeededForUser:[PFUser currentUser] block:^(BOOL succeeded, NSError *error) {
//        // Check if user is missing a Facebook ID
//        if ([PAPUtility userHasValidFacebookData:[PFUser currentUser]]) {
//            // User has Facebook ID.
//            
//            // refresh Facebook friends on each launch
//            [[PFFacebookUtils facebook] requestWithGraphPath:@"me/friends" andDelegate:(AppDelegate*)[[UIApplication sharedApplication] delegate]];
//            
//        } else {
//            NSLog(@"User missing Facebook ID");
//            [[PFFacebookUtils facebook] requestWithGraphPath:@"me/?fields=name,picture,email" andDelegate:(AppDelegate*)[[UIApplication sharedApplication] delegate]];
//        }
//    }];
    
    
}


@end
