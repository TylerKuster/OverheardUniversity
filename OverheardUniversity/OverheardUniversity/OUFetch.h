//
//  OUFetch.h
//  OverheardUniversity
//
//  Created by Tyler Kuster on 8/1/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface OUFetch : NSObject

+ (void)fetchSchoolListFromEmail:(NSString*)email;
+ (void)fetchBuildings;
+ (void)findObjectsInBackgroundWithBlock:(PF_NULLABLE PFArrayResultBlock)block;

@end
