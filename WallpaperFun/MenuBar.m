//
//  MenuBar.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 22/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "MenuBar.h"

@implementation MenuBar

@synthesize delegate;

- (instancetype) init
{
    self = [super init];
    
    if (!self) return self;
    
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    
    CGRect viewFrame = CGRectMake(0, height-170, width , 170);
    UIView *blackTransparentView = [[UIView alloc] initWithFrame: CGRectMake(0, viewFrame.size.height-170, width, viewFrame.size.height)];

    //** Transparent background
    //*** Bottom border */
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0, 0, blackTransparentView.frame.size.width, 2.0f);
    bottomBorder.backgroundColor = [self getBasicTextColor].CGColor;
    [blackTransparentView.layer addSublayer: bottomBorder];
    
    blackTransparentView.clipsToBounds = YES;
    [blackTransparentView setBackgroundColor: [UIColor blackColor]];
    [blackTransparentView setAlpha: 0.8];
    
    //** Parent
    self.frame = viewFrame;
    
    [self addSubview: blackTransparentView];
    
    [self initPreviewScreenSwich: blackTransparentView.frame.size.width
                          height: blackTransparentView.frame.size.height];
    
    [self initNavigationButtons: blackTransparentView.frame.size.width
                         height: blackTransparentView.frame.size.height];

    return self;
}

#pragma mark - Components init

- (void) initPreviewScreenSwich: (float)width height:(float)height
{
    //** Swich
    UISwitch *swich = [[UISwitch alloc] initWithFrame: CGRectMake(0, 0, 51, 35)];
    
    [swich sizeToFit];
    [swich autoresizingMask];
    [swich setOnTintColor: [self getBasicTextColor]];
    swich.on = YES;
    swich.clipsToBounds = YES;
    swich.center = CGPointMake(width/2, height/2.35);
    
    //** Swich labels
    //*** Top Label */
    UILabel *topSwichText = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 245, 50)];
    
    [topSwichText setText: [NSString stringWithFormat: @"%@", @"Preview Screen \n (double tap on Screen to activate it)"]];
    [topSwichText setTextColor: [self getBasicTextColor]];
    [topSwichText setFont: [UIFont boldSystemFontOfSize: 14]];
    topSwichText.center = CGPointMake(swich.center.x, swich.center.y/2.5);
    topSwichText.numberOfLines = 0;
    topSwichText.textAlignment = NSTextAlignmentCenter;

    //*** Style title text */
    NSMutableAttributedString *titleText = [[NSMutableAttributedString alloc] initWithString: topSwichText.text];
    [titleText addAttribute: NSForegroundColorAttributeName value: [UIColor lightGrayColor] range: NSMakeRange( 17, 37 )];
    [titleText addAttribute: NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:10.0] range: NSMakeRange( 17, 37 )];
    topSwichText.attributedText = titleText;
    
    //*** Left Label */
    UILabel *leftSwichLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 40, 35)];
    
    [leftSwichLabel setText: @"Lock"];
    [leftSwichLabel setTextColor: [UIColor whiteColor]];
    [leftSwichLabel setFont: [UIFont systemFontOfSize: 14]];
    leftSwichLabel.center = CGPointMake(swich.center.x - swich.frame.size.width, swich.center.y);
    
    //*** Right Label */
    UILabel *rightSwichLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 40, 35)];
    
    [rightSwichLabel setText: @"Home"];
    [rightSwichLabel setTextColor: [UIColor whiteColor]];
    [rightSwichLabel setFont: [UIFont systemFontOfSize: 14]];
    rightSwichLabel.center = CGPointMake(swich.center.x + swich.frame.size.width+9, swich.center.y);
    
    //** Add Target
    [swich addTarget: self.delegate
              action: @selector(flip:)
    forControlEvents: UIControlEventValueChanged];

    
    //** Add Subviews
    [self addSubview: swich];
    [self addSubview: topSwichText];
    [self addSubview: leftSwichLabel];
    [self addSubview: rightSwichLabel];
}

- (void) initNavigationButtons: (float)width height: (float)height
{
    //*** About */
    UIButton *aboutButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
    
    [aboutButton setBackgroundColor: [self getBasicTextColor]];
    [aboutButton setImage: [UIImage imageNamed: @"about"] forState: UIControlStateNormal];
    aboutButton.clipsToBounds = YES;
    aboutButton.layer.cornerRadius = 10;
    aboutButton.imageEdgeInsets = UIEdgeInsetsMake(5, 2, 2, 2);
    aboutButton.imageView.contentMode = UIViewContentModeCenter;
    aboutButton.center = CGPointMake(width/3.5, height - aboutButton.frame.size.height+7);
    
    //*** Help */
    UIButton *helpButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
    
    [helpButton setBackgroundColor: [self getBasicTextColor]];
    [helpButton setImage: [UIImage imageNamed: @"help"] forState: UIControlStateNormal];
    helpButton.clipsToBounds = YES;
    helpButton.layer.cornerRadius = 10;
    helpButton.imageEdgeInsets = UIEdgeInsetsMake(3, 2, 2, 2);
    helpButton.imageView.contentMode = UIViewContentModeCenter;
    helpButton.center = CGPointMake(width/2, height - aboutButton.frame.size.height+7);
    
    //*** Favorites */
    UIButton *favoritesButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
    
    [favoritesButton setBackgroundColor: [self getBasicTextColor]];
    [favoritesButton setImage: [UIImage imageNamed: @"favorites"] forState: UIControlStateNormal];
    favoritesButton.clipsToBounds = YES;
    favoritesButton.layer.cornerRadius = 10;
    favoritesButton.imageEdgeInsets = UIEdgeInsetsMake(3, 2, 2, 2);
    favoritesButton.imageView.contentMode = UIViewContentModeCenter;
    favoritesButton.center = CGPointMake(width/1.4, height - aboutButton.frame.size.height+7);
    
    //**** Action */
    [aboutButton addTarget: self.delegate
                    action: @selector(aboutButtonTap:)
          forControlEvents: UIControlEventTouchUpInside];
    
    [helpButton addTarget: self.delegate
                   action: @selector(helpButtonTap:)
         forControlEvents: UIControlEventTouchUpInside];
    
    //** Add Subviews
    [self addSubview: helpButton];
    [self addSubview: aboutButton];
    [self addSubview: favoritesButton];
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

#pragma mark - Public

- (void)hideWithAnimation
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
