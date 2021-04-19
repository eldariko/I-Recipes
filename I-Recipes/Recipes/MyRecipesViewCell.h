//
//  MyRecipesViewCell.h
//  Recipes
//
//  Created by Lital Zigron on 05/01/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRecipesViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *recipeName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property NSString* imageName;
@end
