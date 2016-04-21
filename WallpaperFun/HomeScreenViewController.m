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

@interface HomeScreenViewController ()
@property (strong, nonatomic) SwipeImageView *imageSwipeFromCollection;
@property (strong, nonatomic) CustomSearchBar *searchBar;
@end

@implementation HomeScreenViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    SingleImageRequestModel *requestModel = [SingleImageRequestModel new];
    
    [UtillsClass toggleLoadingIndicatorWithText: @"Loading data, please wait..."
                                           view: self.view
                                    indicatorID: 102];
    
    //    __block ImageLibary *libary = [[ImageLibary alloc] init];
    //    __block SwipeImageView *imageSwipeFromCollection = [[SwipeImageView alloc] initWithCollection: nil];
    
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
                                                                  
                                                                  //                                                                  [self.view addSubview: imageView];
                                                                  //                                                                  [libary saveImageToLibary: imageView.image];
                                                                  //[imageView saveImage];
                                                                  
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

#pragma mark - Setup

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
    
    //** Gesture init
    [self initSwipeDownGesture];
    
    [self.view addSubview: self.searchBar];
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
                        if (self.searchBar.hidden) [self dissmisSearchBar];
                        else [[self.searchBar getSearchBar] becomeFirstResponder];
                    }];
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
                                                                  [self dissmisSearchBar];
                                                                  [self hideSearchBar];
                                                                  
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
    [self dissmisSearchBar];
    [self hideSearchBar];
}

#pragma mark - UISearchBar methods

- (void)dissmisSearchBar
{
    UISearchBar *searchbar = [self.searchBar getSearchBar];
    
    [searchbar resignFirstResponder];
    [searchbar setShowsCancelButton:NO animated:YES];
    
    searchbar.text = @"";
}

- (void)hideSearchBar
{
    [UIView transitionWithView: self.searchBar
                      duration: 0.3f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^{
                        self.searchBar.hidden = YES;
                    }
                    completion: nil];
}

@end
