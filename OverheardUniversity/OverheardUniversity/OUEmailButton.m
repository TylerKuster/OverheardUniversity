//
//  OUEmailButton.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 5/25/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "OUEmailButton.h"

@implementation OUEmailButton

- (void)commonInit
{
    self.backgroundColor = [UIColor blueColor];
    self.titleLabel.text = @"Register";
    
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


@end
