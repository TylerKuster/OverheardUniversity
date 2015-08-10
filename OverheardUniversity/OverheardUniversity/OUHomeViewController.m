//
//  OUHomeViewController.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 7/30/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import <iCarousel/iCarousel.h>

#import "OUHomeViewController.h"

@interface OUHomeViewController () <MKMapViewDelegate, NSCoding>

@property (nonatomic, weak) IBOutlet iCarousel* schoolCarousel;
@property (nonatomic, weak) IBOutlet MKMapView* mapView;
@property (nonatomic, weak) IBOutlet iCarousel* locationCarousel;
@property (nonatomic, retain) PFGeoPoint* schoolLocation;

@end

@implementation OUHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view setBackgroundColor:[UIColor grayColor]];
    UIButton* butt = [UIButton buttonWithType:UIButtonTypeInfoDark];
    butt.frame = CGRectMake(0.0f, 0.0f, 100.0f, 100.0f);
    [butt addTarget:self action:@selector(touchedTheButt) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.mapView addSubview:butt];
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
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(.02, .02));
    [self.mapView setRegion:region animated:YES];
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchedTheButt {
    NSLog(@"map center lat:%f, map center long:%f", self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude);
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.schoolCarousel.alpha = 0.0f;
                         self.mapView.alpha = 0.0f;
                         self.locationCarousel.alpha = 0.0f;
                     } completion:^(BOOL finished) {

                         UIViewController *nextView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"testVC"];
                         
                         //    nextView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [self.tabBarController presentViewController:nextView animated:NO completion:nil];
                         });
                         
                     }];
}

@end
