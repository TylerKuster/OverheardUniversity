//
//  OUActionView.h
//  overhearduniversity
//
//  Created by Tyler Kuster on 6/14/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OUActionView;

@protocol OUActionViewDelegate <NSObject>
- (void)didConfirmRequest:(OUActionView*)actionView;
- (void)didCancelRequest:(OUActionView*)actionView;

@end

@interface OUActionView : UIView

- (id)initWithTitle:(NSString*)title
           subTitle:(NSString*)subTitle
  cancelButtonTitle:(NSString*)cancelButtonTitle
 confirmButtonTitle:(NSString*)confirmButtonTitle;

@property (weak, nonatomic) id<OUActionViewDelegate> delegate;

@end
