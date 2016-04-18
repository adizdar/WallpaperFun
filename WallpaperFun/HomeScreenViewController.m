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


@interface HomeScreenViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) SwipeImageView *imageSwipeFromCollection;
@end

@implementation HomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    SingleImageRequestModel *requestModel = [SingleImageRequestModel new];

    [UtillsClass toggleLoadingIndicatorWithText: @"Loading data, please wait..."
                                           view: self.view
                                    indicatorID: 102];
    
//    __block ImageLibary *libary = [[ImageLibary alloc] init];
//    __block SwipeImageView *imageSwipeFromCollection = [[SwipeImageView alloc] initWithCollection: nil];
    
    self.imageSwipeFromCollection = [[SwipeImageView alloc] initWithCollection: nil];
    self.imageSwipeFromCollection.frame = frame;
    
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
                                                                  
                                                                  [self.view insertSubview: self.imageSwipeFromCollection
                                                                              belowSubview: self.searchField];
                                                                  
//                                                                  [self.view addSubview:imageSwipeFromCollection];
                                                                  
//                                                                  [self.view addSubview: imageView];
//                                                                  [libary saveImageToLibary: imageView.image];
                                                                  //[imageView saveImage];
//                                                                  self.imageView.image = [UIImage imageWithData: imageData];
                                                              });
                                                          
                                                          }
                                                          
                                                      });
                                                      
                                                      
                                                  } failure: ^(NSError *error) {
                                                      NSLog(@"%@", error);
                                                  }];
    
    

}

- (IBAction)search:(UIButton *)sender
{
    [self.searchField resignFirstResponder];
    [self searchForImages:[self.searchField text]];
}

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
                                                                  
                                                                  [self.view insertSubview: self.imageSwipeFromCollection belowSubview: self.searchField];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
