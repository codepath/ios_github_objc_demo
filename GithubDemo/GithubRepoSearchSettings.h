//
//  GithubRepoSearchSettings.h
//  GithubDemo
//
//  Created by Nicholas Aiwazian on 9/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GithubRepoSearchSettings : NSObject
@property (nonatomic, strong) NSString *searchString;
@property NSInteger minStars;
@end
