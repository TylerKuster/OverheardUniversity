//
//  SchoolGeolocator.h
//  overhearduniversity
//
//  Created by Tyler Kuster on 6/5/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>


@interface SchoolGeolocator : NSObject

@property (nonatomic, strong) CLLocation* location;

@property (nonatomic, strong) NSArray* colors;
@property (nonatomic, strong) NSArray* locations;

@property (nonatomic, strong) NSString* displayName;
@property (nonatomic, strong) NSString* emailSuffix;
@property (nonatomic, strong) NSString* altName;
@property (nonatomic, strong) NSString* abbreviation;

- (id)initWithGeoPoint:(PFGeoPoint*)location;

@end
