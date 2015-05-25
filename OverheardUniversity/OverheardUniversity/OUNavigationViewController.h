//
//  OUMainViewController.h
//  overhearduniversity
//
//  Created by Tyler Kuster on 4/26/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTSlidingPagesDataSource.h"
#import "TTSliddingPageDelegate.h"

@interface OUNavigationViewController : UIViewController <TTSlidingPagesDataSource, TTSliddingPageDelegate>

@end
