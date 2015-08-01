//
//  AppDelegate.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 7/28/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import "AppDelegate.h"

#import "AppDelegate.h"

#import "OUConstants.h"
#import "OUUtility.h"
#import "OUCache.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "OUHomeViewController.h"
#import "OULogInViewController.h"
#import "OURegisterViewController.h"
#import "UIImage+ResizeAdditions.h"
//#import "PAPAccountViewController.h"
#import "OUWelcomeViewController.h"
#import "OUProfileViewController.h"
//#import "PAPPhotoDetailsViewController.h"

@interface AppDelegate () {
    NSMutableData *_data;
    BOOL firstLaunch;
}

@property (nonatomic, strong) OUHomeViewController *homeViewController;
@property (nonatomic, strong) OUProfileViewController *profileViewController;
@property (nonatomic, strong) OUWelcomeViewController *welcomeViewController;
//
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) NSTimer *autoFollowTimer;
//
@property (nonatomic, strong) Reachability *hostReach;
@property (nonatomic, strong) Reachability *internetReach;
@property (nonatomic, strong) Reachability *wifiReach;
//
- (void)setupAppearance;
- (BOOL)shouldProceedToMainInterface:(PFUser *)user;
- (BOOL)handleActionURL:(NSURL *)url;
@end

@implementation AppDelegate

@synthesize window;
@synthesize navController;
@synthesize tabBarController;
@synthesize networkStatus;

@synthesize homeViewController;
@synthesize profileViewController;
@synthesize welcomeViewController;

@synthesize hud;
@synthesize autoFollowTimer;

@synthesize hostReach;
@synthesize internetReach;
@synthesize wifiReach;


#pragma mark UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // ****************************************************************************
    // Parse initialization
    [Parse setApplicationId:@"s1516d9AGrB8gWz3GFZ8ykwwNgs5X7Kv8HWUOTLT" clientKey:@"2n67WP9wvOe5TOUdcwZG8UIRDpzj169j3oaGD7Sz"];
    //
    // Make sure to update your URL scheme to match this facebook id. It should be "fbFACEBOOK_APP_ID" where FACEBOOK_APP_ID is your Facebook app's id.
    // You may set one up at https://developers.facebook.com/apps
//    [PFFacebookUtils initializeWithApplicationId:@"694865510631557"];
    // ****************************************************************************
    
    if (application.applicationIconBadgeNumber != 0) {
        application.applicationIconBadgeNumber = 0;
        [[PFInstallation currentInstallation] saveEventually];
    }
    
    PFACL *defaultACL = [PFACL ACL];
    // Enable public read access by default, with any newly created PFObjects belonging to the current user
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    // Set up our app's global UIAppearance
    [self setupAppearance];
    
    // Use Reachability to monitor connectivity
    [self monitorReachability];
    
    self.welcomeViewController = [[OUWelcomeViewController alloc] init];
    self.tabBarController = [[OUTabBarController alloc] init];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.welcomeViewController];
    self.navController.navigationBarHidden = YES;
    
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    [self handlePush:launchOptions];
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"FirstLaunch"]) {
        firstLaunch = YES;
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL handledActionURL = [self handleActionURL:url];
    
    if (handledActionURL) {
        return YES;
    }
    
    return nil;// [PFFacebookUtils handleOpenURL:url];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    [PFPush storeDeviceToken:newDeviceToken];
    
    if (application.applicationIconBadgeNumber != 0) {
        application.applicationIconBadgeNumber = 0;
    }
    
    [[PFInstallation currentInstallation] addUniqueObject:@"" forKey:kOUInstallationChannelsKey];
    if ([PFUser currentUser]) {
        // Make sure they are subscribed to their private push channel
        NSString *privateChannelName = [[PFUser currentUser] objectForKey:kOUUserPrivateChannelKey];
        if (privateChannelName && privateChannelName.length > 0) {
            NSLog(@"Subscribing user to %@", privateChannelName);
            [[PFInstallation currentInstallation] addUniqueObject:privateChannelName forKey:kOUInstallationChannelsKey];
        }
    }
    [[PFInstallation currentInstallation] saveEventually];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if ([error code] != 3010) { // 3010 is for the iPhone Simulator
        NSLog(@"Application failed to register for push notifications: %@", error);
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:OUAppDelegateApplicationDidReceiveRemoteNotification object:nil userInfo:userInfo];
    
    if ([PFUser currentUser]) {
        if ([self.tabBarController viewControllers].count > OUProfileNavItemIndex) {
            UITabBarItem *tabBarItem = [[[self.tabBarController viewControllers] objectAtIndex:OUProfileNavItemIndex] tabBarItem];
    
            NSString *currentBadgeValue = tabBarItem.badgeValue;
            
            if (currentBadgeValue && currentBadgeValue.length > 0) {
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                NSNumber *badgeValue = [numberFormatter numberFromString:currentBadgeValue];
                NSNumber *newBadgeValue = [NSNumber numberWithInt:[badgeValue intValue] + 1];
                tabBarItem.badgeValue = [numberFormatter stringFromNumber:newBadgeValue];
            } else {
                tabBarItem.badgeValue = @"1";
            }
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (application.applicationIconBadgeNumber != 0) {
        application.applicationIconBadgeNumber = 0;
        [[PFInstallation currentInstallation] saveEventually];
    }
}


#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)aTabBarController shouldSelectViewController:(UIViewController *)viewController {
    // The empty UITabBarItem behind our Camera button should not load a view controller
    return ![viewController isEqual:[[aTabBarController viewControllers] objectAtIndex:OUEmptyNavItemIndex]];
}


#pragma mark - PFLoginViewController

- (void)logInViewController:(OULogInViewController *)logInController didLogInUser:(PFUser *)user {
    // user has logged in - we need to fetch all of their Facebook data before we let them in
    if (![self shouldProceedToMainInterface:user]) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.navController.presentedViewController.view animated:YES];
        [self.hud setLabelText:@"Loading"];
        [self.hud setDimBackground:YES];
    }
    
//    [[PFFacebookUtils facebook] requestWithGraphPath:@"me/?fields=name,picture" andDelegate:self];
    
    // Subscribe to private push channel
    if (user) {
        NSString *privateChannelName = [NSString stringWithFormat:@"user_%@", [user objectId]];
        [[PFInstallation currentInstallation] setObject:[PFUser currentUser] forKey:kOUInstallationUserKey];
        [[PFInstallation currentInstallation] addUniqueObject:privateChannelName forKey:kOUInstallationChannelsKey];
        [[PFInstallation currentInstallation] saveEventually];
        [user setObject:privateChannelName forKey:kOUUserPrivateChannelKey];
    }
}
/*
#pragma mark - PF_FBRequestDelegate
- (void)request:(PF_FBRequest *)request didLoad:(id)result {
    // This method is called twice - once for the user's /me profile, and a second time when obtaining their friends. We will try and handle both scenarios in a single method.
    
    NSArray *data = [result objectForKey:@"data"];
    
    if (data) {
        // we have friends data
        NSMutableArray *facebookIds = [[NSMutableArray alloc] initWithCapacity:[data count]];
        for (NSDictionary *friendData in data) {
            [facebookIds addObject:[friendData objectForKey:@"id"]];
        }
        
        // cache friend data
        [[PAPCache sharedCache] setFacebookFriends:facebookIds];
        
        if (![[PFUser currentUser] objectForKey:kPAPUserAlreadyAutoFollowedFacebookFriendsKey]) {
            [self.hud setLabelText:@"Following Friends"];
            NSLog(@"Auto-following");
            firstLaunch = YES;
            
            [[PFUser currentUser] setObject:[NSNumber numberWithBool:YES] forKey:kPAPUserAlreadyAutoFollowedFacebookFriendsKey];
            NSError *error = nil;
            
            // find common Facebook friends already using Anypic
            PFQuery *facebookFriendsQuery = [PFUser query];
            [facebookFriendsQuery whereKey:kPAPUserFacebookIDKey containedIn:facebookIds];
            
            NSArray *anypicFriends = [facebookFriendsQuery findObjects:&error];
            if (!error) {
                [anypicFriends enumerateObjectsUsingBlock:^(PFUser *newFriend, NSUInteger idx, BOOL *stop) {
                    NSLog(@"Join activity for %@", [newFriend objectForKey:kPAPUserDisplayNameKey]);
                    PFObject *joinActivity = [PFObject objectWithClassName:kPAPActivityClassKey];
                    [joinActivity setObject:[PFUser currentUser] forKey:kPAPActivityFromUserKey];
                    [joinActivity setObject:newFriend forKey:kPAPActivityToUserKey];
                    [joinActivity setObject:kPAPActivityTypeJoined forKey:kPAPActivityTypeKey];
                    
                    PFACL *joinACL = [PFACL ACL];
                    [joinACL setPublicReadAccess:YES];
                    joinActivity.ACL = joinACL;
                    
                    // make sure our join activity is always earlier than a follow
                    [joinActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            NSLog(@"Followed %@", [newFriend objectForKey:kPAPUserDisplayNameKey]);
                        }
                        
                        [PAPUtility followUserInBackground:newFriend block:^(BOOL succeeded, NSError *error) {
                            // This block will be executed once for each friend that is followed.
                            // We need to refresh the timeline when we are following at least a few friends
                            // Use a timer to avoid refreshing innecessarily
                            if (self.autoFollowTimer) {
                                [self.autoFollowTimer invalidate];
                            }
                            
                            self.autoFollowTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(autoFollowTimerFired:) userInfo:nil repeats:NO];
                        }];
                    }];
                }];
            }
            
            if (![self shouldProceedToMainInterface:[PFUser currentUser]]) {
                [self logOut];
                return;
            }
            
            if (!error) {
                [MBProgressHUD hideHUDForView:self.navController.presentedViewController.view animated:NO];
                self.hud = [MBProgressHUD showHUDAddedTo:self.homeViewController.view animated:NO];
                [self.hud setDimBackground:YES];
                [self.hud setLabelText:@"Following Friends"];
            }
        }
        
        [[PFUser currentUser] saveEventually];
    } else {
        [self.hud setLabelText:@"Creating Profile"];
        NSString *facebookId = [result objectForKey:@"id"];
        NSString *facebookName = [result objectForKey:@"name"];
        
        if (facebookName && facebookName != 0) {
            [[PFUser currentUser] setObject:facebookName forKey:kPAPUserDisplayNameKey];
        }
        
        if (facebookId && facebookId != 0) {
            [[PFUser currentUser] setObject:facebookId forKey:kPAPUserFacebookIDKey];
        }
        
        [[PFFacebookUtils facebook] requestWithGraphPath:@"me/friends" andDelegate:self];
    }
}

- (void)request:(PF_FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Facebook error: %@", error);
    
    if ([PFUser currentUser]) {
        if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
             isEqualToString: @"OAuthException"]) {
            NSLog(@"The facebook token was invalidated");
            [self logOut];
        }
    }
}*/


#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
}

//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    [PAPUtility processFacebookProfilePictureData:_data];
//}

#pragma mark - AppDelegate

- (BOOL)isParseReachable {
    return self.networkStatus != NotReachable;
}

- (void)presentLoginViewControllerAnimated:(BOOL)animated {
    OULogInViewController *loginViewController = [[OULogInViewController   alloc] init];
//    [loginViewController setDelegate:self];
//    loginViewController.fields = PFLogInFieldsFacebook;
//    loginViewController.facebookPermissions = [NSArray arrayWithObjects:@"user_about_me", nil];
    
    [self.welcomeViewController presentViewController:loginViewController animated:NO completion:nil];
}


- (void)presentLoginViewController {
    [self presentLoginViewControllerAnimated:YES];
}

- (void)presentTabBarController {
    self.tabBarController = [[OUTabBarController alloc] init];
    self.homeViewController = [[OUHomeViewController alloc] init];
    [self.homeViewController setFirstLaunch:firstLaunch];
    self.profileViewController = [[OUProfileViewController alloc] init];
    
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:self.homeViewController];
    UINavigationController *emptyNavigationController = [[UINavigationController alloc] init];
    UINavigationController *activityFeedNavigationController = [[UINavigationController alloc] initWithRootViewController:self.profileViewController];

    
    UITabBarItem *homeTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
    [homeTabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"IconHomeSelected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"IconHome.png"]];
    [homeTabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIColor colorWithRed:86.0f/255.0f green:55.0f/255.0f blue:42.0f/255.0f alpha:1.0f], UITextAttributeTextColor,
                                            nil] forState:UIControlStateNormal];
    [homeTabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIColor colorWithRed:129.0f/255.0f green:99.0f/255.0f blue:69.0f/255.0f alpha:1.0f], UITextAttributeTextColor,
                                            nil] forState:UIControlStateSelected];
    
    UITabBarItem *activityFeedTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Activity" image:nil tag:0];
    [activityFeedTabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"IconTimelineSelected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"IconTimeline.png"]];
    [activityFeedTabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                    [UIColor colorWithRed:86.0f/255.0f green:55.0f/255.0f blue:42.0f/255.0f alpha:1.0f], UITextAttributeTextColor,
                                                    nil] forState:UIControlStateNormal];
    [activityFeedTabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                    [UIColor colorWithRed:129.0f/255.0f green:99.0f/255.0f blue:69.0f/255.0f alpha:1.0f], UITextAttributeTextColor,
                                                    nil] forState:UIControlStateSelected];
    
    [homeNavigationController setTabBarItem:homeTabBarItem];
    [activityFeedNavigationController setTabBarItem:activityFeedTabBarItem];
    
    [self.tabBarController setDelegate:self];
    [self.tabBarController setViewControllers:[NSArray arrayWithObjects:homeNavigationController, emptyNavigationController, activityFeedNavigationController, nil]];
    
    [self.navController setViewControllers:[NSArray arrayWithObjects:self.welcomeViewController, self.tabBarController, nil] animated:NO];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    
    NSLog(@"Downloading user's profile picture");
    // Download user's profile picture
    NSURL *profilePictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [[PFUser currentUser] objectForKey:kOUUserFacebookIDKey]]];
    NSURLRequest *profilePictureURLRequest = [NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f]; // Facebook profile picture cache policy: Expires in 2 weeks
    [NSURLConnection connectionWithRequest:profilePictureURLRequest delegate:self];
}

- (void)logOut {
    // clear cache
    [[OUCache sharedCache] clear];
    
    // clear NSUserDefaults
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kOUUserDefaultsCacheFacebookFriendsKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kOUUserDefaultsActivityFeedViewControllerLastRefreshKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"FirstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Unsubscribe from push notifications
    [[PFInstallation currentInstallation] removeObjectForKey:kOUInstallationUserKey];
    [[PFInstallation currentInstallation] removeObject:[[PFUser currentUser] objectForKey:kOUUserPrivateChannelKey] forKey:kOUInstallationChannelsKey];
    [[PFInstallation currentInstallation] saveEventually];
    
    // Log out
    [PFUser logOut];
    
    // clear out cached data, view controllers, etc
    [self.navController popToRootViewControllerAnimated:NO];
    
    [self presentLoginViewController];
    
    self.homeViewController = nil;
    self.profileViewController = nil;
}


#pragma mark - ()

- (void)setupAppearance {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.498f green:0.388f blue:0.329f alpha:1.0f]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor],UITextAttributeTextColor,
                                                          [UIColor colorWithWhite:0.0f alpha:0.750f],UITextAttributeTextShadowColor,
                                                          [NSValue valueWithCGSize:CGSizeMake(0.0f, 1.0f)],UITextAttributeTextShadowOffset,
                                                          nil]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"BackgroundNavigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [[UIButton appearanceWhenContainedIn:[UINavigationBar class], nil] setBackgroundImage:[UIImage imageNamed:@"ButtonNavigationBar.png"] forState:UIControlStateNormal];
    [[UIButton appearanceWhenContainedIn:[UINavigationBar class], nil] setBackgroundImage:[UIImage imageNamed:@"ButtonNavigationBarSelected.png"] forState:UIControlStateHighlighted];
    [[UIButton appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleColor:[UIColor colorWithRed:214.0f/255.0f green:210.0f/255.0f blue:197.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"ButtonBack.png"]
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"ButtonBackSelected.png"]
                                                      forState:UIControlStateSelected
                                                    barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor colorWithRed:214.0f/255.0f green:210.0f/255.0f blue:197.0f/255.0f alpha:1.0f],UITextAttributeTextColor,
                                                          [UIColor colorWithWhite:0.0f alpha:0.750f],UITextAttributeTextShadowColor,
                                                          [NSValue valueWithCGSize:CGSizeMake(0.0f, 1.0f)],UITextAttributeTextShadowOffset,
                                                          nil] forState:UIControlStateNormal];
    
    [[UISearchBar appearance] setTintColor:[UIColor colorWithRed:32.0f/255.0f green:19.0f/255.0f blue:16.0f/255.0f alpha:1.0f]];
}

- (void)monitorReachability {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:ReachabilityChangedNotification object:nil];
    
    self.hostReach = [Reachability reachabilityWithHostName: @"api.parse.com"];
    [self.hostReach startNotifier];
    
    self.internetReach = [Reachability reachabilityForInternetConnection];
    [self.internetReach startNotifier];
    
    self.wifiReach = [Reachability reachabilityForLocalWiFi];
    [self.wifiReach startNotifier];
}

- (void)handlePush:(NSDictionary *)launchOptions {
    
    // If the app was launched in response to a push notification, we'll handle the payload here
    NSDictionary *remoteNotificationPayload = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotificationPayload) {
        [[NSNotificationCenter defaultCenter] postNotificationName:OUAppDelegateApplicationDidReceiveRemoteNotification object:nil userInfo:remoteNotificationPayload];
        
        if ([PFUser currentUser]) {
            // if the push notification payload references a photo, we will attempt to push this view controller into view
            NSString *postObjectId = [remoteNotificationPayload objectForKey:kOUPushPayloadPostObjectIdKey];
            NSString *fromObjectId = [remoteNotificationPayload objectForKey:kOUPushPayloadFromUserObjectIdKey];
            if (postObjectId && postObjectId.length > 0) {
                // check if this photo is already available locally.
                
                PFObject *targetPhoto = [PFObject objectWithoutDataWithClassName:kOUPostClassKey objectId:postObjectId];
//                for (PFObject *photo in [self.homeViewController objects]) {
//                    if ([[photo objectId] isEqualToString:photoObjectId]) {
//                        NSLog(@"Found a local copy");
//                        targetPhoto = photo;
//                        break;
//                    }
//                }
                
                // if we have a local copy of this photo, this won't result in a network fetch
//                [targetPhoto fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//                    if (!error) {
//                        UINavigationController *homeNavigationController = [[self.tabBarController viewControllers] objectAtIndex:PAPHomeTabBarItemIndex];
//                        [self.tabBarController setSelectedViewController:homeNavigationController];
                    
//                        PAPPhotoDetailsViewController *detailViewController = [[PAPPhotoDetailsViewController alloc] initWithPhoto:object];
//                        [homeNavigationController pushViewController:detailViewController animated:YES];
//                    }
//                }];
//            } else if (fromObjectId && fromObjectId.length > 0) {
//                // load fromUser's profile
//                
//                PFQuery *query = [PFUser query];
//                query.cachePolicy = kPFCachePolicyCacheElseNetwork;
//                [query getObjectInBackgroundWithId:fromObjectId block:^(PFObject *user, NSError *error) {
//                    if (!error) {
//                        UINavigationController *homeNavigationController = [[self.tabBarController viewControllers] objectAtIndex:PAPHomeTabBarItemIndex];
//                        [self.tabBarController setSelectedViewController:homeNavigationController];
//                        
//                        PAPAccountViewController *accountViewController = [[PAPAccountViewController alloc] initWithStyle:UITableViewStylePlain];
//                        [accountViewController setUser:(PFUser *)user];
//                        [homeNavigationController pushViewController:accountViewController animated:YES];
//                    }
//                }];
                
            }
        }
    }
}

- (void)autoFollowTimerFired:(NSTimer *)aTimer {
    [MBProgressHUD hideHUDForView:self.navController.presentedViewController.view animated:YES];
    [MBProgressHUD hideHUDForView:self.homeViewController.view animated:YES];
//    [self.homeViewController loadObjects];
}

- (BOOL)shouldProceedToMainInterface:(PFUser *)user {
    if ([OUUtility userHasValidFacebookData:[PFUser currentUser]]) {
        [MBProgressHUD hideHUDForView:self.navController.presentedViewController.view animated:YES];
        [self presentTabBarController];
        
        [self.navController dismissViewControllerAnimated:NO completion:nil];
        return YES;
    }
    
    return NO;
}

- (BOOL)handleActionURL:(NSURL *)url {
//    if ([[url host] isEqualToString:kPAPLaunchURLHostTakePicture]) {
//        if ([PFUser currentUser]) {
//            return [self.tabBarController shouldPresentPhotoCaptureController];
//        }
//    }
    
    return NO;
}

//Called by Reachability whenever status changes.
- (void)reachabilityChanged:(NSNotification* )note {
//    Reachability *curReach = (Reachability *)[note object];
//    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
//    NSLog(@"Reachability changed: %@", curReach);
//    networkStatus = [curReach currentReachabilityStatus];
//    
//    if ([self isParseReachable] && [PFUser currentUser] && self.homeViewController.objects.count == 0) {
//        // Refresh home timeline on network restoration. Takes care of a freshly installed app that failed to load the main timeline under bad network conditions.
//        // In this case, they'd see the empty timeline placeholder and have no way of refreshing the timeline unless they followed someone.
//        [self.homeViewController loadObjects];
//    }
}

@end
