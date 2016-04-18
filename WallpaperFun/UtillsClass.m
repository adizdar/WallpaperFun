//
//  UtillsClass.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 14/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "UtillsClass.h"

@implementation UtillsClass

#pragma mark - Public

+ (UIActivityIndicatorView *)createUIActivityIndicator
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    spinner.transform = CGAffineTransformMakeScale(2, 2);
    spinner.color = [UIColor redColor];
    spinner.center = CGPointMake(160, 240);
    spinner.tag = 101;
    
    return spinner;
    
    //[[self.view viewWithTag:101] stopAnimating];
    //[spinner removeFromSuperview];
}

+ (UIColor *)UIColorFromRGB:(NSUInteger)rgbValue
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                           green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                            blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                           alpha:1.0];
}

+ (void)toggleLoadingIndicator: (UIView *)view indicatorID: (NSInteger) indicatorID
{
    [self toggleLoadingIndicatorWithText: @""
                                    view: view
                             indicatorID: indicatorID];
}

+ (void)toggleLoadingIndicatorWithText: (NSString *)text
                                             view: (UIView *)view
                                      indicatorID: (NSInteger) indicatorID
{
    [self callMBHUD:view
               text:text
        indicatorID:indicatorID
               mode:MBProgressHUDModeIndeterminate];
}

+ (void)toggleMessageModal: (NSString *)text
                      view: (UIView *)view
               indicatorID: (NSInteger)indicatorID
{
    [self callMBHUD:view
               text:text
        indicatorID:indicatorID
               mode:MBProgressHUDModeText];
}

+ (void)destroyLoadingIndicatorWithText: (UIView *)view
                            indicatorID: (NSInteger)indicatorID
{
   MBProgressHUD *hud = [view viewWithTag: indicatorID];
   
    if (hud) {
        [hud removeFromSuperview];
        hud = nil;
    }
}

+ (void)hideModalHud: (UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

#pragma mark - Private

+ (void)callMBHUD: (UIView *)view
             text: (NSString *)text
      indicatorID: (NSInteger)indicatorID
             mode: (MBProgressHUDMode)mode
{
    MBProgressHUD *hud = [view viewWithTag: indicatorID];

    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = mode;
        hud.labelText = text;
        hud.tag = indicatorID;
    } else if ([hud alpha] == 1.0) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [hud hide:YES];
        });
    } else {
        [hud show:YES];
    }
}

@end
