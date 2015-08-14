//
//  OUCreatePostCarousel.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 8/13/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import "OUCreatePostCarousel.h"
#import "OUTheme.h"

@interface OUCreatePostCarousel () <iCarouselDataSource, iCarouselDelegate>

@end

@implementation OUCreatePostCarousel

- (void)commonInit
{
//        self.backgroundColor = [UIColor purpleColor];
    [self.layer insertSublayer:[OUTheme onboardingGradientFromView:self] atIndex:0];
    [self insertSubview:[self postSettingsView] atIndex:0];
    
    self.delegate = self;
    self.dataSource = self;
    self.vertical = YES;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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

- (UIView*)postSettingsView {
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 375.0f, 316.0f)];
//    view.backgroundColor = [OUTheme brandTintColor];

    return view;
}

#pragma mark - iCarousel DataSource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return 0;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
       
        view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 325.0f, 30.0f)];
        view.backgroundColor = [UIColor redColor];
        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(-50.0f, 0.0f, 425.0f, 30.0f)];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"AvenirNext-Medium"  size:14.0];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = @"Parks Library";
    
    return view;
}

#pragma mark - iCarousel Delegate

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    
}

- (BOOL)carousel:(iCarousel *)carousel shouldSelectItemAtIndex:(NSInteger)index {
    return NO;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
//    if (option == iCarouselOptionOffsetMultiplier) {
//        return 1.1f;
//    }
    
    return value;
}

@end
