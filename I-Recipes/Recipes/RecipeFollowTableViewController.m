//
//  RecipeFollowTableViewController.m
//  Recipes
//
//  Created by Admin on 1/8/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import "RecipeFollowTableViewController.h"
#import "Follow&favoriteTableViewCell.h"
#import "RecipeDetailsViewController.h"
#import "Model.h"
@interface RecipeFollowTableViewController ()
{
    NSMutableArray *filteredFollowers;
    BOOL isFilterd;
}
@end

@implementation RecipeFollowTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([CheckInternet checkInternet:self])
    {
        self.searchBar.delegate = (id)self;
    myFollowRecipesFromDB = [[NSMutableArray alloc] init];
    [[Model instance] getMyRecipesAsynch:_followedUser withblock:^(NSMutableArray * stArray){
        myFollowRecipesFromDB = stArray;
        [self.tableView reloadData];
    }];
        

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isFilterd) {
        return filteredFollowers.count;
    }
   else return myFollowRecipesFromDB.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Follow_favoriteTableViewCell *cell = (Follow_favoriteTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"Follow_favoriteCell"];
    if(cell==nil)
    {
        cell=(Follow_favoriteTableViewCell*)[[Follow_favoriteTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Follow_favoriteCell"];
    }
    Recipe* recipe=nil;
    if (isFilterd) {
      recipe=  [filteredFollowers objectAtIndex:indexPath.row];
    }else recipe = [myFollowRecipesFromDB objectAtIndex:indexPath.row];
    
    [cell.activityIndicator startAnimating];
    cell.recipeName.text = recipe.recipeName;
    [[Model instance] getUserName:recipe.user block:^(NSString* userName){
        cell.byName.text=userName;
    }];
    cell.imageName = [NSString stringWithFormat:@"%@.png",recipe.recipeName];
    [[Model instance] getRecipeImage:recipe block:^(UIImage *image) {
        if (image != nil && [cell.imageName isEqualToString:recipe.imageName]) {
            [cell.imageView setImage:image];
            [cell.activityIndicator stopAnimating];
            cell.activityIndicator.hidden = YES;
        }
    }];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toDetailsRecipe"])
    {
        RecipeDetailsViewController* rdvc =segue.destinationViewController;
        Recipe* r= [myFollowRecipesFromDB objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        rdvc.myRecipe=r;
    }
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        isFilterd = NO;
    }else{
        isFilterd=YES;
        filteredFollowers = [[NSMutableArray alloc] init];
        
        for (Recipe* r in myFollowRecipesFromDB) {
            NSRange recipeNameRange = [r.recipeName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (recipeNameRange.location != NSNotFound) {
                [filteredFollowers addObject:r];
            }
        }
    }
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableView.rowHeight;
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    [self.searchBar resignFirstResponder];
}
@end
