//
//  ModalView.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 28/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "ModalView.h"

#define LOGO @"logoWhite"

@implementation ModalView

float width;
float height;

- (instancetype) init
{
    self = [super init];
    
    if (!self) return nil;
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    
    self.frame = CGRectMake(0, 0, width-50, height/2);
    self.center = CGPointMake( width/2, height/2 );
    
    UIView *container = [[UIView alloc] init];
    
    container.clipsToBounds = YES;
    container.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    container.alpha = 0.7;
    container.layer.borderWidth = 4;
    container.layer.borderColor = [self getBasicTextColor].CGColor;
    [container setBackgroundColor: [self getBasicBackgroundColor]];
    
    [self addSubview: container];
    [self initImageView];
    [self initDescription];
    [self initCloseButton];
    
    return self;
}

- (void)initImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.frame = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height/5);
    imageView.center = CGPointMake( self.bounds.size.width/2, self.bounds.size.height/6);
    imageView.image = [UIImage imageNamed: LOGO];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview: imageView];
}

- (void)initDescription
{
    //** Text One
    UILabel *description = [[UILabel alloc] init];
    
    description.frame = CGRectMake(0, 0, self.bounds.size.width/2.3, self.bounds.size.height/4);
    description.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2.8);
    description.text = @"API powered by: ";
    description.font = [UIFont fontWithName: @"Chalkduster" size: 14];
    [description setTextColor: [UIColor whiteColor]];
    
    //** API logo
    UIImageView *logoView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"pixabayOrange"]];
    
    logoView.frame = CGRectMake(0, 0, self.bounds.size.width/2, 90);
    logoView.contentMode = UIViewContentModeScaleAspectFit;
    logoView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2.2);
    
    //** Text Two
    UILabel *subDescription = [[UILabel alloc] init];
    
    subDescription.frame = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height/4);
    subDescription.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/1.6);
    subDescription.text = [NSString stringWithFormat: @"%@\n%@", @"Code avaible on:",  @"github.com/adizdar"];
    subDescription.font = [UIFont fontWithName: @"Chalkduster" size: 14];
    subDescription.numberOfLines = 0;
    subDescription.textAlignment = NSTextAlignmentLeft;
    [subDescription setTextColor: [UIColor whiteColor]];
    
    //*** Style title text */
    NSMutableAttributedString *titleText = [[NSMutableAttributedString alloc] initWithString: subDescription.text];
    [titleText addAttribute: NSForegroundColorAttributeName value: [self getBasicTextColor] range: NSMakeRange( 17, 18 )];
    subDescription.attributedText = titleText;
    
    //** Roby
    UIImageView *robyView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"roby"]];
    
    robyView.frame = CGRectMake(0, 0, 40, 40);
    robyView.contentMode = UIViewContentModeScaleAspectFit;
    robyView.center = CGPointMake(self.bounds.size.width - 30, self.bounds.size.height/1.1);
    
    [self addSubview: logoView];
    [self addSubview: description];
    [self addSubview: subDescription];
    [self addSubview: robyView];
}

- (void)initCloseButton
{
    UIButton *closeButton = [[UIButton alloc] initWithFrame: CGRectMake(self.bounds.size.width-45, 15, 30, 30)];
    
    [closeButton setImage: [UIImage imageNamed: @"close"] forState: UIControlStateNormal];
    closeButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    closeButton.clipsToBounds = YES;
   
    [closeButton addTarget: self
                    action: @selector(close:)
          forControlEvents: UIControlEventTouchUpInside];
    
    [self addSubview: closeButton];
}

- (void)close: (UIButton *)sender
{
    [UIView transitionWithView: self
                      duration: 0.2f
                       options: UIViewAnimationOptionTransitionCurlUp
                    animations: ^{
                        self.hidden = YES;
                    }
                    completion: nil];
}

- (UIColor *)getBasicBackgroundColor
{
    return [UIColor blackColor];
}

- (UIColor *)getBasicTextColor
{
    return [UtillsClass UIColorFromRGB: 0xF5A623];
}

@end
