//
//  OUFooterView.h
//  OverheardUniversity
//
//  Created by Tyler Kuster on 8/13/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OUFooterView;

@protocol OUFooterViewDelegate <NSObject>
- (void)presentCreatePostView;
//- (void)presentTabBar;
//- (void)logOut;

@end

@interface OUFooterView : UIView

@property (weak, nonatomic) id<OUFooterViewDelegate> delegate;

@end
