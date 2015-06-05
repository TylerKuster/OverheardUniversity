//
//  LocationRequestViewController.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 6/4/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "LocationRequestViewController.h"
#import "OUTheme.h"

@interface LocationRequestViewController () 

@property (nonatomic, weak) IBOutlet UILabel* locationPrimingLabel;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end


@implementation LocationRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [OUTheme brandColor];
    
    self.locationPrimingLabel.text = NSLocalizedString(@"Some copy about how we need their location to determine their school and for other features of the app but aren't going to be all weird about it and track them or something.", nil);
    self.locationPrimingLabel.textColor = [OUTheme offWhiteColor];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)locationRequestPrimed:(id)sender
{
    NSLog(@"sanity check");
if (![CLLocationManager locationServicesEnabled]) {
    NSLog(@"need to get permission");
}
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    
}

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
        [self.locationManager stopUpdatingLocation];
    }
}

@end
