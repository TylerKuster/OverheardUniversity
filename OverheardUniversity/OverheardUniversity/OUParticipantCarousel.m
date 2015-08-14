//
//  OUParticipantCarousel.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 8/13/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import "OUParticipantCarousel.h"

@implementation OUParticipantCarousel

- (void)commonInit
{
    //    self.backgroundColor = [UIColor purpleColor];
    
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

@end
