//
//  HomeScreenViewController.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 10/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "APIManager.h"
#import "UtillsClass.h"
#import "ImageLibary.h"
#import "CustomSearchBar.h"
#import "TutorialView.h"
#import "PreviewView.h"
#import "AppDelegate.h"
#import "ModalView.h"

@interface HomeScreenViewController ()
@property (strong, nonatomic) SwipeImageView *imageSwipeFromCollection;
@property (strong, nonatomic) CustomSearchBar *searchBar;
@property (strong, nonatomic) MenuBar *menubar;
@property (strong, nonatomic) TutorialView *tutorial;
@property (strong, nonatomic) PreviewView *previewView;
@property (strong, nonatomic) ModalView *modalView;
@end

@implementation HomeScreenViewController

ImageLibary *libary;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"]) {
        [self showTutorialScreen];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenTutorial"];
    }
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
    
    //** Add Subviews (Order is important)
    [self.view addSubview: self.imageSwipeFromCollection];
    [self.view addSubview: self.previewView];
    [self.view addSubview: self.searchBar];
    [self.view addSubview: self.menubar];
    [self.view addSubview: self.modalView];
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
    [self.searchBar dissmisSearchBar];
    
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
        
        [self.imageSwipeFromCollection getCurrentImage:^(SingleImageView *imageView) {
            [libary saveImageToLibary: imageView.image];
            
            [UtillsClass modalWithImageMBHUD: self.view
                                        text: @"Saved"
                                 detailsText: @"Image added to WallpaperFun album"
                                 indicatorID: 110
                                       image: [UIImage imageNamed:@"save"]];
            [UtillsClass toggleAfterTimeout: self.view];

        }];
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
        _previewView = [[PreviewView alloc] initWithThemes: @"previewLight" darkTheme: @"previewDark"];
    }
    
    return _previewView;
}

- (ModalView *)modalView
{
    if (!_modalView) {
        _modalView = [[ModalView alloc] init];
        _modalView.hidden = YES;
    }
    
    return _modalView;
}

#pragma mark - IBActions

#pragma mark - Public

#pragma mark - Private

- (void)searchForImages: (NSString *)text
{
    SingleImageRequestModel *requestModel = [SingleImageRequestModel new];
    requestModel.query = text;
        
    //** Hide & Dissmis Search Bar
    [self.searchBar dissmisSearchBar];
    [self.searchBar hideSearchBar];
    
    [UtillsClass toggleLoadingIndicatorWithText: @"Searching ..."
                                           view: self.view
                                    indicatorID: 102];
    
    [[APIManager sharedManager] getImagesWithRequestModel: requestModel
                                                  success: ^(SingleImageResponseModel *responseModel) {
                                                      [self searchResponse: responseModel];
                                                  } failure: ^(NSError *error) {
                                                      [self errorResponse: error];
                                                  }];

}

- (void)showTutorialScreen
{
    //** outside of the animation block so we can trigger the animation
    self.tutorial.alpha = 0;
    self.tutorial.hidden = NO;

    [UIView animateWithDuration: 0.2f
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

- (void)searchResponse: (SingleImageResponseModel *)responseModel
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSMutableArray *mutableImageCollection = [[NSMutableArray alloc] init];
            [mutableImageCollection addObjectsFromArray: responseModel.collection];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UtillsClass toggleLoadingIndicator: self.view
                                        indicatorID: 102];
                
                self.imageSwipeFromCollection.collection = mutableImageCollection;
                
                if (mutableImageCollection && ![mutableImageCollection count]) {
                    [UtillsClass modalWithImageMBHUD: self.view
                                                text: @"Sorry"
                                         detailsText: @"No results for this entery :("
                                         indicatorID: 400
                                               image: [UIImage imageNamed:@"wrong"]];
                    
                    [UtillsClass toggleAfterTimeout: self.view];
                }
                
                //** Hide Navigation Bar
                if(!self.menubar.hidden)
                    [self.menubar hideWithAnimation];
            });
            
        }
        
    });
}

- (void)errorResponse: (NSError *)error
{
    NSLog(@"%@", error);
    [UtillsClass toggleLoadingIndicator: self.view
                            indicatorID: 102];
    
    [UtillsClass modalWithImageMBHUD: self.view
                                text: @"Connection failed :("
                         detailsText: @"Please check your internet connection"
                         indicatorID: 404
                               image: [UIImage imageNamed:@"error"]];
    
    [UtillsClass toggleAfterTimeout: self.view];
}

#pragma mark - UISearchBar delegate

//** Search Action
- (void)searchBarSearchButtonClicked: (UISearchBar*)searchBar
{
    UISearchBar *searchbar = [self.searchBar getSearchBar];
    
    if (!searchbar.text) return;

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

- (void) aboutButtonTap: (UIButton *)sender
{
    [UIView transitionWithView: self.modalView
                      duration: 0.2f
                       options: UIViewAnimationOptionTransitionCurlDown
                    animations: ^{
                        self.searchBar.hidden = YES;
                        self.menubar.hidden = YES;
                        self.modalView.hidden = NO;
                    }
                    completion: nil];
}

- (void)helpButtonTap:(UIButton *)sender
{
    [self showTutorialScreen];
}

- (void) favoritesButtonTap: (UIButton *)sender
{
    SingleImageRequestModel *requestModel = [SingleImageRequestModel new];
    requestModel.query = @"";
    
    //** Hide & Dissmis Search Bar
    [self.searchBar dissmisSearchBar];
    [self.searchBar hideSearchBar];
    
    [UtillsClass toggleLoadingIndicatorWithText: @"Loading Editor Chocice images..."
                                           view: self.view
                                    indicatorID: 102];
    
    [[APIManager sharedManager] getEditorChoiceImagesWithRequestModel: requestModel
                                                              success: ^(SingleImageResponseModel *responseModel) {
                                                                  [self searchResponse: responseModel];
                                                              } failure: ^(NSError *error) {
                                                                  [self errorResponse: error];
                                                              }];
    
    
}

- (void)flip: (UISwitch *)sender
{
    if (sender.on) {
     [self.previewView setLightAndDarkTheme: @"previewLight"
                                 darkTheme:  @"previewDark"];
    } else {
      [self.previewView setLightAndDarkTheme: @"lockLight"
                                   darkTheme: @"lockDark"];
    }
}

#pragma mark - SwipeImageView delegate

- (void)imageChanged: (UIImage *)image
{
    if (image) {
        [self.previewView setPreviewImage: image];
    } else {
        [UtillsClass modalWithImageMBHUD: self.view
                                    text: @"Connection failed :("
                             detailsText: @"Please check your internet connection"
                             indicatorID: 404
                                   image: [UIImage imageNamed:@"error"]];
        
        [UtillsClass toggleAfterTimeout: self.view];
    }
}

#pragma mark - UISearchBar methods


@end


