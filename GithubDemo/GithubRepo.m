//
//  GithubRepo.m
//  GithubDemo
//
//  Created by Nicholas Aiwazian on 9/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "GithubRepo.h"
#import "AFHTTPRequestOperationManager.h"
#import "GithubRepoSearchSettings.h"

@interface GithubRepo ()
@end

@implementation GithubRepo

static NSString * const kReposUrl = @"https://api.github.com/search/repositories";
static NSString * const kClientId = nil;
static NSString * const kClientSecret = nil;

- (void)initializeWithDictionary:(NSDictionary *)jsonResult {
    self.name = jsonResult[@"name"];
    self.stars = [jsonResult[@"stargazers_count"] integerValue];
    self.forks = [jsonResult[@"forks_count"] integerValue];
    self.ownerHandle = jsonResult[@"owner"][@"login"];
    self.ownerAvatarURL = jsonResult[@"owner"][@"avatar_url"];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    GithubRepo *copy = [[[self class] alloc] init];

    if (copy) {
        copy.name = self.name;
        copy.ownerHandle = self.ownerHandle;
        copy.ownerAvatarURL = self.ownerAvatarURL;
        copy.stars = self.stars;
        copy.forks = self.forks;
    }

    return copy;
}

+ (void)fetchRepos:(GithubRepoSearchSettings *)settings successCallback:(void(^)(NSArray *))successCallback {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (kClientId) {
        [params setObject:kClientId forKey:@"client_id"];
    }
    if (kClientSecret) {
        [params setObject:kClientSecret forKey:@"client_secret"];
    }
    
    NSMutableString *query = [[NSMutableString alloc] initWithString:@""];
    if (settings.searchString) {
        [query appendString:settings.searchString];
    }
    [query appendString:[NSString stringWithFormat:@" stars:>%ld", settings.minStars]];
    
    [params setObject:query forKey:@"q"];
    [params setObject:@"stars" forKey:@"sort"];
    [params setObject:@"desc" forKey:@"order"];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager GET:kReposUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *results = responseObject[@"items"];
        if (results) {
            NSMutableArray *repos = [[NSMutableArray alloc] init];
            for (NSDictionary *result in results) {
                GithubRepo *repo = [[GithubRepo alloc] init];
                [repo initializeWithDictionary:result];
                [repos addObject:repo];
            }
            successCallback(repos);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure while trying to fetch repos");
    }];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\n\tName:%@\n\tStars:%ld\n\tForks:%ld\n\tOwner:%@\n\tAvatar:%@\n\t",
            self.name,
            self.stars,
            self.forks,
            self.ownerHandle,
            self.ownerAvatarURL];
}

@end
