//
//  OULogin.h
//  OverheardUniversity
//
//  Created by Tyler Kuster on 3/3/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OULogin : NSObject

+ (void)checkUsername:(NSString*)username password:(NSString*)password andEmail:(NSString*)email;

@end
