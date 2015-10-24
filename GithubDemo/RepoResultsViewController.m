//
//  RepoResultsViewController.m
//  GithubDemo
//
//  Created by Nicholas Aiwazian on 9/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "RepoResultsViewController.h"
#import "MBProgressHUD.h"
#import "GithubRepo.h"
#import "GithubRepoSearchSettings.h"

@interface RepoResultsViewController ()
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) GithubRepoSearchSettings *searchSettings;
@end

@implementation RepoResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchSettings = [[GithubRepoSearchSettings alloc] init];
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    self.navigationItem.titleView = self.searchBar;
    [self doSearch];
}

- (void)doSearch {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GithubRepo fetchRepos:self.searchSettings successCallback:^(NSArray *repos) {
        for (GithubRepo *repo in repos) {
            NSLog(@"%@", repo);
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchSettings.searchString = searchBar.text;
    [searchBar resignFirstResponder];
    [self doSearch];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
