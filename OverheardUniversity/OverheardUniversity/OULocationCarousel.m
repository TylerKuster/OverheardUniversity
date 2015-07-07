//
//  OULocationCarousel.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 7/5/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "OULocationCarousel.h"
#import "OUTheme.h"

static const CGFloat kAreaBarHeight = 80.0f;
static const CGFloat kCarouselItemWidth = 40.0f;

@interface OULocationCarousel () <iCarouselDelegate, iCarouselDataSource>

@end

@implementation OULocationCarousel

- (void)commonInit
{
    self.backgroundColor = [UIColor greenColor];
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
    return 5;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, 100.0f, 300.f)];
        view.backgroundColor = [OUTheme randomColor];
        view.contentMode = UIViewContentModeCenter;
#warning make sure this ^ doesn't cause problems.
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, -20.0f, 100.0f, kAreaBarHeight)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:14];
        
        switch (index) {
            case 0:
                label.text = @"Parks Library";
                break;
            case 1:
                label.text = @"Coover Hall";
                break;
            case 2:
                label.text = @"College of Design";
                break;
            case 3:
                label.text = @"College of Design";
                break;
            case 4:
                label.text = @"College of Design";
                break;
                
            default:
                break;
        }
        
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
