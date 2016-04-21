//
//  CustomSearchBar.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 19/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtillsClass.h"

/** Custom search bar with white UIView Background */
@interface CustomSearchBar : UIView

/** Initializer
    @param delegate as ID the controller where you want to implement the search bar methods
 */
- (instancetype)initWithDelegate: (id)delegate;

/** Get Search bar instance 
    @return UISearchBar
 */
- (UISearchBar *)getSearchBar;

@end
