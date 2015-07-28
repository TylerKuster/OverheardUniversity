//
//  OUCampusCarousel.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 7/5/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import "OUCampusCarousel.h"
#import "OUAreaCarousel.h"
#import "OUTheme.h"

static const CGFloat kTopBarHeight = 80.0f;
static const CGFloat kCarouselPeek = 40.0f;

@interface OUCampusCarousel () <iCarouselDelegate, iCarouselDataSource, UIGestureRecognizerDelegate, OUAreaCarouselDelegate>
@property (nonatomic, strong) OUAreaCarousel* areaCarousel;

@end

@implementation OUCampusCarousel

- (void)commonInit
{
    self.backgroundColor = [UIColor lightGrayColor];
    self.delegate = self;
    self.dataSource = self;
    
    self.currentItemIndex = 1;
    self.scrollSpeed = 0.5;
    self.ignorePerpendicularSwipes = YES;
//    self.scrollEnabled = NO;

    MKMapView* campusMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 300.0f)];
    
    [self insertSubview:campusMapView atIndex:0];
}

- (id)init
{
    self = [super init];
    if (self){
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self commonInit];
    }
    return self;
}

- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    NSLog(@"Trying");
    if(UIGestureRecognizerStateBegan == gesture.state) {
        [self scrollToItemAtIndex:self.currentItemIndex-1 animated:YES];
        
    }
}

#pragma mark - iCarousel Delegate / Datasource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return 3;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
    view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, kTopBarHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - kTopBarHeight)];
    

    }
    else
    {
        label = [[view subviews] lastObject];
    }

    if (!self.areaCarousel) {
        self.areaCarousel = [[OUAreaCarousel alloc] initWithFrame:[OUTheme areaCarouselRect]];
        self.delegate = self;
        self.areaCarousel.backgroundColor = [UIColor redColor];
        [view addSubview:self.areaCarousel];
    }

    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(-(kCarouselPeek / 2.0f), 0.0f, [UIScreen mainScreen].bounds.size.width + kCarouselPeek, 32.0f)];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [label.font fontWithSize:14];
    
    [view addSubview:label];
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    switch (index) {
        case 0:
            label.text = @"University of Southern California";
            break;
        case 1:
            label.text = @"Iowa State University";
            break;
        case 2:
            label.text = @"University of California, Los Angeles";
            break;
            
        default:
            break;
    }
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            return YES; // 0 = NO, 1 = YES
        }
        default:
        {
            return value;
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // You can customize the way in which gestures can work
    // Enabling multiple gestures will allow all of them to work together, otherwise only the topmost view's gestures will work (i.e. PanGesture view on bottom)
    return YES;
}

#pragma mark - OUAreaCarouselDelegate

- (void)carouselIsScrolling:(OUAreaCarousel *)aCarousel
{
    self.scrollEnabled = NO;
}

- (void)carouselEndedScrolling:(OUAreaCarousel *)aCarousel
{
    self.scrollEnabled = YES;
}

@end
