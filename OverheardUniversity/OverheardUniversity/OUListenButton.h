//
//  OUListenButton.h
//  OverheardUniversity
//
//  Created by Tyler Kuster on 8/2/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OUListenButton;

@protocol OUListenButtonDelegate <NSObject>
- (void)isListening:(BOOL)isListening;

@end

@interface OUListenButton : UIButton

@property (weak, nonatomic) id<OUListenButtonDelegate> delegate;

@end
