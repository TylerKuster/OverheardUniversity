//
//  OULogin.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 3/3/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "OULogin.h"
#import <Parse/Parse.h>

@implementation OULogin

+ (void)checkUsername:(NSString*)username password:(NSString*)password andEmail:(NSString*)email
{
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
//    user.email = email;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"Login Error:%@", errorString);
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

@end
