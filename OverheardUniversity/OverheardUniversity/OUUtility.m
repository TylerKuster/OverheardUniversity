//
//  OUUtility.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 7/27/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "OUUtility.h"
#import "UIImage+ResizeAdditions.h"

@implementation OUUtility
#pragma mark - OUUtility
#pragma mark Like Photos

+ (void)likePostInBackground:(id)post block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    PFQuery *queryExistingLikes = [PFQuery queryWithClassName:kOUActivityClassKey];
    [queryExistingLikes whereKey:kOUActivityPostKey equalTo:post];
    [queryExistingLikes whereKey:kOUActivityTypeKey equalTo:kOUActivityTypeLike];
    [queryExistingLikes whereKey:kOUActivityFromUserKey equalTo:[PFUser currentUser]];
    [queryExistingLikes setCachePolicy:kPFCachePolicyNetworkOnly];
    [queryExistingLikes findObjectsInBackgroundWithBlock:^(NSArray *activities, NSError *error) {
        if (!error) {
            for (PFObject *activity in activities) {
                [activity delete];
            }
        }
        
        // proceed to creating new like
        PFObject *likeActivity = [PFObject objectWithClassName:kOUActivityClassKey];
        [likeActivity setObject:kOUActivityTypeLike forKey:kOUActivityTypeKey];
        [likeActivity setObject:[PFUser currentUser] forKey:kOUActivityFromUserKey];
        [likeActivity setObject:[post objectForKey:kOUPostUserKey] forKey:kOUActivityToUserKey];
        [likeActivity setObject:post forKey:kOUActivityPostKey];
        
        PFACL *likeACL = [PFACL ACLWithUser:[PFUser currentUser]];
        [likeACL setPublicReadAccess:YES];
        likeActivity.ACL = likeACL;
        
        [likeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (completionBlock) {
                completionBlock(succeeded,error);
            }
            
            if (succeeded && ![[[post objectForKey:kOUPostUserKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                NSString *privateChannelName = [[post objectForKey:kOUPostUserKey] objectForKey:kOUUserPrivateChannelKey];
                if (privateChannelName && privateChannelName.length != 0) {
                    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSString stringWithFormat:@"%@ likes your photo.", [OUUtility firstNameForDisplayName:[[PFUser currentUser] objectForKey:kOUUserDisplayNameKey]]], kAPNSAlertKey,
                                          kOUPushPayloadPayloadTypeActivityKey, kOUPushPayloadPayloadTypeKey,
                                          kOUPushPayloadActivityLikeKey, kOUPushPayloadActivityTypeKey,
                                          [[PFUser currentUser] objectId], kOUPushPayloadFromUserObjectIdKey,
                                          [post objectId], kOUPushPayloadPostObjectIdKey,
                                          nil];
                    PFPush *push = [[PFPush alloc] init];
                    [push setChannel:privateChannelName];
                    [push setData:data];
                    [push sendPushInBackground];
                }
            }
            
            // refresh cache
            PFQuery *query = [OUUtility queryForActivitiesOnPhoto:post cachePolicy:kPFCachePolicyNetworkOnly];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    
                    NSMutableArray *likers = [NSMutableArray array];
                    NSMutableArray *commenters = [NSMutableArray array];
                    
                    BOOL isLikedByCurrentUser = NO;
                    
                    for (PFObject *activity in objects) {
                        if ([[activity objectForKey:kOUActivityTypeKey] isEqualToString:kOUActivityTypeLike] && [activity objectForKey:kOUActivityFromUserKey]) {
                            [likers addObject:[activity objectForKey:kOUActivityFromUserKey]];
                        } else if ([[activity objectForKey:kOUActivityTypeKey] isEqualToString:kOUActivityTypeComment] && [activity objectForKey:kOUActivityFromUserKey]) {
                            [commenters addObject:[activity objectForKey:kOUActivityFromUserKey]];
                        }
                        
                        if ([[[activity objectForKey:kOUActivityFromUserKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                            if ([[activity objectForKey:kOUActivityTypeKey] isEqualToString:kOUActivityTypeLike]) {
                                isLikedByCurrentUser = YES;
                            }
                        }
                    }
                    
                    [[OUCache sharedCache] setAttributesForPost:post likers:likers commenters:commenters likedByCurrentUser:isLikedByCurrentUser];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:OUUtilityUserLikedUnlikedPostCallbackFinishedNotification object:post userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:succeeded] forKey:OUPostDetailsViewControllerUserLikedUnlikedPostNotificationUserInfoLikedKey]];
            }];
            
        }];
    }];
    
    /*
     // like photo in Facebook if possible
     NSString *fbOpenGraphID = [photo objectForKey:kOUPhotoOpenGraphIDKey];
     if (fbOpenGraphID && fbOpenGraphID.length > 0) {
     NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
     NSString *objectURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@", fbOpenGraphID];
     [params setObject:objectURL forKey:@"object"];
     [[PFFacebookUtils facebook] requestWithGraphPath:@"me/og.likes" andParams:params andHttpMethod:@"POST" andDelegate:nil];
     }
     */
}

+ (void)unlikePostInBackground:(id)post block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    PFQuery *queryExistingLikes = [PFQuery queryWithClassName:kOUActivityClassKey];
    [queryExistingLikes whereKey:kOUActivityPostKey equalTo:post];
    [queryExistingLikes whereKey:kOUActivityTypeKey equalTo:kOUActivityTypeLike];
    [queryExistingLikes whereKey:kOUActivityFromUserKey equalTo:[PFUser currentUser]];
    [queryExistingLikes setCachePolicy:kPFCachePolicyNetworkOnly];
    [queryExistingLikes findObjectsInBackgroundWithBlock:^(NSArray *activities, NSError *error) {
        if (!error) {
            for (PFObject *activity in activities) {
                [activity delete];
            }
            
            if (completionBlock) {
                completionBlock(YES,nil);
            }
            
            // refresh cache
            PFQuery *query = [OUUtility queryForActivitiesOnPhoto:post cachePolicy:kPFCachePolicyNetworkOnly];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    
                    NSMutableArray *likers = [NSMutableArray array];
                    NSMutableArray *commenters = [NSMutableArray array];
                    
                    BOOL isLikedByCurrentUser = NO;
                    
                    for (PFObject *activity in objects) {
                        if ([[activity objectForKey:kOUActivityTypeKey] isEqualToString:kOUActivityTypeLike]) {
                            [likers addObject:[activity objectForKey:kOUActivityFromUserKey]];
                        } else if ([[activity objectForKey:kOUActivityTypeKey] isEqualToString:kOUActivityTypeComment]) {
                            [commenters addObject:[activity objectForKey:kOUActivityFromUserKey]];
                        }
                        
                        if ([[[activity objectForKey:kOUActivityFromUserKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                            if ([[activity objectForKey:kOUActivityTypeKey] isEqualToString:kOUActivityTypeLike]) {
                                isLikedByCurrentUser = YES;
                            }
                        }
                    }
                    
                    [[OUCache sharedCache] setAttributesForPost:post likers:likers commenters:commenters likedByCurrentUser:isLikedByCurrentUser];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:OUUtilityUserLikedUnlikedPostCallbackFinishedNotification object:post userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:OUPostDetailsViewControllerUserLikedUnlikedPostNotificationUserInfoLikedKey]];
            }];
            
        } else {
            if (completionBlock) {
                completionBlock(NO,error);
            }
        }
    }];
}


#pragma mark Facebook

+ (void)processFacebookProfilePictureData:(NSData *)newProfilePictureData {
    if (newProfilePictureData.length == 0) {
        NSLog(@"Profile picture did not download successfully.");
        return;
    }
    
    // The user's Facebook profile picture is cached to disk. Check if the cached profile picture data matches the incoming profile picture. If it does, avoid uploading this data to Parse.
    
    NSURL *cachesDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject]; // iOS Caches directory
    
    NSURL *profilePictureCacheURL = [cachesDirectoryURL URLByAppendingPathComponent:@"FacebookProfilePicture.jpg"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[profilePictureCacheURL path]]) {
        // We have a cached Facebook profile picture
        
        NSData *oldProfilePictureData = [NSData dataWithContentsOfFile:[profilePictureCacheURL path]];
        
        if ([oldProfilePictureData isEqualToData:newProfilePictureData]) {
            NSLog(@"Cached profile picture matches incoming profile picture. Will not update.");
            return;
        }
    }
    
    BOOL cachedToDisk = [[NSFileManager defaultManager] createFileAtPath:[profilePictureCacheURL path] contents:newProfilePictureData attributes:nil];
    NSLog(@"Wrote profile picture to disk cache: %d", cachedToDisk);
    
    UIImage *image = [UIImage imageWithData:newProfilePictureData];
    
    UIImage *mediumImage = [image thumbnailImage:280 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh];
    UIImage *smallRoundedImage = [image thumbnailImage:64 transparentBorder:0 cornerRadius:9 interpolationQuality:kCGInterpolationLow];
    
    NSData *mediumImageData = UIImageJPEGRepresentation(mediumImage, 0.5); // using JPEG for larger pictures
    NSData *smallRoundedImageData = UIImagePNGRepresentation(smallRoundedImage);
    
    if (mediumImageData.length > 0) {
        NSLog(@"Uploading Medium Profile Picture");
        PFFile *fileMediumImage = [PFFile fileWithData:mediumImageData];
        [fileMediumImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"Uploaded Medium Profile Picture");
                [[PFUser currentUser] setObject:fileMediumImage forKey:kOUUserProfilePictureKey];
                [[PFUser currentUser] saveEventually];
            }
        }];
    } else if (smallRoundedImageData.length > 0) {
        NSLog(@"Uploading Profile Picture Thumbnail");
        PFFile *fileSmallRoundedImage = [PFFile fileWithData:smallRoundedImageData];
        [fileSmallRoundedImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"Uploaded Profile Picture Thumbnail");
                [[PFUser currentUser] setObject:fileSmallRoundedImage forKey:kOUUserProfilePictureKey];
                [[PFUser currentUser] saveEventually];
            }
        }];
    }
}

+ (BOOL)userHasValidFacebookData:(PFUser *)user {
    NSString *facebookId = [user objectForKey:kOUUserFacebookIDKey];
    return (facebookId && facebookId.length > 0);
}

+ (BOOL)userHasProfilePictures:(PFUser *)user {
    PFFile *profilePicture = [user objectForKey:kOUUserProfilePictureKey];
    
    return profilePicture;
}


#pragma mark Display Name

+ (NSString *)firstNameForDisplayName:(NSString *)displayName {
    if (!displayName || displayName.length == 0) {
        return @"Someone";
    }
    
    NSArray *displayNameComponents = [displayName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *firstName = [displayNameComponents objectAtIndex:0];
    if (firstName.length > 100) {
        // truncate to 100 so that it fits in a Push payload
        firstName = [firstName substringToIndex:100];
    }
    return firstName;
}


#pragma mark User Following

+ (void)followUserInBackground:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    if ([[user objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
        return;
    }
    
    PFObject *followActivity = [PFObject objectWithClassName:kOUActivityClassKey];
    [followActivity setObject:[PFUser currentUser] forKey:kOUActivityFromUserKey];
    [followActivity setObject:user forKey:kOUActivityToUserKey];
    [followActivity setObject:kOUActivityTypeFollow forKey:kOUActivityTypeKey];
    
    PFACL *followACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [followACL setPublicReadAccess:YES];
    followActivity.ACL = followACL;
    
    [followActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (completionBlock) {
            completionBlock(succeeded, error);
        }
        
        if (succeeded) {
            [OUUtility sendFollowingPushNotification:user];
        }
    }];
    [[OUCache sharedCache] setFollowStatus:YES user:user];
}

+ (void)followUserEventually:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    if ([[user objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
        return;
    }
    
    PFObject *followActivity = [PFObject objectWithClassName:kOUActivityClassKey];
    [followActivity setObject:[PFUser currentUser] forKey:kOUActivityFromUserKey];
    [followActivity setObject:user forKey:kOUActivityToUserKey];
    [followActivity setObject:kOUActivityTypeFollow forKey:kOUActivityTypeKey];
    
    PFACL *followACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [followACL setPublicReadAccess:YES];
    followActivity.ACL = followACL;
    
    [followActivity saveEventually:completionBlock];
    [[OUCache sharedCache] setFollowStatus:YES user:user];
}

+ (void)followUsersEventually:(NSArray *)users block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    for (PFUser *user in users) {
        [OUUtility followUserEventually:user block:completionBlock];
        [[OUCache sharedCache] setFollowStatus:YES user:user];
    }
}

+ (void)unfollowUserEventually:(PFUser *)user {
    PFQuery *query = [PFQuery queryWithClassName:kOUActivityClassKey];
    [query whereKey:kOUActivityFromUserKey equalTo:[PFUser currentUser]];
    [query whereKey:kOUActivityToUserKey equalTo:user];
    [query whereKey:kOUActivityTypeKey equalTo:kOUActivityTypeFollow];
    [query findObjectsInBackgroundWithBlock:^(NSArray *followActivities, NSError *error) {
        // While normally there should only be one follow activity returned, we can't guarantee that.
        
        if (!error) {
            for (PFObject *followActivity in followActivities) {
                [followActivity deleteEventually];
            }
        }
    }];
    [[OUCache sharedCache] setFollowStatus:NO user:user];
}

+ (void)unfollowUsersEventually:(NSArray *)users {
    PFQuery *query = [PFQuery queryWithClassName:kOUActivityClassKey];
    [query whereKey:kOUActivityFromUserKey equalTo:[PFUser currentUser]];
    [query whereKey:kOUActivityToUserKey containedIn:users];
    [query whereKey:kOUActivityTypeKey equalTo:kOUActivityTypeFollow];
    [query findObjectsInBackgroundWithBlock:^(NSArray *activities, NSError *error) {
        for (PFObject *activity in activities) {
            [activity deleteEventually];
        }
    }];
    for (PFUser *user in users) {
        [[OUCache sharedCache] setFollowStatus:NO user:user];
    }
}


#pragma mark Push

+ (void)sendFollowingPushNotification:(PFUser *)user {
    NSString *privateChannelName = [user objectForKey:kOUUserPrivateChannelKey];
    if (privateChannelName && privateChannelName.length != 0) {
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%@ is now following you on Anypic.", [OUUtility firstNameForDisplayName:[[PFUser currentUser] objectForKey:kOUUserDisplayNameKey]]], kAPNSAlertKey,
                              kOUPushPayloadPayloadTypeActivityKey, kOUPushPayloadPayloadTypeKey,
                              kOUPushPayloadActivityFollowKey, kOUPushPayloadActivityTypeKey,
                              [[PFUser currentUser] objectId], kOUPushPayloadFromUserObjectIdKey,
                              nil];
        PFPush *push = [[PFPush alloc] init];
        [push setChannel:privateChannelName];
        [push setData:data];
        [push sendPushInBackground];
    }
}

#pragma mark Activities

+ (PFQuery *)queryForActivitiesOnPhoto:(PFObject *)photo cachePolicy:(PFCachePolicy)cachePolicy {
    PFQuery *queryLikes = [PFQuery queryWithClassName:kOUActivityClassKey];
    [queryLikes whereKey:kOUActivityPostKey equalTo:photo];
    [queryLikes whereKey:kOUActivityTypeKey equalTo:kOUActivityTypeLike];
    
    PFQuery *queryComments = [PFQuery queryWithClassName:kOUActivityClassKey];
    [queryComments whereKey:kOUActivityPostKey equalTo:photo];
    [queryComments whereKey:kOUActivityTypeKey equalTo:kOUActivityTypeComment];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:queryLikes,queryComments,nil]];
    [query setCachePolicy:cachePolicy];
    [query includeKey:kOUActivityFromUserKey];
    [query includeKey:kOUActivityPostKey];
    
    return query;
}


#pragma mark Shadow Rendering

+ (void)drawSideAndBottomDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context {
    // Push the context
    CGContextSaveGState(context);
    
    // Set the clipping path to remove the rect drawn by drawing the shadow
    CGRect boundingRect = CGContextGetClipBoundingBox(context);
    CGContextAddRect(context, boundingRect);
    CGContextAddRect(context, rect);
    CGContextEOClip(context);
    // Also clip the top and bottom
    CGContextClipToRect(context, CGRectMake(rect.origin.x - 10.0f, rect.origin.y, rect.size.width + 20.0f, rect.size.height + 10.0f));
    
    // Draw shadow
    [[UIColor blackColor] setFill];
    CGContextSetShadow(context, CGSizeMake(0.0f, 0.0f), 7.0f);
    CGContextFillRect(context, CGRectMake(rect.origin.x,
                                          rect.origin.y - 5.0f,
                                          rect.size.width,
                                          rect.size.height + 5.0f));
    // Save context
    CGContextRestoreGState(context);
}

+ (void)drawSideAndTopDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context {
    // Push the context
    CGContextSaveGState(context);
    
    // Set the clipping path to remove the rect drawn by drawing the shadow
    CGRect boundingRect = CGContextGetClipBoundingBox(context);
    CGContextAddRect(context, boundingRect);
    CGContextAddRect(context, rect);
    CGContextEOClip(context);
    // Also clip the top and bottom
    CGContextClipToRect(context, CGRectMake(rect.origin.x - 10.0f, rect.origin.y - 10.0f, rect.size.width + 20.0f, rect.size.height + 10.0f));
    
    // Draw shadow
    [[UIColor blackColor] setFill];
    CGContextSetShadow(context, CGSizeMake( 0.0f, 0.0f), 7.0f);
    CGContextFillRect(context, CGRectMake(rect.origin.x,
                                          rect.origin.y,
                                          rect.size.width,
                                          rect.size.height + 10.0f));
    // Save context
    CGContextRestoreGState(context);
}

+ (void)drawSideDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context {
    // Push the context
    CGContextSaveGState(context);
    
    // Set the clipping path to remove the rect drawn by drawing the shadow
    CGRect boundingRect = CGContextGetClipBoundingBox(context);
    CGContextAddRect(context, boundingRect);
    CGContextAddRect(context, rect);
    CGContextEOClip(context);
    // Also clip the top and bottom
    CGContextClipToRect(context, CGRectMake(rect.origin.x - 10.0f, rect.origin.y, rect.size.width + 20.0f, rect.size.height));
    
    // Draw shadow
    [[UIColor blackColor] setFill];
    CGContextSetShadow(context, CGSizeMake( 0.0f, 0.0f), 7.0f);
    CGContextFillRect(context, CGRectMake(rect.origin.x,
                                          rect.origin.y - 5.0f,
                                          rect.size.width,
                                          rect.size.height + 10.0f));
    // Save context
    CGContextRestoreGState(context);
}

+ (void)addBottomDropShadowToNavigationBarForNavigationController:(UINavigationController *)navigationController {
    UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, navigationController.navigationBar.frame.size.height, navigationController.navigationBar.frame.size.width, 3.0f)];
    [gradientView setBackgroundColor:[UIColor clearColor]];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gradientView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor clearColor] CGColor], nil];
    [gradientView.layer insertSublayer:gradient atIndex:0];
    navigationController.navigationBar.clipsToBounds = NO;
    [navigationController.navigationBar addSubview:gradientView];	    
}

@end
