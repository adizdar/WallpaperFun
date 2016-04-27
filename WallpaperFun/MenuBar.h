//
//  MenuBar.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 22/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtillsClass.h"

@protocol MenuBarProtocolDelegate <NSObject>

@optional
- (void) helpButtonTap:(UIButton *)sender;
@end

/** Navigation bar */
@interface MenuBar : UIView

@property (nonatomic, assign) id <MenuBarProtocolDelegate> delegate;

/** Hide MenuBar with animation */
- (void)hideWithAnimation;

@end
