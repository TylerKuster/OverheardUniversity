//
//  OUAreaCarousel.h
//  overhearduniversity
//
//  Created by Tyler Kuster on 7/5/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "iCarousel.h"

@class OUAreaCarousel;

@protocol OUAreaCarouselDelegate <NSObject>
- (void)carouselIsScrolling:(OUAreaCarousel*)aCarousel;
- (void)carouselEndedScrolling:(OUAreaCarousel*)aCarousel;

@end

@interface OUAreaCarousel : iCarousel

@property (weak, nonatomic) id<OUAreaCarouselDelegate> areaCarouselDelegate;

@end
