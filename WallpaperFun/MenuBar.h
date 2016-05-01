//
//  MenuBar.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 22/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtillsClass.h"

/** Protocol for Menu Bar */
@protocol MenuBarProtocolDelegate <NSObject>
@optional
- (void) aboutButtonTap: (UIButton *)sender;
- (void) helpButtonTap: (UIButton *)sender;
- (void) favoritesButtonTap: (UIButton *)sender;
- (void) flip: (UISwitch *)sender;
@end

/** Navigation bar */
@interface MenuBar : UIView

@property (nonatomic, assign) id <MenuBarProtocolDelegate> delegate;

/** Hide MenuBar with animation */
- (void)hideWithAnimation;

@end
