//
//  GithubRepo.h
//  GithubDemo
//
//  Created by Nicholas Aiwazian on 9/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GithubRepoSearchSettings;

@interface GithubRepo : NSObject <NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ownerHandle;
@property (nonatomic, strong) NSString *ownerAvatarURL;
@property NSInteger stars;
@property NSInteger forks;

+ (void)fetchRepos:(GithubRepoSearchSettings *)settings successCallback:(void(^)(NSArray *))successCallback;

@end
