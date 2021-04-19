//
//  RecipesTableViewController.h
//  Recipes
//
//  Created by Lital Zigron on 28/12/15.
//  Copyright © 2015 Lital Zigron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewRecipeViewController.h"
#import "Model.h"
#import "NewRecipeViewController.h"
#import "RecipeDetailsViewController.h"
#import "CheckInternet.h"
#import "Follow&favoriteTableViewCell.h"
@interface RecipesTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
{
NSArray* recipesFromDB;
}
@property (strong, nonatomic)NSString* category;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchController *searchDisplayController;
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end
