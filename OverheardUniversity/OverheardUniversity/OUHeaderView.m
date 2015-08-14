//
//  OUHeaderView.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 8/14/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import "OUHeaderView.h"
#import "OUTheme.h"

@implementation OUHeaderView

- (void)commonInit
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.backgroundColor = [OUTheme brandColor];
    
    UIButton* search = [UIButton buttonWithType:UIButtonTypeCustom];
    search.frame = CGRectMake(16.0f, 26.0f, 32.0f, 32.0f);
    search.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:search];
    
    UIButton* refresh = [UIButton buttonWithType:UIButtonTypeCustom];
    refresh.frame = CGRectMake(screenWidth - 48.0f, 26.0f, 32.0f, 32.0f);
    refresh.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:refresh];
    
    UIImageView* logo = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth / 2.0f) - 50.5, 24, 101, 36)];
    logo.image = [UIImage imageNamed:@"overheardLogo"];
    
    [self addSubview:logo];
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

- (void)setHeaderViewState:(HeaderViewState)headerViewState {
    switch (headerViewState) {
        case HeaderViewStateMap:
        {
            break;
        }
        case HeaderViewStateFeed:
        {
            break;
        }
        case HeaderViewStatePost:
        {
            NSLog(@"todo: animate buttons");
            break;
        }
        default:
            break;
    }
}

@end
