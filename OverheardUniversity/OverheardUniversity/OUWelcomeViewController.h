//
//  OUWelcomeViewController.h
//  OverheardUniversity
//
//  Created by Tyler Kuster on 7/30/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class OUWelcomeViewController;

@protocol OUWelcomeViewControllerDelegate <NSObject>
- (void)presentLoginViewController;
- (void)presentTabBar;
- (void)logOut;

@end

typedef NS_ENUM(NSInteger, RegisterStage)
{
    RegisterName,
    RegisterUsername,
    RegisterPassword,
    RegisterEmail
};

@interface OUWelcomeViewController : UIViewController

@property (weak, nonatomic) id<OUWelcomeViewControllerDelegate> delegate;

@end
