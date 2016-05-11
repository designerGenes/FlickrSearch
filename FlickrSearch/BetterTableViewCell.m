//
//  BetterTableViewCell.m
//  designerJeans_Flickr
//
//  Created by Jaden Nation on 5/9/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

#import "BetterTableViewCell.h"
#import "UIKit/UIKit.h"

@implementation BetterTableViewCell

- (IBAction)clickedRemoveFromFeed:(UIButton *)sender {
  
}

- (IBAction)clickedLovePhoto:(UIButton *)sender {
  sender.selected = (sender.selected) ? false : true;
  
}



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *) reuseIdentifier {

  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  self.separatorInset = UIEdgeInsetsZero;
  
  [self.imgDownloadedPhoto setShowActivityIndicator:true];
  [self.imgDownloadedPhoto setActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite ];
  [self.imgDownloadedPhoto setCrossfadeDuration:1.5];
  
  [self.imgBuddyIcon setCrossfadeDuration:1.5];
  
  return self;
}

@end
