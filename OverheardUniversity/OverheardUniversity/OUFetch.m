//
//  OUFetch.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 8/1/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import "OUFetch.h"

@implementation OUFetch

+ (void)fetchSchoolListFromEmail:(NSString*)email {
    PFQuery *query = [PFQuery queryWithClassName:@"Locations"];
    [query whereKey:@"emailSuffix" equalTo:email];

//    [query findObjects];
//    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:[[query findObjects] firstObject]];
    
//    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"homeSchool"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %ld schools.", objects.count);
//            NSLog(@"school:%@", [objects firstObject]);
            // Do something with the found objects
//            for (PFObject *object in objects) {
                NSData* data = [NSKeyedArchiver archivedDataWithRootObject:[[objects firstObject] objectForKey:@"homeLocation"]];
            
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"homeSchoolLocation"];
                [[NSUserDefaults standardUserDefaults] synchronize];
//            }

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
//    return [query findObjects];
}

+ (void)fetchBuildings {
    PFQuery *query = [PFQuery queryWithClassName:@"Buildings"];
    
    //    [query findObjects];
    //    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:[[query findObjects] firstObject]];
    
    //    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"homeSchool"];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %ld buildings.", objects.count);
            //            NSLog(@"school:%@", [objects firstObject]);
            // Do something with the found objects
            //            for (PFObject *object in objects) {
//            NSData* data = [NSKeyedArchiver archivedDataWithRootObject:objects];
//            
//            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"buildings"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
            //            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
