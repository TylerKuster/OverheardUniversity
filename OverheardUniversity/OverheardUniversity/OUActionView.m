//
//  OUActionView.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 6/14/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "OUActionView.h"

static const CGFloat actionViewHeight = 185;

@implementation OUActionView

- (void)commonInit
{
    self.backgroundColor = [UIColor blueColor];
}

- (id)init
{
    self = [super init];
    if (self){
        [self commonInit];
        NSLog(@"wrong init, need to set title, subtitle, cancel, and confirm");
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self commonInit];
        NSLog(@"wrong init, need to set title, subtitle, cancel, and confirm");
    }
    return self;
}

- (id)initWithTitle:(NSString*)title
           subTitle:(NSString*)subTitle
  cancelButtonTitle:(NSString*)cancelButtonTitle
 confirmButtonTitle:(NSString*)confirmButtonTitle
{
    self = [super init];
    if (self){
        [self commonInit];
        [self setFrame:CGRectMake(0.0f, [UIScreen mainScreen].bounds.size.height - actionViewHeight, [UIScreen mainScreen].bounds.size.width, actionViewHeight)];
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end
