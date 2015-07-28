//
//  OUConstants.h
//  overhearduniversity
//
//  Created by Tyler Kuster on 7/27/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

typedef enum {
    OUHomeNavItemIndex = 0,
    OUEmptyNavItemIndex = 1,
    OUProfileNavItemIndex = 2
} OUNavigationControllerViewControllerIndex;

#pragma mark - NSUserDefaults
extern NSString *const kOUUserDefaultsActivityFeedViewControllerLastRefreshKey;
extern NSString *const kOUUserDefaultsCacheFacebookFriendsKey;

//#pragma mark - Launch URLs
//
//extern NSString *const kOULaunchURLHostTakePicture;


#pragma mark - NSNotification
extern NSString *const OUAppDelegateApplicationDidReceiveRemoteNotification;
extern NSString *const OUUtilityUserFollowingChangedNotification;
extern NSString *const OUUtilityUserLikedUnlikedPostCallbackFinishedNotification;
extern NSString *const OUUtilityDidFinishProcessingProfilePictureNotification;
extern NSString *const OUNavigationControllerDidFinishEditingPostNotification;
extern NSString *const OUNavigationControllerDidFinishPostUploadNotification;
extern NSString *const OUPostDetailsViewControllerUserDeletedPostNotification;
extern NSString *const OUPostDetailsViewControllerUserLikedUnlikedPostNotification;
extern NSString *const OUPostDetailsViewControllerUserCommentedOnPostNotification;


#pragma mark - User Info Keys
extern NSString *const OUPostDetailsViewControllerUserLikedUnlikedPostNotificationUserInfoLikedKey;
extern NSString *const kOUEditPostViewControllerUserInfoCommentKey;


#pragma mark - Installation Class

// Field keys
extern NSString *const kOUInstallationUserKey;
extern NSString *const kOUInstallationChannelsKey;


#pragma mark - PFObject Activity Class
// Class key
extern NSString *const kOUActivityClassKey;

// Field keys
extern NSString *const kOUActivityTypeKey;
extern NSString *const kOUActivityFromUserKey;
extern NSString *const kOUActivityToUserKey;
extern NSString *const kOUActivityContentKey;
extern NSString *const kOUActivityPostKey;

// Type values
extern NSString *const kOUActivityTypeLike;
extern NSString *const kOUActivityTypeFollow;
extern NSString *const kOUActivityTypeComment;
extern NSString *const kOUActivityTypeJoined;


#pragma mark - PFObject User Class
// Field keys
extern NSString *const kOUUserDisplayNameKey;
extern NSString *const kOUUserFacebookIDKey;
extern NSString *const kOUUserPostIDKey;
extern NSString *const kOUUserProfilePictureKey;
extern NSString *const kOUUserAlreadyAutoFollowedFacebookFriendsKey;
extern NSString *const kOUUserPrivateChannelKey;


#pragma mark - PFObject Post Class
// Class key
extern NSString *const kOUPostClassKey;

// Field keys
extern NSString *const kOUPostConversationKey;
extern NSString *const kOUPostUserKey;


#pragma mark - Cached Post Attributes
// keys
extern NSString *const kOUPostAttributesIsLikedByCurrentUserKey;
extern NSString *const kOUPostAttributesLikeCountKey;
extern NSString *const kOUPostAttributesLikersKey;
extern NSString *const kOUPostAttributesCommentCountKey;
extern NSString *const kOUPostAttributesCommentersKey;


#pragma mark - Cached User Attributes
// keys
extern NSString *const kOUUserAttributesPostCountKey;
extern NSString *const kOUUserAttributesIsFollowedByCurrentUserKey;


#pragma mark - PFPush Notification Payload Keys

extern NSString *const kAPNSAlertKey;
extern NSString *const kAPNSBadgeKey;
extern NSString *const kAPNSSoundKey;

extern NSString *const kOUPushPayloadPayloadTypeKey;
extern NSString *const kOUPushPayloadPayloadTypeActivityKey;

extern NSString *const kOUPushPayloadActivityTypeKey;
extern NSString *const kOUPushPayloadActivityLikeKey;
extern NSString *const kOUPushPayloadActivityCommentKey;
extern NSString *const kOUPushPayloadActivityFollowKey;

extern NSString *const kOUPushPayloadFromUserObjectIdKey;
extern NSString *const kOUPushPayloadToUserObjectIdKey;
extern NSString *const kOUPushPayloadPostObjectIdKey;
