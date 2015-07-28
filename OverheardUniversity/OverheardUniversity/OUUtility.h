//
//  OUUtility.h
//  overhearduniversity
//
//  Created by Tyler Kuster on 7/27/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

@interface OUUtility : NSObject

+ (void)likePostInBackground:(id)post block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)unlikePostInBackground:(id)post block:(void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (void)processFacebookProfilePictureData:(NSData *)data;

+ (BOOL)userHasValidFacebookData:(PFUser *)user;
+ (BOOL)userHasProfilePictures:(PFUser *)user;

+ (NSString *)firstNameForDisplayName:(NSString *)displayName;

+ (void)followUserInBackground:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)followUserEventually:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)followUsersEventually:(NSArray *)users block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)unfollowUserEventually:(PFUser *)user;
+ (void)unfollowUsersEventually:(NSArray *)users;

+ (void)sendFollowingPushNotification:(PFUser *)user;

+ (void)drawSideDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context;
+ (void)drawSideAndBottomDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context;
+ (void)drawSideAndTopDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context;
+ (void)addBottomDropShadowToNavigationBarForNavigationController:(UINavigationController *)navigationController;

+ (PFQuery *)queryForActivitiesOnPost:(PFObject *)post cachePolicy:(PFCachePolicy)cachePolicy;

@end
