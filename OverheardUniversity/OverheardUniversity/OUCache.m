//
//  OUCache.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 7/28/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "OUCache.h"
#import "OUConstants.h"

@interface OUCache ()

@property (nonatomic, strong) NSCache *cache;
- (void)setAttributes:(NSDictionary *)attributes forPost:(PFObject *)post;
@end

@implementation OUCache
@synthesize cache;

#pragma mark - Initialization

+ (id)sharedCache {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        self.cache = [[NSCache alloc] init];
    }
    return self;
}

#pragma mark - OUCache

- (void)clear {
    [self.cache removeAllObjects];
}

- (void)setAttributesForPost:(PFObject *)post likers:(NSArray *)likers commenters:(NSArray *)commenters likedByCurrentUser:(BOOL)likedByCurrentUser {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithBool:likedByCurrentUser],kOUPostAttributesIsLikedByCurrentUserKey,
                                [NSNumber numberWithInt:[likers count]],kOUPostAttributesLikeCountKey,
                                likers,kOUPostAttributesLikersKey,
                                [NSNumber numberWithInt:[commenters count]],kOUPostAttributesCommentCountKey,
                                commenters,kOUPostAttributesCommentersKey,
                                nil];
    [self setAttributes:attributes forPost:post];
}

- (NSDictionary *)attributesForPost:(PFObject *)post {
    NSString *key = [self keyForPost:post];
    return [self.cache objectForKey:key];
}

- (NSNumber *)likeCountForPost:(PFObject *)post {
    NSDictionary *attributes = [self attributesForPost:post];
    if (attributes) {
        return [attributes objectForKey:kOUPostAttributesLikeCountKey];
    }
    
    return [NSNumber numberWithInt:0];
}

- (NSNumber *)commentCountForPost:(PFObject *)post {
    NSDictionary *attributes = [self attributesForPost:post];
    if (attributes) {
        return [attributes objectForKey:kOUPostAttributesCommentCountKey];
    }
    
    return [NSNumber numberWithInt:0];
}

- (NSArray *)likersForPost:(PFObject *)post {
    NSDictionary *attributes = [self attributesForPost:post];
    if (attributes) {
        return [attributes objectForKey:kOUPostAttributesLikersKey];
    }
    
    return [NSArray array];
}

- (NSArray *)commentersForPost:(PFObject *)post {
    NSDictionary *attributes = [self attributesForPost:post];
    if (attributes) {
        return [attributes objectForKey:kOUPostAttributesCommentersKey];
    }
    
    return [NSArray array];
}

- (void)setPostIsLikedByCurrentUser:(PFObject *)post liked:(BOOL)liked {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPost:post]];
    [attributes setObject:[NSNumber numberWithBool:liked] forKey:kOUPostAttributesIsLikedByCurrentUserKey];
    [self setAttributes:attributes forPost:post];
}

- (BOOL)isPostLikedByCurrentUser:(PFObject *)post {
    NSDictionary *attributes = [self attributesForPost:post];
    if (attributes) {
        return [[attributes objectForKey:kOUPostAttributesIsLikedByCurrentUserKey] boolValue];
    }
    
    return NO;
}

- (void)incrementLikerCountForPost:(PFObject *)post {
    NSNumber *likerCount = [NSNumber numberWithInt:[[self likeCountForPost:post] intValue] + 1];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPost:post]];
    [attributes setObject:likerCount forKey:kOUPostAttributesLikeCountKey];
    [self setAttributes:attributes forPost:post];
}

- (void)decrementLikerCountForPost:(PFObject *)post {
    NSNumber *likerCount = [NSNumber numberWithInt:[[self likeCountForPost:post] intValue] - 1];
    if ([likerCount intValue] < 0) {
        return;
    }
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPost:post]];
    [attributes setObject:likerCount forKey:kOUPostAttributesLikeCountKey];
    [self setAttributes:attributes forPost:post];
}

- (void)incrementCommentCountForPost:(PFObject *)post {
    NSNumber *commentCount = [NSNumber numberWithInt:[[self commentCountForPost:post] intValue] + 1];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPost:post]];
    [attributes setObject:commentCount forKey:kOUPostAttributesCommentCountKey];
    [self setAttributes:attributes forPost:post];
}

- (void)decrementCommentCountForPost:(PFObject *)post {
    NSNumber *commentCount = [NSNumber numberWithInt:[[self commentCountForPost:post] intValue] - 1];
    if ([commentCount intValue] < 0) {
        return;
    }
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPost:post]];
    [attributes setObject:commentCount forKey:kOUPostAttributesCommentCountKey];
    [self setAttributes:attributes forPost:post];
}

- (void)setAttributesForUser:(PFUser *)user postCount:(NSNumber *)count followedByCurrentUser:(BOOL)following {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                count,kOUUserAttributesPostCountKey,
                                [NSNumber numberWithBool:following],kOUUserAttributesIsFollowedByCurrentUserKey,
                                nil];
    [self setAttributes:attributes forUser:user];
}

- (NSDictionary *)attributesForUser:(PFUser *)user {
    NSString *key = [self keyForUser:user];
    return [self.cache objectForKey:key];
}

- (NSNumber *)postCountForUser:(PFUser *)user {
    NSDictionary *attributes = [self attributesForUser:user];
    if (attributes) {
        NSNumber *postCount = [attributes objectForKey:kOUUserAttributesPostCountKey];
        if (postCount) {
            return postCount;
        }
    }
    
    return [NSNumber numberWithInt:0];
}

- (BOOL)followStatusForUser:(PFUser *)user {
    NSDictionary *attributes = [self attributesForUser:user];
    if (attributes) {
        NSNumber *followStatus = [attributes objectForKey:kOUUserAttributesIsFollowedByCurrentUserKey];
        if (followStatus) {
            return [followStatus boolValue];
        }
    }
    
    return NO;
}

- (void)setPostCount:(NSNumber *)count user:(PFUser *)user {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForUser:user]];
    [attributes setObject:count forKey:kOUUserAttributesPostCountKey];
    [self setAttributes:attributes forUser:user];
}

- (void)setFollowStatus:(BOOL)following user:(PFUser *)user {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForUser:user]];
    [attributes setObject:[NSNumber numberWithBool:following] forKey:kOUUserAttributesIsFollowedByCurrentUserKey];
    [self setAttributes:attributes forUser:user];
}

- (void)setFacebookFriends:(NSArray *)friends {
    NSString *key = kOUUserDefaultsCacheFacebookFriendsKey;
    [self.cache setObject:friends forKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:friends forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)facebookFriends {
    NSString *key = kOUUserDefaultsCacheFacebookFriendsKey;
    if ([self.cache objectForKey:key]) {
        return [self.cache objectForKey:key];
    }
    
    NSArray *friends = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (friends) {
        [self.cache setObject:friends forKey:key];
    }
    
    return friends;
}


#pragma mark - ()

- (void)setAttributes:(NSDictionary *)attributes forPost:(PFObject *)post {
    NSString *key = [self keyForPost:post];
    [self.cache setObject:attributes forKey:key];
}

- (void)setAttributes:(NSDictionary *)attributes forUser:(PFUser *)user {
    NSString *key = [self keyForUser:user];
    [self.cache setObject:attributes forKey:key];
}

- (NSString *)keyForPost:(PFObject *)post {
    return [NSString stringWithFormat:@"post_%@", [post objectId]];
}

- (NSString *)keyForUser:(PFUser *)user {
    return [NSString stringWithFormat:@"user_%@", [user objectId]];
}

@end
