//
//  LocationRequestViewController.h
//  overhearduniversity
//
//  Created by Tyler Kuster on 6/4/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class LocationRequestViewController;

@protocol LocationRequestViewControllerDelegate <NSObject>
- (void)didReceiveLocations:(NSArray*)locations;

@end

@interface LocationRequestViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) id<LocationRequestViewControllerDelegate> delegate;

@end
