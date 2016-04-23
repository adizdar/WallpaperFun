//
//  HomeScreenViewController.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 10/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "APIManager.h"
#import "ImageRealm.h"
#import "UtillsClass.h"
#import "ImageLibary.h"
#import "SwipeImageView.h"
#import "CustomSearchBar.h"
#import "MenuBar.h"

@interface HomeScreenViewController ()
@property (strong, nonatomic) SwipeImageView *imageSwipeFromCollection;
@property (strong, nonatomic) CustomSearchBar *searchBar;
@property (strong, nonatomic) MenuBar *menubar;
@end

@implementation HomeScreenViewController

ImageLibary *libary;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    SingleImageRequestModel *requestModel = [SingleImageRequestModel new];
    
    [UtillsClass toggleLoadingIndicatorWithText: @"Loading data, please wait..."
                                           view: self.view
                                    indicatorID: 102];
    requestModel.query = @"flowers";
    
    [[APIManager sharedManager] getImagesWithRequestModel: requestModel
                                                  success: ^(SingleImageResponseModel *responseModel) {
                                                      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                          @autoreleasepool {
                                                              //                                                              RLMRealm *realm = [RLMRealm defaultRealm];
                                                              //
                                                              //                                                              [realm beginWriteTransaction];
                                                              //                                                              [realm deleteAllObjects];
                                                              //                                                              [realm commitWriteTransaction];
                                                              //                                                              [realm beginWriteTransaction];
                                                              
                                                              //                                                              NSData *imageData;
                                                              NSMutableArray *mutableImageCollection = [[NSMutableArray alloc] init];
                                                              [mutableImageCollection addObjectsFromArray: responseModel.collection];
                                                              //
                                                              //                                                              for (SingleImageModel *imageModel in responseModel.collection) {
                                                              //                                                                  imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageModel.url]];
                                                              //                                                                  [mutableImageCollection addObject: [[SingleImageView alloc] initWithImageData:imageData]];
                                                              //                                                              }
                                                              
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  [UtillsClass toggleLoadingIndicator: self.view
                                                                                          indicatorID: 102];
                                                                  
                                                                  self.imageSwipeFromCollection.collection = mutableImageCollection;
                                                              });
                                                              
                                                          }
                                                          
                                                      });
                                                      
                                                      
                                                  } failure: ^(NSError *error) {
                                                      NSLog(@"%@", error);
                                                  }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup/Gestures

- (void)setup
{
    //** Image slider
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    self.imageSwipeFromCollection = [[SwipeImageView alloc] initWithCollection: nil];
    self.imageSwipeFromCollection.frame = frame;
    [self.view addSubview: self.imageSwipeFromCollection];
    
    //** Search Bar
    self.searchBar = [[CustomSearchBar alloc] initWithDelegate: self];
    self.searchBar.hidden = YES;
    
    //** Menu Bar
    self.menubar = [[MenuBar alloc] init];
    self.menubar.hidden = YES;
    
    //** Gesture init
    [self initSwipeDownGesture];
    [self initSwipeUpGesture];
    self.longPress.enabled = YES;
    
    //** Image libary
    libary = [[ImageLibary alloc] init];
    
    //** Add Subviews
    [self.view addSubview: self.searchBar];
    [self.view addSubview: self.menubar];
}

- (void)initSwipeDownGesture
{
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownGesture:)];
    
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)swipeDownGesture:(UISwipeGestureRecognizer *)recognizer
{
    [UIView transitionWithView: self.searchBar
                      duration: 0.3f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^{
                        self.searchBar.hidden = !self.searchBar.hidden;
                    }
                    completion:^(BOOL finished) {
                        if (self.searchBar.hidden) [self.searchBar dissmisSearchBar];
                        else [[self.searchBar getSearchBar] becomeFirstResponder];
                    }];
}

- (void)initSwipeUpGesture
{
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUpGesture:)];
    
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)swipeUpGesture:(UISwipeGestureRecognizer *)recognizer
{
    [UIView transitionWithView: self.menubar
                      duration: 0.3f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^{
                        self.menubar.hidden = !self.menubar.hidden;
                    }
                    completion: nil];
}

//** long press
- (UILongPressGestureRecognizer *)longPress
{
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
        [self.view addGestureRecognizer:_longPress];
    }
    return _longPress;
}

- (void)longPressGesture:(UILongPressGestureRecognizer*)gesture
{
    if ( gesture.state == UIGestureRecognizerStateBegan ) {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        SingleImageView *currentImage = [self.imageSwipeFromCollection getCurrentImage];
        
        [libary saveImageToLibary: currentImage.image];
        
        [UtillsClass toggleMessageModal: @"Image saved" view: self.view indicatorID: 110];
        [UtillsClass toggleAfterTimeout: self.view];
        
    } else if ( gesture.state == UIGestureRecognizerStateFailed ) {
        NSLog(@"ERROR -> HomeController, longPress gesture error");
        [UtillsClass toggleMessageModal: @"Save failed" view: self.view indicatorID: 110];

    }
}

#pragma mark - Custom Accessors

#pragma mark - IBActions

#pragma mark - Public

#pragma mark - Private

- (void)searchForImages: (NSString *)text
{
    SingleImageRequestModel *requestModel = [SingleImageRequestModel new];
    requestModel.query = text;
    
    [UtillsClass toggleLoadingIndicatorWithText: @"Loading data, please wait..."
                                           view: self.view
                                    indicatorID: 102];
    
    [[APIManager sharedManager] getImagesWithRequestModel: requestModel
                                                  success: ^(SingleImageResponseModel *responseModel) {
                                                      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                          @autoreleasepool {
                                                              NSMutableArray *mutableImageCollection = [[NSMutableArray alloc] init];
                                                              [mutableImageCollection addObjectsFromArray: responseModel.collection];
                                                              
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  [UtillsClass toggleLoadingIndicator: self.view
                                                                                          indicatorID: 102];
                                                                  
                                                                  self.imageSwipeFromCollection.collection = mutableImageCollection;
                                                                  
                                                                  //** Hide & Dissmis Search Bar
                                                                  [self.searchBar dissmisSearchBar];
                                                                  [self.searchBar hideSearchBar];
                                                                  
                                                                  //** Hide Navigation Bar
                                                                  if(!self.menubar.hidden)
                                                                      [self.menubar hideWithAnimation];
                                                              });
                                                              
                                                          }
                                                          
                                                      });
                                                      
                                                      
                                                  } failure: ^(NSError *error) {
                                                      NSLog(@"%@", error);
                                                  }];

}

#pragma mark - UISearchBar delegate

//** Search Action
- (void)searchBarSearchButtonClicked: (UISearchBar*)searchBar
{
    UISearchBar *searchbar = [self.searchBar getSearchBar];

    [searchbar resignFirstResponder];
    [searchbar setShowsCancelButton:NO animated:YES];
    
    [self searchForImages: searchbar.text];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [[self.searchBar getSearchBar] setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar dissmisSearchBar];
    [self.searchBar hideSearchBar];
}

#pragma mark - UISearchBar methods

@end

//- (void)check3DTouch
//{
//    // register for 3D Touch (if available)
//    if ([self.traitCollection
//         respondsToSelector:@selector(forceTouchCapability)] &&
//        self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
//
//        [self registerForPreviewingWithDelegate:(id)self sourceView: self.imageSwipeFromCollection];
//
//        // no need for our alternative anymore
//        self.longPress.enabled = NO;
//
//    } else {
//        // handle a 3D Touch alternative (long gesture recognizer)
//        // it calls longPress method which registrate the press selector
//        self.longPress.enabled = YES;
//    }
//}
