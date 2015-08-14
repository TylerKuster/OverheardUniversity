//
//  OUHeaderView.h
//  OverheardUniversity
//
//  Created by Tyler Kuster on 8/14/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HeaderViewState)
{
    HeaderViewStateMap,
    HeaderViewStateFeed,
    HeaderViewStatePost
};

@interface OUHeaderView : UIView

- (void)setHeaderViewState:(HeaderViewState)headerViewState;

@end
