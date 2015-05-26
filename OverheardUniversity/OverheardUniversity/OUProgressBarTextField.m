//
//  OUProgressBarTextField.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 5/25/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "OUProgressBarTextField.h"

@implementation OUProgressBarTextField

- (void)commonInit
{
    CGFloat titleLabelYOffset = self.bounds.origin.y - 32.0f;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x, titleLabelYOffset, 100.0f, 40.0f)];
    self.titleLabel.text = @"Register";
    
    [self addSubview: self.titleLabel];
    
    self.backgroundColor = [UIColor blueColor];

    
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
