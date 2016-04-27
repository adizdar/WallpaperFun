//
//  SwipeImageView.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 15/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "SwipeImageView.h"
#import "PreviewView.h"

#define DEFAULT_IMAGE @"bgwf"

@implementation SwipeImageView

typedef NS_ENUM (NSInteger, SwipeDirection) {
    Right = 1,
    Left = -1
};

#pragma mark - Lifecycle

- (instancetype)initWithCollection:(NSMutableArray *)collection
{
    self = [super init];
    
    if (!self) return nil;

    [self initSwipeRightGesture];
    [self initSwipeLeftGesture];

    self.collection = collection;
    
    if (self.collection && [self.collection count]!=0) {
        [self addSubview: [self.collection getImageObjectAtIndex: 0]];
    } else {
        [self addSubview: [[SingleImageView alloc] initWithImageData: UIImagePNGRepresentation([UIImage imageNamed: DEFAULT_IMAGE])
                                                           imageName: @"bg"]];
    }
    
    return self;
}

#pragma mark - Custom Accessors

- (void)setCollection:(NSMutableArray *)collection
{
    _collection = collection;
    [self removeAllSubViews];
    
    if (self.collection && [self.collection count]!=0) {
        [self.collection resetCurrentObject]; // TODO find better way to reset this
        [self addSubview: [self.collection getImageObjectAtIndex: 0]];
    } else {
        [self addSubview: [[SingleImageView alloc] initWithImageData: UIImagePNGRepresentation([UIImage imageNamed: DEFAULT_IMAGE])
                                                           imageName: @"bg"]];
    }
}

#pragma mark - Gesture init/handler

- (void)initSwipeRightGesture
{
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightHandler:)];
    
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    [self addGestureRecognizer:gestureRecognizer];
}

- (void)initSwipeLeftGesture
{
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftHandler:)];
    
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    [self addGestureRecognizer:gestureRecognizer];
}

- (void)swipeLeftHandler:(UISwipeGestureRecognizer *)recognizer {
    if ([self.collection count] == [self.collection getCurrentObjectIndex]+1) {
        
        [UtillsClass toggleMessageModal:@"End of results" view:self indicatorID: 100];
        
        // hide modal after timeout
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [UtillsClass hideModalHud: self];
        });
        
        return;
    }
    
    [self addSubviewToSlider: Left];
}

- (void)swipeRightHandler:(UISwipeGestureRecognizer *)recognizer {
    
    if ([self.collection getCurrentObjectIndex] == 0) {
        return;
    }
    
    [self addSubviewToSlider: Right];
}

#pragma mark - Private

- (void)removeSubviewFromView:(id)subview
{
    [subview removeFromSuperview];
    subview = nil;
}

- (void)removeAllSubViews
{
    id subview;

    while ((subview = [[self subviews] lastObject]) != nil) {
        [self removeSubviewFromView:subview];
    }
}

- (void)addSubviewToSlider: (int)direction
{
    SingleImageView *imageView = (direction == Left) ? [self.collection getNextObject] : [self.collection getPreviousObject];
    
    if (!imageView) return;
    
    // remove views
    [self removeAllSubViews];
    
    [UIView transitionWithView: self
                      duration: 0.5f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^{
                        [self addSubview: imageView];
                    }
                    completion:^(BOOL finished) {
                        //** Notify the delegate that the image changed
                        [self.delegate imageChanged: imageView.image];
                    }];

}

#pragma mark - Animation

- (POPSpringAnimation *)popContentChangeAnimation: (int)direction
{
    int width = [UIScreen mainScreen].bounds.size.width*1.3;
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    springAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(width*direction, 10)];
    springAnimation.springBounciness = 5;
    springAnimation.springSpeed = 6;
    
    return springAnimation;
}

- (POPBasicAnimation *)popFadeAnimation: (float)toAlpha
{
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed: kPOPViewAlpha];
    opacityAnimation.toValue = @(toAlpha);
    
    return opacityAnimation;
}

- (SingleImageView *)getCurrentImage
{
    return [self.collection getImageObjectAtIndex:[self.collection getCurrentObjectIndex]];
}

@end
