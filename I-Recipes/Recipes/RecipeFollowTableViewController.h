//
//  RecipeFollowTableViewController.h
//  Recipes
//
//  Created by Admin on 1/8/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckInternet.h"
@interface RecipeFollowTableViewController : UITableViewController
{
    NSMutableArray* myFollowRecipesFromDB;
}
@property NSString* followedUser;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
