//
//  OUHomeViewController.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 7/30/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import "OUHomeViewController.h"

@interface OUHomeViewController () <MKMapViewDelegate, NSCoding>

@property (nonatomic, weak) IBOutlet MKMapView* mapView;
@property (nonatomic, retain) PFGeoPoint* schoolLocation;

@end

@implementation OUHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view setBackgroundColor:[UIColor grayColor]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.mapView.delegate = self;

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"homeSchoolLocation"]) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeSchoolLocation"];
        self.schoolLocation = [NSKeyedUnarchiver unarchiveObjectWithData:data];

        [self setInitialMapLocation:self.schoolLocation];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Parse map methods

- (void)setInitialMapLocation:(PFGeoPoint*)geoPoint {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(.05, .05));
    [self.mapView setRegion:region animated:YES];
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
