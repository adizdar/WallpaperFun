//
//  UtillsClass.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 14/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

/** Several helper methods */
@interface UtillsClass : NSObject

/** Create UIActivityIndicator and return it
    @description spinner tag is 101
    @return UIActivityIndicatorView spinner
 */
+ (UIActivityIndicatorView *)createUIActivityIndicator;

/** Convert HEX to UICollor 
    @parameter rgbValue as NSUIteger needs to be send in format 0xHEX_VALUE
    @return UICollor
 */
+ (UIColor *) UIColorFromRGB: (NSUInteger) rgbValue;

/** Create MBProgressHUD and toggle it
 @description If MBProgressHUD is created the method will switch the visibility of it, call destroyLoadingIndicatorWithText to remove it from the view compleatly
 @parameter text as NSString initialize the loading text
 @parameter view as UIView send the superview where you want to add the loadingIndicator
 @parameter indicatorID as NSInteger the tag of the view so you can manipulate it from the controller and the methods can check his existance in the superview
 */
+ (void)toggleLoadingIndicatorWithText: (NSString *)text
                                  view: (UIView *)view
                           indicatorID: (NSInteger) indicatorID;

/** Just toggle funcionality
 @description it calls the full toggleLoadingIndicatorWithText where the text is set to nil
 */
+ (void)toggleLoadingIndicator: (UIView *)view indicatorID: (NSInteger) indicatorID;

/** Just toggle funcionality
 @description Creates message modal
 @param text as NSString initialize the loading text
 @param view as UIView send the superview where you want to add the loadingIndicator
 @param indicatorID as NSInteger the tag of the view so you can manipulate it from the controller and the methods can check his existance in the superview

 */
+ (void)toggleMessageModal: (NSString *)text
                      view: (UIView *)view
               indicatorID: (NSInteger)indicatorID;

/** Hide HUD Modal
 @description Creates message modal
 @param view as UIView send the superview where you want to add the loadingIndicator
 */
+ (void)hideModalHud: (UIView *)view;

/** Destory MBProgressHUD
 @parameter view as UIView the superview where the loadingIndicator is added
 @parameter indicatorID as NSInteger the tag of the view so the methods can check his existance
 */
+ (void)destroyLoadingIndicatorWithText: (UIView *)view
                            indicatorID: (NSInteger) indicatorID;

+ (void)toggleAfterTimeout: (UIView *)view;

@end
