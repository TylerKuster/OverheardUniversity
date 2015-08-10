//
//  OUListenButton.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 8/2/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//


#import "OUListenButton.h"
#import "OUTheme.h"
@interface OUListenButton ()

@property (nonatomic, retain) UILabel* title;

@end

@implementation OUListenButton

- (void)commonInit
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[OUTheme brandColor] CGColor];
    self.layer.borderWidth = 1.0f;
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.5f, self.frame.size.width, self.frame.size.height)];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.textColor = [OUTheme brandColor];
    self.title.font = [UIFont fontWithName:@"AvenirNext-Medium"  size:14.0];
    self.title.text = @"+ Listen In";
    
    [self addSubview:self.title];
    
//    [self addTarget:self action:@selector(pluslistenButtonTapped) forControlEvents:UIControlEventTouchUpInside];
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

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
 
    if (selected) {
        [self.delegate isListening:YES];
        [self setSelectedColors];
    } else {
        [self.delegate isListening:NO];
        [self setNormalColors];
    }
    
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        [self setSelectedColors];
    } else {
        [self setNormalColors];
    }
    
    
}

- (void)setNormalColors {
    self.backgroundColor = [UIColor whiteColor];
    self.title.textColor = [OUTheme brandColor];
}

- (void)setSelectedColors {
    self.backgroundColor = [OUTheme brandColor];
    self.title.textColor = [UIColor whiteColor];
}

- (void)pluslistenButtonTapped {
 
    if (self.selected) {
        [self setSelected:NO];
    } else
    {
        [self setSelected:YES];
    }
}

@end
