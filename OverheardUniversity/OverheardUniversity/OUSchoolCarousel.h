//
//  OUSchoolCarousel.h
//  OverheardUniversity
//
//  Created by Tyler Kuster on 7/30/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import "iCarousel.h"

typedef NS_ENUM(NSInteger, CarouselState)
{
    CarouselStateHidden,
    CarouselStateVisible,
};

@interface OUSchoolCarousel : iCarousel <iCarouselDelegate, iCarouselDataSource>

- (void)setCarouselState:(CarouselState)carouselState;

@end
