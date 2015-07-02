//
//  OUViewController.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 3/7/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "OUViewController.h"
#import <Parse/Parse.h>

@interface OUViewController ()

@end

@implementation OUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];

    // first, hop to splash
    [self hopTo:@"splash" then:^{
        // then, hop to the onboarding sequence (but only once)
                NSLog(@"finished splash");
        [self conditionalHopToOnboarding:^{
            // then, hop to the main app controller (and that's it)
            [self hopTo:@"main" then:^{
                NSLog(@"made it");
            }];
        }];
    }];
}

// a nice little scheme to implement conditional hops
- (void)conditionalHopToOnboarding:(void(^)(void))next
{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"username"]) {
        NSLog(@"no user");
        [self hopTo:@"register" then:next];
    }
    else {
        NSLog(@"CHANGE THIS");
        [self hopTo:@"register" then:next];
        next();
    }
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
