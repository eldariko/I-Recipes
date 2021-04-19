//
//  RecipeDetailsViewController.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 28/12/15.
//  Copyright © 2015 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import "Model.h"
#import "Comment.h"
#import "Favorites.h"
#import "CommentViewCell.h"
#import "Follow.h"
#import "CheckInternet.h"
@interface RecipeDetailsViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSArray* commentsFromDB;
}
@property NSString* imageName;
@property NSString* user;
@property Recipe* myRecipe;

@property (weak, nonatomic) IBOutlet UILabel *recipeName;
@property (weak, nonatomic) IBOutlet UILabel *chef;
@property (weak, nonatomic) IBOutlet UITextView *ingredients;
@property (weak, nonatomic) IBOutlet UITextView *directions;
@property (weak, nonatomic) IBOutlet UITextField *comment;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *favorite;
- (IBAction)favoriteBtn:(id)sender;
- (IBAction)followMe:(id)sender;
- (IBAction)saveBtn:(id)sender;
@end

