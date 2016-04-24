//
//  TutorialView.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 23/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "TutorialView.h"

@implementation TutorialView

- (instancetype)init
{
    self = [super init];
    
    if (!self) return nil;
    
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    
    CGRect viewFrame = CGRectMake(0, 0, width, height);
    self.frame = viewFrame;
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame: CGRectMake(width-45, 15, 30, 30)];
    [closeButton setImage: [UIImage imageNamed: @"close"] forState: UIControlStateNormal];
    closeButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    closeButton.clipsToBounds = YES;
    [closeButton addTarget: self
                    action: @selector(close:)
          forControlEvents: UIControlEventTouchUpInside];
    
    [self initPicture];
    [self addSubview: closeButton];
    
    return self;
}

- (void)initPicture
{
    static dispatch_once_t onceToken;
    static UIImageView *tutorial;
    
    // initialize only once
    dispatch_once(&onceToken, ^{
        tutorial = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"tutorial"]];
        tutorial.contentMode = UIViewContentModeScaleAspectFit;
        tutorial.frame = self.frame;
    });
    
    [self addSubview: tutorial];
}

- (void)close: (UIButton *)sender
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
