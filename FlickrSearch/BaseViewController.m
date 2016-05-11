//
//  BaseViewController.m
//  designerJeans_Flickr
//
//  Created by Jaden Nation on 5/9/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

#import "BaseViewController.h"
#import "FlickrKit/FlickrKit.h"
#import "BetterTableViewCell.h"
#import "ChameleonFramework/Chameleon.h"
#import "AppDelegate.h"
#import "DateTools.h"
#import "AsyncImageView.h"
#import "FlickrPhoto.h"


@implementation BaseViewController {
  NSMutableArray *viewsArray;
  UIActivityIndicatorView *indicatorView;
  NSMutableArray *waitMessages;
  
  NSMutableArray *dataForTable;
}


# pragma mark -  outlets
- (IBAction)clickedSettings:(UIButton *)sender { [self doClickedSettings:sender];}

- (IBAction)clickedFindTag:(UIButton *)sender {
  [self.model requestPhotosOfTag:[_txtFieldFindTag text] :nil :nil];
  [self.view endEditing:true];
}
- (IBAction)typedInField:(UITextField *)sender {
  _btnFindTag.enabled = (sender.text != @"") ? true : false;
}



- (IBAction)clickedFindNew:(UIButton *)sender {
  [self.model requestPhotosOfRecent];
}




# pragma mark -  variables
  NSTimer *updateTimer = nil;

# pragma mark -  custom methods
-(void)doClickedSettings :(UIButton *)sender {
  CGFloat safeDistance = (self.view.frame.size.width - sender.frame.size.width - 32) * -1;
  CGAffineTransform delta = (sender.tag == 1) ? CGAffineTransformIdentity: CGAffineTransformMakeTranslation(safeDistance, 0) ;
  
  [UIView animateWithDuration:0.65 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    
    sender.transform = delta;
  } completion:^(BOOL finished) {
    sender.tag = (sender.tag == 1) ? 0 : 1;
    [self showOrHideSettings:(int)sender.tag];
    
  }];
  
  
}

-(void)refreshFeed {
  [self.refreshControl endRefreshing];
  if (self.model.currentRequest) {
    [self.model handleRequest:self.model.currentRequest];
  }
  
  [self reloadTable:dataForTable];
}

-(void)showOrHideSettings :(int)tag {
  CGFloat alphaChange = (tag == 1) ? 1 : 0;
    [UIView animateWithDuration:0.35 animations:^{
      // cycle views and make them appear
      
    } completion:^(BOOL finished) {
      //
    }];
  
}

-(void) conjureActivityIndicator :(UIColor*)tint {
  if (indicatorView == nil) {
    indicatorView = [[UIActivityIndicatorView alloc] init];
    indicatorView.alpha = 0;
    [self.view addSubview:indicatorView];
    indicatorView.center = CGPointMake(self.view.center.x, self.view.center.y - 45);
    indicatorView.color = tint;
    indicatorView.transform = CGAffineTransformMakeScale(3, 3);
  }
  indicatorView.startAnimating;
  [UIView animateWithDuration:2.35 animations:^{
    indicatorView.alpha = 1;
  }];
}

-(void) flashThroughLevelOfText :(NSArray *)remainingText {
  static int *counter;
  static UILabel *lblDisplayed;
  
  if (remainingText.count == 0) {
    [lblDisplayed removeFromSuperview];
    

    
    
//    [self reloadTable];
    return; }
  
  if (counter >= 3 && remainingText.count > 0) {
    NSMutableArray *shrunkArray = remainingText.mutableCopy;
    [shrunkArray removeObjectAtIndex:0];
    remainingText = shrunkArray;
    counter = 0;
  }
  
  if (lblDisplayed == nil) {
    lblDisplayed = [[UILabel alloc] init];
    [self.view addSubview:lblDisplayed];
  }
  
  lblDisplayed.alpha = 0;
  lblDisplayed.textAlignment = NSTextAlignmentCenter;
  lblDisplayed.numberOfLines = 0;
  lblDisplayed.frame = CGRectMake(0, 0, 250, 250);
  lblDisplayed.center = CGPointMake(self.view.center.x, self.view.center.y);
  lblDisplayed.font = [UIFont fontWithName:@"Bebas" size:18];
  lblDisplayed.adjustsFontSizeToFitWidth = false;
  lblDisplayed.textColor = [UIColor flatWhiteColor];
  
  lblDisplayed.text = (NSString *) remainingText.firstObject;

    [UIView animateWithDuration:1.0 animations:^{
      lblDisplayed.alpha = 1;
      lblDisplayed.transform = CGAffineTransformMakeScale(1.15, 1.15);
    } completion:^(BOOL finished) {
      if (finished) {
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
          lblDisplayed.alpha = 0;
          lblDisplayed.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
          if (finished) {
            counter++;
            return [self flashThroughLevelOfText:remainingText];
          }
        }];
      }
    }];
}

-(void)setupFetchButtons {
  
}

-(void)setUpRefreshControl {
  self.refreshControl = [[UIRefreshControl alloc] init];
  self.refreshControl.backgroundColor = [UIColor flatRedColorDark];
  self.refreshControl.tintColor = [UIColor flatWhiteColor];
  
  [self.refreshControl addTarget:self
                          action:@selector(refreshFeed)
                forControlEvents:UIControlEventValueChanged];
 [self.tblPhotoStream addSubview:_refreshControl];
}

-(void) didLoadStuff {
  self.tblPhotoStream.delegate = self;
  self.tblPhotoStream.dataSource = self;
  self.txtFieldFindTag.delegate = self;
  self.txtFieldFindTag.autocorrectionType = UITextAutocorrectionTypeNo;
  self.txtFieldFindTag.autocapitalizationType = UITextAutocapitalizationTypeNone;
  
  
  self.model = [[BaseVC_model alloc] initWithMaster:self];
  [self.model requestPhotosOfRecent];
//  [self.model requestPhotosOfTag:@"goldfish" :nil :nil];
///
}

-(void) didAppearStuff {
  waitMessages = [NSMutableArray arrayWithObjects: @"We are preparing your images.  Please hold.",
                  @"Almost there!  Only a few more to download",
                  @"Wrapping up the final steps", nil];
  [UIView animateWithDuration:0.75 animations:^{
    self.btnSettings.transform = CGAffineTransformIdentity;
  } completion:^(BOOL finished) {
  
    
      [self conjureActivityIndicator:[UIColor flatRedColor]];
//      [self flashThroughLevelOfText:waitMessages];  // should work recursively
    
  }];
  
  
  
  
  
}

-(void) willAppearStuff {
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


  [self setUpRefreshControl];
  [self setupFetchButtons];
  self.btnSettings.transform = CGAffineTransformMakeTranslation(self.btnSettings.frame.size.width + 16, 0);
  
  self.txtFieldFindTag.text = @"goldfish";
}



-(void) hideObtrusiveViews {
  indicatorView.stopAnimating;
  [UIView animateWithDuration:0.35 animations:^{
    indicatorView.alpha = 0;
    indicatorView.transform = CGAffineTransformMakeScale(3, 3);
  } completion:^(BOOL finished) {
    [indicatorView removeFromSuperview];
  }];
  
  
}

# pragma mark - UITextFieldDelegate functions
-(bool)textFieldShouldReturn:(UITextField *)textField {
  [self.view endEditing:true];
  return false;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
  CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  
  [UIView animateWithDuration:0.3 animations:^{
    CGRect f = self.view.frame;
    f.origin.y = -keyboardSize.height;
    self.view.frame = f;
  }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
  [UIView animateWithDuration:0.3 animations:^{
    CGRect f = self.view.frame;
    f.origin.y = 0.0f;
    self.view.frame = f;
  }];
}


# pragma mark - UITableViewDelegate functions
-(void)reloadTable :(NSArray *)data {  // in case we want to call methods beforehand
  if (indicatorView) {
    [UIView animateWithDuration:0.4 animations:^{
      indicatorView.alpha = 0;
    } completion:^(BOOL finished) {
      indicatorView.removeFromSuperview;
    }];
    
  }
  
  NSLog(@"Made it to reload");
  NSLog(@"%lu", (unsigned long)data.count);
  if(data) {
    dataForTable = [NSMutableArray arrayWithArray:data.mutableCopy];
  }
  NSLog(@"%lu", (unsigned long)dataForTable.count);
  if (self.refreshControl) {
    [self.refreshControl endRefreshing];
  }
  
   [self.tblPhotoStream reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (!dataForTable) { return 0; }
  NSInteger count = dataForTable.count;
  
  
//  if (count > 50) { return 50 ;}
  
  return count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  FlickrKit *fk = [FlickrKit sharedFlickrKit];
  NSString *identifier = @"PhotoCell";
  BetterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(identifier) forIndexPath:indexPath];
  
  if (cell == nil) {
   cell = [[BetterTableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier ];
  }
  
    FlickrPhoto *currentPhoto = dataForTable[indexPath.row];
  
  
    // cell image
    [cell.imgDownloadedPhoto setImageURL:currentPhoto.photoURL];
  
  
    // photo date
  
    double dateInterval = [currentPhoto.photoTakenDate doubleValue];
    NSDate *finalDate = [NSDate dateWithTimeIntervalSince1970:dateInterval];
    cell.lblPhotoAge.text = [NSString stringWithFormat:@"posted %@",[finalDate timeAgoSinceNow]];
  
  
    // user buddy icon
  
  
    // user screen name
    cell.lblPostedBy.text = [NSString stringWithFormat: @"from:  %@", currentPhoto.photoOwner];
  
    // get buddy image
  [self.model getUserDetailsFor:currentPhoto.photoOwner :^(NSMutableArray *details) {
    
    NSURL *imageURL = [fk buddyIconURLForUser:details[0]];
    
    [cell.imgBuddyIcon setImageURL:imageURL];
    //[AIL loadImageWithURL:imageURL];
    
    
    
    
//    UIImage *myImage = [self.model getBuddyIconWith:details];
//    dispatch_queue_t bgQ = [AppDelegate getAppDelegate].GlobalBackgroundQueue;
//    dispatch_async(bgQ, ^{
////      NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
////      UIImage *image = [UIImage imageWithData:imageData];
//
//      [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:imageURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (!connectionError) {
//          UIImage *img = [[UIImage alloc] initWithData:data];
//          
//            cell.imgBuddyIcon.image = img;
//          
//        }else{
//          NSLog(@"%@",connectionError);
//        }
//      }];
    
//    });
    
  }];
  
    

    cell.viewBaseline.backgroundColor = [self.viewTopLayout.backgroundColor lightenByPercentage:(0.03)];
    cell.contentView.alpha = 0;
  
  
  
  return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  BetterTableViewCell *myCell = (BetterTableViewCell *) cell;
  double duration = 0.35;
  [UIView animateWithDuration:duration animations:^{
    myCell.contentView.alpha = 1;
//    myCell.lblPhotoAge.transform = CGAffineTransformMakeTranslation(-4, 0);
//    myCell.lblPostedBy.transform = CGAffineTransformMakeTranslation(4, 0);
    
  }];
}







# pragma mark -  required methods

- (void)viewDidLoad {
  [self didLoadStuff];
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
  [self didAppearStuff];
  [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated {
  [self willAppearStuff];
  [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
  [super viewWillDisappear:animated];
}



- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end

