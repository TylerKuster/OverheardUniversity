//
//  OUMainViewController.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 4/26/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//
#import "OUNavigationViewController.h"
#import "OUCampusCarousel.h"
#import <Parse/Parse.h>

#import "TTScrollSlidingPagesController.h"
#import "TTSlidingPage.h"
#import "TTSlidingPageTitle.h"
#import "TTSlidingPagesDataSource.h"
#import "TTSliddingPageDelegate.h"

static const CGFloat kTopBarHeight = 80.0f;

@interface OUNavigationViewController () <TTSlidingPagesDataSource, TTSliddingPageDelegate>
@property (strong, nonatomic) TTScrollSlidingPagesController *campusCarousel;

@end

@implementation OUNavigationViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];

    //initial setup of the TTScrollSlidingPagesController.
    self.campusCarousel = [[TTScrollSlidingPagesController alloc] init];
    self.campusCarousel.dataSource = self;
    self.campusCarousel.delegate = self;
    //     [self.slider setViewControllers:@[viewController1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
    //         NSLog(@"turnedd");
    //     }];
    //    self.slider.titleScrollerInActiveTextColour = [UIColor purpleColor];
    //    self.slider.titleScrollerBottomEdgeColour = [UIColor darkGrayColor];
    //    self.slider.titleScrollerBottomEdgeHeight = 2;
    
    //set properties to customiser the slider. Make sure you set these BEFORE you access any other properties on the slider, such as the view or the datasource. Best to do it immediately after calling the init method.
    self.campusCarousel.hideStatusBarWhenScrolling = NO;
    self.campusCarousel.titleScrollerHidden = YES;
    //slider.titleScrollerHeight = 100;
    //slider.titleScrollerItemWidth=60;
    //slider.titleScrollerBackgroundColour = [UIColor darkGrayColor];
    self.campusCarousel.disableTitleScrollerShadow = YES;
    self.campusCarousel.disableUIPageControl = YES;
    self.campusCarousel.initialPageNumber = 0;
    self.campusCarousel.pagingEnabled = YES;
    self.campusCarousel.zoomOutAnimationDisabled = YES;
    //self.slider.disableTitleShadow = YES;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7){
        self.campusCarousel.hideStatusBarWhenScrolling = YES;//this property normally only makes sense on iOS7+. See the documentation in TTScrollSlidingPagesController.h. If you wanted to use it in iOS6 you'd have to make sure the status bar overlapped the TTScrollSlidingPagesController.
    }
    
    //add the slider's view to this view as a subview, and add the viewcontroller to this viewcontrollers child collection (so that it gets retained and stays in memory! And gets all relevant events in the view controller lifecycle)
    self.campusCarousel.view.frame = self.view.frame;
    [self.view insertSubview:self.campusCarousel.view atIndex:0];
    [self addChildViewController:self.campusCarousel];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TTSlidingPagesDataSource methods

-(int)numberOfPagesForSlidingPagesViewController:(TTScrollSlidingPagesController *)source{
    return 2;
}

-(TTSlidingPage *)pageForSlidingPagesViewController:(TTScrollSlidingPagesController*)source atIndex:(int)index
{
    //    NSUUID *appID = [[NSUUID alloc] initWithUUIDString:@"d0b43270-f777-11e4-8f6b-667982007156"];
    //
    //    LYRClient *layerClient = [LYRClient clientWithAppID:appID];
    
//    switch (index) {
//        case OnboardingLocationRequest:
//        {
//            LocationRequestViewController* viewController1 = [self.storyboard instantiateViewControllerWithIdentifier:@"locationRequest"];
//            viewController1.delegate = self;
//            
//            return [[TTSlidingPage alloc] initWithContentViewController: viewController1];
//            
//            break;
//        }
//        case OnboardingSchoolsGrid:
//        {
//            SchoolListViewController* viewController2 = [self.storyboard instantiateViewControllerWithIdentifier:@"schoolList"];
//            
//            return [[TTSlidingPage alloc] initWithContentViewController: viewController2];
//            
//            break;
//        }
//        case OnboardingRegister:
//        {
//            RegisterViewController* viewController3 = [RegisterViewController new];
//            
//            return [[TTSlidingPage alloc] initWithContentViewController: viewController3];
//            
//            break;
//        }
//        case OnboardingLogin:
//        {
//            LoginViewController* viewController = [LoginViewController new];
//            
//            return [[TTSlidingPage alloc] initWithContentViewController: viewController];
//            
//            break;
//        }
//        default:
//            break;
//    }
//    
//    //            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 250.0f, 320.0f, 100.0f)];
//    //            label.textAlignment = NSTextAlignmentCenter;
//    //            label.text = [NSString stringWithFormat:@"On boarding screen %i", ++index];
//    //
//    //            [viewController.view addSubview:label];
//
    UIViewController* viewController = [UIViewController new];
    viewController.view.backgroundColor = [UIColor orangeColor];
    
    [self testPost];
    
    return [[TTSlidingPage alloc] initWithContentViewController: viewController];
}

-(TTSlidingPageTitle *)titleForSlidingPagesViewController:(TTScrollSlidingPagesController *)source atIndex:(int)index{
    TTSlidingPageTitle *title;
    if (index == 0){
        //use a image as the header for the first page
        title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"Profile"];
        //        title= [[TTSlidingPageTitle alloc] initWithHeaderImage:[UIImage imageNamed:@"about-tomthorpelogo.png"]];
    } else {
        //all other pages just use a simple text header
        switch (index) {
            case 1:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"Log In"];
                break;
            case 2:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"Log In"];
                break;
            case 3:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"More Stuff"];
                break;
            case 4:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"Another Page"];
                break;
            default:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:[NSString stringWithFormat:@"Page %d", index+1]];
                break;
        }
        
    }
    return title;
}

- (void)testPost
{
    // create a photo object
    PFObject *post = [PFObject objectWithClassName:kPAPPhotoClassKey];
    [photo setObject:[PFUser currentUser] forKey:kPAPPhotoUserKey];
    [photo setObject:self.photoFile forKey:kPAPPhotoPictureKey];
    [photo setObject:self.thumbnailFile forKey:kPAPPhotoThumbnailKey];
    
    // photos are public, but may only be modified by the user who uploaded them
    PFACL *photoACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [photoACL setPublicReadAccess:YES];
    photo.ACL = photoACL;
    
    // Request a background execution task to allow us to finish uploading the photo even if the app is backgrounded
    self.photoPostBackgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:self.photoPostBackgroundTaskId];
    }];
    
    // save
    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Photo uploaded");
            
            [[PAPCache sharedCache] setAttributesForPhoto:photo likers:[NSArray array] commenters:[NSArray array] likedByCurrentUser:NO];
            
            // userInfo might contain any caption which might have been posted by the uploader
            if (userInfo) {
                NSString *commentText = [userInfo objectForKey:kPAPEditPhotoViewControllerUserInfoCommentKey];
                
                if (commentText && commentText.length != 0) {
                    // create and save photo caption
                    PFObject *comment = [PFObject objectWithClassName:kPAPActivityClassKey];
                    [comment setObject:kPAPActivityTypeComment forKey:kPAPActivityTypeKey];
                    [comment setObject:photo forKey:kPAPActivityPhotoKey];
                    [comment setObject:[PFUser currentUser] forKey:kPAPActivityFromUserKey];
                    [comment setObject:[PFUser currentUser] forKey:kPAPActivityToUserKey];
                    [comment setObject:commentText forKey:kPAPActivityContentKey];
                    
                    PFACL *ACL = [PFACL ACLWithUser:[PFUser currentUser]];
                    [ACL setPublicReadAccess:YES];
                    comment.ACL = ACL;
                    
                    [comment saveEventually];
                    [[PAPCache sharedCache] incrementCommentCountForPhoto:photo];
                }
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:PAPTabBarControllerDidFinishEditingPhotoNotification object:photo];
        } else {
            NSLog(@"Photo failed to save: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't post your photo" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
            [alert show];
        }
        [[UIApplication sharedApplication] endBackgroundTask:self.photoPostBackgroundTaskId];
    }];
}

@end
