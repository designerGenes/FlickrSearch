//
//  BaseViewController.h
//  designerJeans_Flickr
//
//  Created by Jaden Nation on 5/9/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC_model.h"


@interface BaseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
# pragma mark -  outlets
@property (weak, nonatomic) IBOutlet UIView *viewTopLayout;
@property (weak, nonatomic) IBOutlet UIView *viewBaseLayout;
@property (weak, nonatomic) IBOutlet UITableView *tblPhotoStream;
@property (weak, nonatomic) UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UIButton *btnSettings;
@property (weak, nonatomic) IBOutlet UIButton *btnFindTag;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldFindTag;
@property (weak, nonatomic) IBOutlet UIButton *btnFindNew;





# pragma mark -  variables
@property (strong, nonatomic) BaseVC_model *model;
@property (strong, nonatomic) UIView *shadeView;
@property (strong, nonatomic) NSTimer *updateTimer;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

# pragma mark -  custom methods
-(void)reloadTable :(NSArray *)data;
//-(void)reloadTableLazily; // just for debugging stuff
-(void)hideObtrusiveViews;
-(void)beginUpdatingTableView;
-(void) flashThroughLevelOfText :(NSArray *)remainingText;

@end

