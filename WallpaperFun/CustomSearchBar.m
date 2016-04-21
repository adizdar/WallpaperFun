//
//  CustomSearchBar.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 19/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "CustomSearchBar.h"

@implementation CustomSearchBar

UISearchBar *searchBar;

- (instancetype)initWithDelegate: (id)delegate
{
    self = [super init];
    
    if (!self) return nil;
    
    float width = [UIScreen mainScreen].bounds.size.width;
    
    CGRect viewFrame = CGRectMake(0, 0, width , 60);
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, viewFrame.size.height-30, width, 30)];
    
    //** Search bar
    searchBar.layer.borderColor = [[UIColor whiteColor] CGColor];
    searchBar.placeholder = @"Search";
    searchBar.layer.borderWidth = 1;
    searchBar.delegate = delegate;
    
    [searchBar setSearchBarStyle: UISearchBarStyleDefault];
    [searchBar setBackgroundColor: [UIColor whiteColor]];
    [searchBar setBarTintColor: [UIColor whiteColor]];
    [searchBar setReturnKeyType: UIReturnKeySearch];
    [searchBar sizeToFit];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:[UIFont systemFontOfSize:14]];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor: [UIColor grayColor]];
    
    //** Cancel button
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UtillsClass UIColorFromRGB: 0x6C7A89], NSForegroundColorAttributeName, [UIFont systemFontOfSize:14], NSFontAttributeName, nil]
     forState:UIControlStateNormal];
    
    //** Container View
    self.frame = viewFrame;
    
    [self setBackgroundColor: [UIColor whiteColor]];
    [self addSubview: searchBar];
    
    return self;
}

- (UISearchBar *)getSearchBar
{
    return searchBar;
}

@end
