//
//  HomeScreenViewController.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 10/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#import "MenuBar.h"

@interface HomeScreenViewController : UIViewController<UISearchBarDelegate, UIViewControllerPreviewingDelegate, MenuBarProtocolDelegate>

/** Long Press recognizer */
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@end
