//
//  LocationRequestViewController.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 6/4/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import <Parse/Parse.h>

#import "LocationRequestViewController.h"
#import "OUTheme.h"
#import "OUActionView.h"
#import "SchoolGeolocator.h"

@interface LocationRequestViewController () <OUActionViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel* locationPrimingLabel;
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) SchoolGeolocator* schoolLocator;
@property (nonatomic, strong) OUActionView* locationPrime;

@end


@implementation LocationRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [OUTheme brandColor];
    
//    self.locationPrimingLabel.text = NSLocalizedString(@"Some copy about how we need their location to determine their school and for other features of the app but aren't going to be all weird about it and track them or something.", nil);
//    self.locationPrimingLabel.textColor = [OUTheme offWhiteColor];
    
    self.locationPrime = [[OUActionView alloc] initWithTitle:NSLocalizedString(@"Overheard University would like to use your location to determine the nearest school.", nil) subTitle:nil cancelButtonTitle:@"Nah" confirmButtonTitle:@"Sure!"];
    self.locationPrime.delegate = self;
    
    [self.view addSubview:self.locationPrime];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)locationRequestPrimed:(id)sender
//{
//    NSLog(@"sanity check");
//if (![CLLocationManager locationServicesEnabled]) {
//    NSLog(@"need to get permission");
//}
//    
//    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
//        if (!error) {
////            self.userLocation = geoPoint;
////            [self loadObjects];
//            self.schoolLocator = [[SchoolGeolocator alloc]initWithGeoPoint:geoPoint];
//            
//            self.locationPrimingLabel.text =self. schoolLocator.displayName;
//            
//            [self.delegate didReceiveLocations:self.schoolLocator.locations];
//        }
//    }];
//    
////    self.locationManager = [[CLLocationManager alloc] init];
////    self.locationManager.delegate = self;
////    
////    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
////    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
////        [self.locationManager requestAlwaysAuthorization];
////    }
////    
////    [self.locationManager startUpdatingLocation];
//    
//}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        NSLog(@"coordinates:%@, %@", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude], [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
//TODO: hand off location to next VC
//        PFGeoPoint* ef = [PFGeoPoint geoPointFor]
        self.schoolLocator = [[SchoolGeolocator alloc]initWithGeoPoint:[PFGeoPoint geoPointWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude]];
        
        [self.locationManager stopUpdatingLocation];
    }
}

#pragma mark - OUActionViewDelegate

- (void)didCancelRequest:(OUActionView *)actionView
{
    
}

- (void)didConfirmRequest:(OUActionView *)actionView
{
    NSLog(@"sanity check");
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"need to get permission");
    }
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            //            self.userLocation = geoPoint;
            //            [self loadObjects];
            self.schoolLocator = [[SchoolGeolocator alloc]initWithGeoPoint:geoPoint];
            
            [self.delegate didReceiveLocations:self.schoolLocator.locations];
        }
    }];
}

@end
