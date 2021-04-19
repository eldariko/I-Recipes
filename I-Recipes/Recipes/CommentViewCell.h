//
//  CommentViewCell.h
//  Recipes
//
//  Created by Lital Zigron on 03/01/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *user;
@property (weak, nonatomic) IBOutlet UITextView *comment;

@end
