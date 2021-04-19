//
//  Follow&favoriteTableViewCell.h
//  Recipes
//
//  Created by Admin on 1/4/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Follow_favoriteTableViewCell : UITableViewCell
@property NSString* imageName;
@property (weak, nonatomic) IBOutlet UILabel *recipeName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *byName;
@property (weak, nonatomic) IBOutlet UILabel *exclusiveByUser;
@end
