//
//  OUCampusCarousel.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 7/5/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "OUCampusCarousel.h"
#import "OUAreaCarousel.h"
#import "OUTheme.h"

static const CGFloat kTopBarHeight = 80.0f;
static const CGFloat kCarouselPeek = 40.0f;

@interface OUCampusCarousel () <iCarouselDelegate, iCarouselDataSource>
@property (nonatomic, strong) OUAreaCarousel* areaCarousel;

@end

@implementation OUCampusCarousel

- (void)commonInit
{
    self.backgroundColor = [UIColor lightGrayColor];
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
//        view.contentMode = UIViewContentModeCenter;
#warning make sure this ^ doesn't cause problems.
        if (!self.areaCarousel) {
            self.areaCarousel = [[OUAreaCarousel alloc] initWithFrame:[OUTheme areaCarouselRect]];
            self.areaCarousel.backgroundColor = [UIColor redColor];
            [self addSubview:self.areaCarousel];
        }
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(-(kCarouselPeek / 2.0f), -30.0f, [UIScreen mainScreen].bounds.size.width, kTopBarHeight)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:14];
        
        [view addSubview:label];
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

@end
