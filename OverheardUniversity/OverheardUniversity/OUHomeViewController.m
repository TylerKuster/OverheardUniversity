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
#import "OUSchoolCarousel.h"
#import "OUCreatePostCarousel.h"
#import "OUFooterView.h"

static const CGFloat kHeaderBarHeight = 70.0f;
static const CGFloat kFooterBarHeight = 48.0f;

@interface OUHomeViewController () <MKMapViewDelegate, NSCoding, OUFooterViewDelegate>

@property (nonatomic, weak) IBOutlet OUSchoolCarousel* schoolCarousel;
@property (nonatomic, weak) IBOutlet MKMapView* mapView;
@property (nonatomic, weak) IBOutlet OUCreatePostCarousel* createPostCarousel;
@property (nonatomic, weak) IBOutlet iCarousel* locationCarousel;
@property (nonatomic, retain) PFGeoPoint* schoolLocation;
@property (nonatomic, retain) OUFooterView* footerBar;

@end

@implementation OUHomeViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIButton* butt = [UIButton buttonWithType:UIButtonTypeInfoDark];
    butt.frame = CGRectMake(0.0f, 0.0f, 100.0f, 100.0f);
    [butt addTarget:self action:@selector(touchedTheButt) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.mapView addSubview:butt];
    
    self.footerBar = [[OUFooterView alloc] initWithFrame:CGRectMake(0.0f, screenHeight - kFooterBarHeight, screenWidth, kFooterBarHeight)];
    self.footerBar.delegate = self;
    
    [self.view insertSubview:self.footerBar aboveSubview:self.locationCarousel];
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

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideOrShow:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideOrShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWillHideOrShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* keyboardFrame = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [keyboardFrame CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    CGFloat keyboardTop = keyboardRect.origin.y;
    self.footerBar.frame = CGRectMake(0.0f, keyboardTop - kFooterBarHeight, [UIScreen mainScreen].bounds.size.width, kFooterBarHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Footer Delegate Methods

- (void)presentCreatePostView {
    NSLog(@"show post create view");
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.createPostCarousel.alpha = 1.0f;
                         [self.schoolCarousel setCarouselState:CarouselStateHidden];
                     } completion:nil];
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
