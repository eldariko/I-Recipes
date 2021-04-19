//
//  MyRecipesTableViewController.h
//  Recipes
//
//  Created by Lital Zigron on 05/01/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "MyRecipesViewCell.h"
#import "RecipeDetailsViewController.h"
#import "CheckInternet.h"
@interface MyRecipesTableViewController : UITableViewController
{
    NSMutableArray* myRecipesFromDB;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end
