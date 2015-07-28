//
//  OUAreaCarousel.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 7/5/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "OUAreaCarousel.h"
#import "OULocationCarousel.h"
#import "OUTheme.h"

static const CGFloat kAreaBarHeight = 80.0f;
static const CGFloat kCarouselPeek = 40.0f;

@interface OUAreaCarousel () <iCarouselDelegate, iCarouselDataSource>
@property (nonatomic, strong) OULocationCarousel* locationCarousel;

@end

@implementation OUAreaCarousel

- (void)commonInit
{
    self.backgroundColor = [UIColor redColor];
    self.delegate = self;
    self.dataSource = self;
    
    self.currentItemIndex = 1;
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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self commonInit];
    }
    return self;
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
        view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, kAreaBarHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - kAreaBarHeight)];
//        view.contentMode = UIViewContentModeCenter;
        view.clipsToBounds = YES;
#warning make sure this ^ doesn't cause problems.
        if (!self.locationCarousel) {
            self.locationCarousel = [[OULocationCarousel alloc] initWithFrame:[OUTheme locationCarouselRect]];
//            self.locationCarousel.backgroundColor = [UIColor orangeColor];
            [view addSubview:self.locationCarousel];
        }
        label = [[UILabel alloc] initWithFrame:CGRectMake(-(kCarouselPeek / 2.0f), 85.0f, [UIScreen mainScreen].bounds.size.width, 40.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:14];
        
        [view addSubview:label];
        
        switch (index) {
            case 0:
                label.text = @"West Ames";
                break;
            case 1:
                label.text = @"Campus";
                break;
            case 2:
                label.text = @"Campus Town";
                break;
                
            default:
                break;
        }
    }
    else
    {
        label = [[view subviews] lastObject];
        
        
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            return NO; // 0 = NO, 1 = YES
        }
        default:
        {
            return value;
        }
    }
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel
{
    [self.areaCarouselDelegate carouselIsScrolling:nil];
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate
{
    [self.areaCarouselDelegate carouselEndedScrolling:nil];
}

@end
