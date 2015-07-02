//
//  SchoolGeolocator.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 6/5/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "SchoolGeolocator.h"

@implementation SchoolGeolocator

- (id)initWithGeoPoint:(PFGeoPoint*)location
{
    self = [super init];
    if (self)
    {
        PFQuery *query = [PFQuery queryWithClassName:@"Locations"];
        [query whereKey:@"homeLocation" nearGeoPoint:location];
        NSArray* schools = [query findObjects];
        NSLog(@"%@", schools);
        
        // TODO:Swap this out for the real colors
        self.colors = [[schools objectAtIndex:0] objectForKey:@"locations"];
        self.locations = schools;
        self.displayName = [[schools objectAtIndex:0] objectForKey:@"DisplayName"];
        self.emailSuffix = [[schools objectAtIndex:0] objectForKey:@"emailSuffix"];
        self.altName = [[schools objectAtIndex:0] objectForKey:@"AltName"];
        self.abbreviation = [[schools objectAtIndex:0] objectForKey:@"Abbreviation"];
    }
    return self;
}

@end
