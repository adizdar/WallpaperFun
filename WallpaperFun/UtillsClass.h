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

/** Create MBProgressHUD and toggle it
 @description If MBProgressHUD is created the method will switch the visibility of it, call destroyLoadingIndicatorWithText to remove it from the view compleatly
 @parameter text as NSString initialize the loading text
 @parameter description as NSString initialize the loading text
 @parameter view as UIView send the superview where you want to add the loadingIndicator
 @parameter indicatorID as NSInteger the tag of the view so you can manipulate it from the controller and the methods can check his existance in the superview
 */
+ (void)toggleLoadingIndicatorWithTextAndSubText: (NSString *)text
                             withDescriptionText: (NSString *)description
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

/** Toggle Modal View after Timeout 
    @parameter view as UIView
 */
+ (void)toggleAfterTimeout: (UIView *)view;

/** Get Red component from color (RGB format) 
    @description The RGB value goes from 0 - 1, where 1 is white and 0 is black
    @parameter color as UIColor
 */
+ (CGFloat)red: (UIColor *)color;

/** Get Blue component from color (RGB format)
 @description The RGB value goes from 0 - 1, where 1 is white and 0 is black
 @parameter color as UIColor
 @return CGFloat
 */
+ (CGFloat)blue: (UIColor *)color;

/** Get Green component from color (RGB format)
 @description The RGB value goes from 0 - 1, where 1 is white and 0 is black
 @parameter color as UIColor
 @return CGFloat
 */
+ (CGFloat)green: (UIColor *)color;

/** Get Alpha component from color (RGB format)
 @description The Alpha value goes from 0 - 1, where 1 is visible and 0 is hidden
 @parameter color as UIColor
 @return CGFloat
 */
+ (CGFloat)alpha: (UIColor *)color;

/** Get Device Name
 @return NSString
 */
+ (NSString *)deviceName;

/** Set status bar to light color
 @return UIStatusBarStyle
 */
+ (UIStatusBarStyle)preferredStatusBarStyleLight;

/** Show Modal with image
 @parameter view as UIView
 @parameter text as NSString title of the modal
 @parameter detailsText as NSString details of the modal
 @parameter indicatorID as NSInteger
 */
+ (void)modalWithImageMBHUD: (UIView *)view
                       text: (NSString *)text
                detailsText: (NSString *)detailsText
                indicatorID: (NSInteger)indicatorID
                      image: (UIImage *)image;

@end
