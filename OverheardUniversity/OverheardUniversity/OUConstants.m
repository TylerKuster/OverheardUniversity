//
//  OUConstants.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 7/27/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "OUConstants.h"

NSString *const kOUUserDefaultsActivityFeedViewControllerLastRefreshKey    = @"com.overheardUniversity.OverheardUniversity.userDefaults.activityFeedViewController.lastRefresh";
NSString *const kOUUserDefaultsCacheFacebookFriendsKey                     = @"com.overheardUniversity.OverheardUniversity.userDefaults.cache.facebookFriends";


//#pragma mark - Launch URLs
//
//NSString *const kOULaunchURLHostTakePicture = @"camera";


#pragma mark - NSNotification

NSString *const OUAppDelegateApplicationDidReceiveRemoteNotification           = @"com.overheardUniversity.OverheardUniversity.appDelegate.applicationDidReceiveRemoteNotification";
NSString *const OUUtilityUserFollowingChangedNotification                      = @"com.overheardUniversity.OverheardUniversity.utility.userFollowingChanged";
NSString *const OUUtilityUserLikedUnlikedPostCallbackFinishedNotification      = @"com.overheardUniversity.OverheardUniversity.utility.userLikedUnlikedPostCallbackFinished";
NSString *const OUUtilityDidFinishProcessingProfilePictureNotification         = @"com.overheardUniversity.OverheardUniversity.utility.didFinishProcessingProfilePictureNotification";
NSString *const OUNavigationControllerDidFinishEditingPostNotification         = @"com.overheardUniversity.OverheardUniversity.tabBarController.didFinishEditingPost";
NSString *const OUNavigationControllerDidFinishPostUploadNotification          = @"com.overheardUniversity.OverheardUniversity.tabBarController.didFinishImageFileUploadNotification";
NSString *const OUPostDetailsViewControllerUserDeletedPostNotification       = @"com.overheardUniversity.OverheardUniversity.PostDetailsViewController.userDeletedPost";
NSString *const OUPostDetailsViewControllerUserLikedUnlikedPostNotification  = @"com.overheardUniversity.OverheardUniversity.PostDetailsViewController.userLikedUnlikedPostInDetailsViewNotification";
NSString *const OUPostDetailsViewControllerUserCommentedOnPostNotification   = @"com.overheardUniversity.OverheardUniversity.PostDetailsViewController.userCommentedOnPostInDetailsViewNotification";


#pragma mark - User Info Keys
NSString *const OUPostDetailsViewControllerUserLikedUnlikedPostNotificationUserInfoLikedKey = @"liked";
NSString *const kOUEditPostViewControllerUserInfoCommentKey = @"comment";

#pragma mark - Installation Class

// Field keys
NSString *const kOUInstallationUserKey = @"user";
NSString *const kOUInstallationChannelsKey = @"channels";

#pragma mark - Activity Class
// Class key
NSString *const kOUActivityClassKey = @"Activity";

// Field keys
NSString *const kOUActivityTypeKey        = @"type";
NSString *const kOUActivityFromUserKey    = @"fromUser";
NSString *const kOUActivityToUserKey      = @"toUser";
NSString *const kOUActivityContentKey     = @"content";
NSString *const kOUActivityPostKey       = @"post";

// Type values
NSString *const kOUActivityTypeLike       = @"like";
NSString *const kOUActivityTypeFollow     = @"follow";
NSString *const kOUActivityTypeComment    = @"comment";
NSString *const kOUActivityTypeJoined     = @"joined";

#pragma mark - User Class
// Field keys
NSString *const kOUUserDisplayNameKey                          = @"displayName";
NSString *const kOUUserFacebookIDKey                           = @"facebookId";
NSString *const kOUUserPostIDKey                              = @"postId";
NSString *const kOUUserProfilePictureKey                      = @"profilePicture";
NSString *const kOUUserAlreadyAutoFollowedFacebookFriendsKey   = @"userAlreadyAutoFollowedFacebookFriends";
NSString *const kOUUserPrivateChannelKey                       = @"channel";

#pragma mark - Post Class
// Class key
NSString *const kOUPostClassKey = @"Posts";

// Field keys
NSString *const kOUPostConversationKey    = @"conversation";
NSString *const kOUPostUserKey            = @"user";


#pragma mark - Cached Post Attributes
// keys
NSString *const kOUPostAttributesIsLikedByCurrentUserKey = @"isLikedByCurrentUser";
NSString *const kOUPostAttributesLikeCountKey            = @"likeCount";
NSString *const kOUPostAttributesLikersKey               = @"likers";
NSString *const kOUPostAttributesCommentCountKey         = @"commentCount";
NSString *const kOUPostAttributesCommentersKey           = @"commenters";


#pragma mark - Cached User Attributes
// keys
NSString *const kOUUserAttributesPostCountKey                 = @"postCount";
NSString *const kOUUserAttributesIsFollowedByCurrentUserKey    = @"isFollowedByCurrentUser";


#pragma mark - Push Notification Payload Keys

NSString *const kAPNSAlertKey = @"alert";
NSString *const kAPNSBadgeKey = @"badge";
NSString *const kAPNSSoundKey = @"sound";

// the following keys are intentionally kept short, APNS has a maximum payload limit
NSString *const kOUPushPayloadPayloadTypeKey          = @"p";
NSString *const kOUPushPayloadPayloadTypeActivityKey  = @"a";

NSString *const kOUPushPayloadActivityTypeKey     = @"t";
NSString *const kOUPushPayloadActivityLikeKey     = @"l";
NSString *const kOUPushPayloadActivityCommentKey  = @"c";
NSString *const kOUPushPayloadActivityFollowKey   = @"f";

NSString *const kOUPushPayloadFromUserObjectIdKey = @"fu";
NSString *const kOUPushPayloadToUserObjectIdKey   = @"tu";
NSString *const kOUPushPayloadPostObjectIdKey    = @"pid";