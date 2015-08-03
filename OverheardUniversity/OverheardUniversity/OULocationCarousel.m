//
//  OULocationCarouselViewController.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 7/30/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import "OULocationCarousel.h"

@interface OULocationCarousel ()

@property (nonatomic, strong) UILabel* areaLabel;

@end

@implementation OULocationCarousel

- (void)commonInit
{
    self.backgroundColor = [UIColor purpleColor];   
    self.delegate = self;
    self.dataSource = self;

    self.areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 2.0f, [UIScreen mainScreen].bounds.size.width, 20.0f)];
    self.areaLabel.textAlignment = NSTextAlignmentCenter;
    self.areaLabel.textColor = [UIColor colorWithRed:210.0f / 255.0f green:210.0f / 255.0f blue:210.0f / 255.0f alpha:1.0f];
    self.areaLabel.font = [UIFont fontWithName:@"AvenirNext-Medium"  size:14.0];
    self.areaLabel.text = @"Campus";
    
    [self addSubview:self.areaLabel];
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


#pragma mark - iCarousel DataSource
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return 3;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    UIView* cardBase = nil;
    UILabel* locationName = nil;
    UILabel* locationNumberOfPosts = nil;
    UILabel* locationNumberOfFollowers = nil;
    UIButton* listenInButton = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 180.0f, 210.0f)];
        view.backgroundColor = [UIColor purpleColor];
//        view.contentMode = UIViewContentModeCenter;
        
        cardBase = [[UIView alloc] initWithFrame:CGRectMake(0.5f, 24.0f, 179.0f, 186.0f)];
        cardBase.backgroundColor = [UIColor whiteColor];
        
        [view addSubview:cardBase];
        
        locationName = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 8.0f, 178.0f, 30.0f)];
        locationName.backgroundColor = [UIColor whiteColor];
        locationName.textAlignment = NSTextAlignmentCenter;
        locationName.textColor = [UIColor colorWithRed:66.0f / 255.0f green:66.0f / 255.0f blue:66.0f / 255.0f alpha:1.0f];
        locationName.font = [UIFont fontWithName:@"AvenirNext-DemiBold"  size:20.0];
        
        [cardBase addSubview:locationName];
        
        locationNumberOfPosts = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 40.0f, 178.0f, 20.0f)];
        locationNumberOfPosts.backgroundColor = [UIColor whiteColor];
        locationNumberOfPosts.textAlignment = NSTextAlignmentCenter;
        locationNumberOfPosts.textColor = [UIColor colorWithRed:66.0f / 255.0f green:66.0f / 255.0f blue:66.0f / 255.0f alpha:1.0f];
        locationNumberOfPosts.font = [UIFont fontWithName:@"AvenirNext-Medium"  size:14.0];
        
        [cardBase addSubview:locationNumberOfPosts];
        
        locationNumberOfFollowers = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 58.0f, 178.0f, 30.0f)];
        locationNumberOfFollowers.backgroundColor = [UIColor whiteColor];
        locationNumberOfFollowers.textAlignment = NSTextAlignmentCenter;
        locationNumberOfFollowers.textColor = [UIColor colorWithRed:66.0f / 255.0f green:66.0f / 255.0f blue:66.0f / 255.0f alpha:1.0f];
        locationNumberOfFollowers.font = [UIFont fontWithName:@"AvenirNext-Medium"  size:14.0];
        
        [cardBase addSubview:locationNumberOfFollowers];
    }
//    else
//    {
//        //get a reference to the label in the recycled view
//        label = (UILabel *)[view viewWithTag:1];
//    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    locationName.text = @"Parks Library";
    locationNumberOfPosts.text = @"1208 Posts";
    locationNumberOfFollowers.text = @"2129 Listening";
    
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

//- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
//
//}
//
//- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
//
//}
//
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    
    return value;
}
@end
