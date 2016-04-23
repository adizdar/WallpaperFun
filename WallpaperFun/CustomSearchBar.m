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
    float height = [UIScreen mainScreen].bounds.size.height;
    
    CGRect viewFrame = CGRectMake(0, 0, width , 60);
    UIView *blackView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, width, height)];
    UIView *searchBarParent = [[UIView alloc] initWithFrame: CGRectMake(0, 0, width, 70)];

    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, viewFrame.size.height-40, width, 30)];
    
    //** Search bar
    searchBar.layer.borderColor = [[self getBasicBackgroundColor] CGColor];
    searchBar.layer.borderWidth = 1;
    searchBar.clipsToBounds = YES;
    searchBar.delegate = delegate;
    
    [searchBar setSearchBarStyle: UISearchBarStyleDefault];
    [searchBar setBackgroundColor: [self getBasicBackgroundColor]];
    [searchBar setBarTintColor: [self getBasicBackgroundColor]];
    [searchBar setReturnKeyType: UIReturnKeySearch];
    [searchBar setImage: [UIImage imageNamed: @"searchPlaceholder"]
       forSearchBarIcon: UISearchBarIconSearch
                  state: UIControlStateNormal];
    [searchBar sizeToFit];

    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor: [self getBasicTextColor]];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setBackgroundColor: [self getBasicBackgroundColor]];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:[UIFont systemFontOfSize:16]];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setAttributedPlaceholder: [[NSAttributedString alloc] initWithString:@"Search... :)" attributes:@{NSForegroundColorAttributeName: [self getBasicTextColor]}]];

    // TODO move it, so it can be a diffrent theme
    //** Search bar parent

    // Add a bottomBorder.
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, searchBarParent.frame.size.height-1.0f, searchBarParent.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [self getBasicTextColor].CGColor;
    
    [searchBarParent.layer addSublayer: bottomBorder];
    [searchBarParent setBackgroundColor: [UIColor blackColor]];
    [searchBarParent setAlpha: 0.8];
    [searchBarParent addSubview: searchBar];
  
    //** Cancel button
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UtillsClass UIColorFromRGB: 0xF3BF37], NSForegroundColorAttributeName, [UIFont systemFontOfSize:16], NSFontAttributeName, nil]
     forState:UIControlStateNormal];
    
    //** Black View
    blackView.alpha = 0.7;
    [blackView setBackgroundColor: [UIColor blackColor]];
    
    //** Container View
    // NOTE if the parent view is to small UISearchBar becomes unresponsive
    self.frame = viewFrame;
    
    [self addSubview: blackView];
    [self addSubview: searchBarParent];
    
    return self;
}

#pragma mark - Private

- (UIColor *)getBasicBackgroundColor
{
    return [UIColor blackColor];
}

- (UIColor *)getBasicTextColor
{
    return [UtillsClass UIColorFromRGB: 0xF5A623];
}

- (UISearchBar *)getSearchBar
{
    return searchBar;
}

#pragma mark - Public

- (void)dissmisSearchBar
{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
    searchBar.text = @"";
}

- (void)hideSearchBar
{
    [UIView transitionWithView: self
                      duration: 0.3f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^{
                        self.hidden = YES;
                    }
                    completion: nil];
}

@end
