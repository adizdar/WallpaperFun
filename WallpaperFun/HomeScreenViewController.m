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
#import "CustomSearchBar.h"
#import "TutorialView.h"
#import "PreviewView.h"

@interface HomeScreenViewController ()
@property (strong, nonatomic) SwipeImageView *imageSwipeFromCollection;
@property (strong, nonatomic) CustomSearchBar *searchBar;
@property (strong, nonatomic) MenuBar *menubar;
@property (strong, nonatomic) TutorialView *tutorial;
@property (strong, nonatomic) PreviewView *previewView;
@end

@implementation HomeScreenViewController

ImageLibary *libary;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
//    SingleImageRequestModel *requestModel = [SingleImageRequestModel new];
//    
//    [UtillsClass toggleLoadingIndicatorWithText: @"Loading data, please wait..."
//                                           view: self.view
//                                    indicatorID: 102];
//    requestModel.query = @"hjasdas";
//    
//    [[APIManager sharedManager] getImagesWithRequestModel: requestModel
//                                                  success: ^(SingleImageResponseModel *responseModel) {
//                                                      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                                                          @autoreleasepool {
//                                                              NSMutableArray *mutableImageCollection = [[NSMutableArray alloc] init];
//                                                              [mutableImageCollection addObjectsFromArray: responseModel.collection];
//                                                              
//                                                              dispatch_async(dispatch_get_main_queue(), ^{
//                                                                  [UtillsClass toggleLoadingIndicator: self.view
//                                                                                          indicatorID: 102];
//                                                                  
//                                                                  self.imageSwipeFromCollection.collection = mutableImageCollection;
//                                                                  
//                                                                  //** trigger tutorial screen only once when the app starts for the first time
//                                                                  if(![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"]) {
//                                                                      [self showTutorialScreen];
//                                                                      [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenTutorial"];
//                                                                  }
//                                                              });
//                                                              
//                                                          }
//                                                          
//                                                      });
//                                                      
//                                                      
//                                                  } failure: ^(NSError *error) {
//                                                      NSLog(@"%@", error);
//                                                  }];
    
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
    self.imageSwipeFromCollection.delegate = self;
    
    //** Search Bar
    self.searchBar = [[CustomSearchBar alloc] initWithDelegate: self];
    self.searchBar.hidden = YES;
    
    //** Menu Bar
    self.menubar = [[MenuBar alloc] init];
    self.menubar.hidden = YES;
    self.menubar.delegate = self;
    
    //** Gesture init
    [self initSwipeDownGesture];
    [self initSwipeUpGesture];
    [self initDoubleTapGesture];
    [self initTapGesture];
    self.longPress.enabled = YES;
    
    //** Image libary
    libary = [[ImageLibary alloc] init];
    
    //** Preview View
    self.previewView.hidden = YES;
//    UIView *test = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 90, 90)];
//    BOOL color = [self.previewView isImageDark: [UIImage imageNamed: @"bg"]];
    
    //** Add Subviews (Order is important)
    [self.view addSubview: self.imageSwipeFromCollection];
    [self.view addSubview: self.previewView];
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
                        self.menubar.hidden = YES;
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
                        self.searchBar.hidden = YES;
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

- (void)initTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOneTapGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)handleOneTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        if ( !self.searchBar.hidden ) {
            [self.searchBar dissmisSearchBar];
            [self.searchBar hideSearchBar];
        }
        
        if ( !self.menubar.hidden ) {
            [self.menubar hideWithAnimation];
        }
    }
}

- (void)initDoubleTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        [self togglePreviewScreen];
    }
}

#pragma mark - Custom Accessors

- (TutorialView *)tutorial
{
    // Lazy loading
    if (!_tutorial) {
        self.tutorial = [[TutorialView alloc] init];
        [self.view addSubview: self.tutorial];
    }
    
    return _tutorial;
}

- (PreviewView *)previewView
{
    if (!_previewView) {
        _previewView = [[PreviewView alloc] init];
    }
    
    return _previewView;
}

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

- (void)showTutorialScreen
{
    //** outside of the animation block so we can trigger the animation
    self.tutorial.alpha = 0;
    self.tutorial.hidden = NO;
    
    [UIView animateWithDuration: 0.3f
                     animations:^{
                         self.tutorial.alpha = 1.0f;
                         self.menubar.hidden = YES;
                         self.searchBar.hidden = YES;
                     } completion: nil];
}

- (void)togglePreviewScreen
{
    self.tutorial.hidden = YES;
    self.menubar.hidden = YES;
    self.searchBar.hidden = YES;
    
    [UIView transitionWithView: self.previewView
                      duration: 0.5f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^{
                        self.previewView.hidden = !self.previewView.hidden;
                    }
                    completion: nil];
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

#pragma mark - MenuBar delegate

- (void) helpButtonTap:(UIButton *)sender
{
    [self showTutorialScreen];
}

#pragma mark - SwipeImageView delegate

- (void)imageChanged: (UIImage *)image
{
    [self.previewView setPreviewImage: image];
}

#pragma mark - UISearchBar methods

//- (void)captureAndSaveImage
//{
//    float width = [UIScreen mainScreen].bounds.size.width;
//    float height = [UIScreen mainScreen].bounds.size.height;
//    // Capture screen here... and cut the appropriate size for saving and uploading
//    UIGraphicsBeginImageContext(self.view.bounds.size);
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageView *previewView = [[UIImageView alloc] init ];
//    
//    // crop the area you want
//    CGRect rect;
//    rect = CGRectMake(0, 10, 300, 300);    // whatever you want
//    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
//    UIImage *img = [UIImage imageWithCGImage:imageRef];
//    CGImageRelease(imageRef);
//    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    
//    previewView.image = img; // show cropped image on the ImageView
//    previewView.frame = CGRectMake(0, 25, width, height-25);
//    [self.view addSubview: previewView];
//
//}
//
//// this is option to alert the image saving status
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    UIAlertView *alert;
//    
//    // Unable to save the image
//    if (error)
//        alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                           message:@"Unable to save image to Photo Album."
//                                          delegate:self cancelButtonTitle:@"Dismiss"
//                                 otherButtonTitles:nil];
//    else // All is well
//        alert = [[UIAlertView alloc] initWithTitle:@"Success"
//                                           message:@"Image saved to Photo Album."
//                                          delegate:self cancelButtonTitle:@"Ok"
//                                 otherButtonTitles:nil];
//    [alert show];
//}


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
