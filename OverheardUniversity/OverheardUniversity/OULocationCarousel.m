//
//  OULocationCarouselViewController.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 7/30/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import "OULocationCarousel.h"
#import "OULocationCarouselItem.h"
#import "OUListenButton.h"
#import "OUTheme.h"

@interface OULocationCarousel () <OUListenButtonDelegate>

@property (nonatomic, strong) UILabel* areaLabel;

@end

@implementation OULocationCarousel

- (void)commonInit
{
    self.backgroundColor = [OUTheme brandColor];
    self.delegate = self;
    self.dataSource = self;
    

    self.type = iCarouselTypeLinear;
//    [self setContentOffset:CGSizeMake(-90, 0.0f)];
    self.areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 3.0f, [UIScreen mainScreen].bounds.size.width, 20.0f)];
    self.areaLabel.textAlignment = NSTextAlignmentCenter;
    self.areaLabel.textColor = [UIColor colorWithRed:210.0f / 255.0f green:210.0f / 255.0f blue:210.0f / 255.0f alpha:1.0f];
    self.areaLabel.font = [UIFont fontWithName:@"AvenirNext-Regular"  size:14.0];
    self.areaLabel.text = [@"Campus" uppercaseString];
    
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
    return 30;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(OULocationCarouselItem *)view {
    
    OUListenButton* listenButton = nil;
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[OULocationCarouselItem alloc] initWithFrame:CGRectMake(0.0f, 25.0f, 180.0f, 206.0f)];
        
        CGFloat buttonX = 44.0f;
        CGFloat buttonY = 115.0f;
        CGFloat buttonWidth = view.frame.size.width - (buttonX * 2.0f);
        CGFloat buttonHeight = 24.0f;

        listenButton = [[OUListenButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight)];
        listenButton.delegate = self;
        listenButton.tag = index;
        [view addSubview:listenButton];
//        view.contentMode = UIViewContentModeCenter;
        
//        cardBase = [[UIView alloc] initWithFrame:CGRectMake(0.5f, 24.0f, 179.0f, 186.0f)];
//        cardBase.backgroundColor = [UIColor whiteColor];
        
        
    
    }
    else
    {
        //get a reference to the label in the recycled view
        listenButton = (OUListenButton *)[view viewWithTag:index];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    listenButton.selected = NO;
    
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

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return 180.0f;
}

//- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
//    CGFloat offsetFactor = [self carousel:carousel valueForOption:iCarouselOptionSpacing withDefault:1.0f] * carousel.itemWidth;
//    
//    // Higher number = faster Z space movement
//    const CGFloat zFactor = 50.0f;
//    
//    // Higher number = faster shrinking
//    const CGFloat shrinkFactor = 5.0f;
//    
//    // Hyperbola = Ω
//    CGFloat carouselShape = sqrt(offset * offset + 1) - 1;
//    
//    transform = CATransform3DTranslate(transform, offset * offsetFactor, 0, carouselShape * (-zFactor));
//    transform = CATransform3DScale(transform, 1 / (carouselShape / shrinkFactor + 1.0f), 1 / (carouselShape / shrinkFactor + 1.0f), 1.0);
//    
//    return transform;
//}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    
    return value;
}

#pragma mark - Listen Button Delegate

- (void)isListening:(BOOL)isListening {
    
}

@end
