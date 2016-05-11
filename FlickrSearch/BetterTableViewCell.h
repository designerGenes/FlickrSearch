//
//  BetterTableViewCell.h
//  designerJeans_Flickr
//
//  Created by Jaden Nation on 5/9/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface BetterTableViewCell : UITableViewCell {
  
}
# pragma mark -  outlets
@property (weak, nonatomic) IBOutlet UILabel *lblPostedBy;
@property (weak, nonatomic) IBOutlet UILabel *lblPhotoAge;
@property (weak, nonatomic) IBOutlet AsyncImageView *imgDownloadedPhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnRemoveFromFeed;
@property (weak, nonatomic) IBOutlet UIButton *btnLovePhoto;
@property (weak, nonatomic) IBOutlet UIView *viewBaseline;
@property (weak, nonatomic) IBOutlet AsyncImageView *imgBuddyIcon;



@property (weak, nonatomic) IBOutlet UIStackView *stackButtons;

- (IBAction)clickedRemoveFromFeed:(UIButton *)sender;
- (IBAction)clickedLovePhoto:(UIButton *)sender;


# pragma mark -  variables
@property (weak, nonatomic) NSString *poster;
@property (weak, nonatomic) NSString *postDare;

@property (strong, nonatomic) UIView *shadeView;


# pragma mark -  custom methods
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end





