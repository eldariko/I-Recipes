//
//  MyRecipesTableViewController.m
//  Recipes
//
//  Created by Lital Zigron on 05/01/16.
//  Copyright © 2016 Lital Zigron. All rights reserved.
//

#import "MyRecipesTableViewController.h"
@interface MyRecipesTableViewController ()
{
    NSMutableArray *filteredRecipes;
    BOOL isFilterd;
}
@end

@implementation MyRecipesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([CheckInternet checkInternet:self])
    {
    myRecipesFromDB = [[NSMutableArray alloc] init];
    [[Model instance] getMyRecipesAsynch:nil withblock:^(NSMutableArray * stArray){
        myRecipesFromDB = stArray;
        [self.tableView reloadData];
    }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isFilterd)
        return filteredRecipes.count;
    else return myRecipesFromDB.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyRecipesViewCell *cell = (MyRecipesViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"myRecipeCell" ];
   
    Recipe* recipe = nil;
    if(cell==nil)
    {
        cell=(MyRecipesViewCell*)[[MyRecipesViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myRecipeCell"];
    }
    if (isFilterd) {
        recipe= [filteredRecipes objectAtIndex:indexPath.row];
    }else recipe=[myRecipesFromDB objectAtIndex:indexPath.row];
    
    [cell.activityIndicator startAnimating];
    cell.recipeName.text = recipe.recipeName;
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
        Recipe* r= [myRecipesFromDB objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        rdvc.myRecipe=r;
        
    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        isFilterd = NO;
    }else{
        isFilterd=YES;
        filteredRecipes = [[NSMutableArray alloc] init];
        
        for (Recipe* r in myRecipesFromDB) {
            NSRange recipeNameRange = [r.recipeName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (recipeNameRange.location != NSNotFound) {
                [filteredRecipes addObject:r];
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
