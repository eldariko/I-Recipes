//
//  RecipesTableViewController.m
//  Recipes
//
//  Created by Lital Zigron on 28/12/15.
//  Copyright © 2015 Lital Zigron. All rights reserved.
//

#import "RecipesTableViewController.h"

@interface RecipesTableViewController (){
    NSMutableArray *filteredRecipes;
    BOOL isFilterd;
}

@end

@implementation RecipesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = (id)self;
    if([CheckInternet checkInternet:self]){
    recipesFromDB = [[NSArray alloc] init];
        [[Model instance] getRecipesCategoryAsynch:self.category :^(NSArray * stArray){
        recipesFromDB = stArray;
        [self.tableView reloadData];
    }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableView.rowHeight;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isFilterd) {
        return filteredRecipes.count;
    }
    else return recipesFromDB.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Follow_favoriteTableViewCell *cell = (Follow_favoriteTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"Follow_favoriteCell"];
    Recipe* recipe=nil;
    if(cell==nil)
    {
        cell=(Follow_favoriteTableViewCell*)[[Follow_favoriteTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Follow_favoriteCell"];
    }
    if (isFilterd){
        recipe = [filteredRecipes objectAtIndex:indexPath.row];
    }else recipe =[recipesFromDB objectAtIndex:indexPath.row];
    [[Model instance]getUserName:recipe.user block:^(NSString * name) {
        cell.byName.text=name;
    }];
    [cell.activityIndicator startAnimating];
    cell.recipeName.text = recipe.recipeName;
    cell.imageName = [NSString stringWithFormat:@"%@.png",recipe.recipeName];
    if([CheckInternet checkInternet:self])
    {
        [[Model instance] getRecipeImage:recipe block:^(UIImage *image) {
            if (image != nil && [cell.imageName isEqualToString:recipe.imageName]) {
                [cell.imageView setImage:image];
                [cell.activityIndicator stopAnimating];
                cell.activityIndicator.hidden = YES;
            }
        }];
    }
  //  cell.textLabel.text=recipe.recipeName;
    
    return cell;
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"toDetailsRecipe"])
    {
            RecipeDetailsViewController* rdvc =segue.destinationViewController;
            Recipe* r= [recipesFromDB objectAtIndex:[self.tableView indexPathForSelectedRow].row];
            rdvc.myRecipe=r;
    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        isFilterd = NO;
    }else{
        isFilterd=YES;
        filteredRecipes = [[NSMutableArray alloc] init];
        
        for (Recipe* r in recipesFromDB) {
            NSRange recipeNameRange = [r.recipeName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (recipeNameRange.location != NSNotFound) {
                [filteredRecipes addObject:r];
            }
        }
    }
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}


/////
- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [super viewDidUnload];
}

 

@end
