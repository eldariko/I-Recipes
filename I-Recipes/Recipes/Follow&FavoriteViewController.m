//
//  Follow&FavoriteViewController.m
//  Recipes
//
//  This controller presents in separated tabs the current user's favorite recipes and users he\she follows.
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 28/12/15.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "Follow&FavoriteViewController.h"
#import "RecipeDetailsViewController.h"
#import "RecipeFollowTableViewController.h"
#import "Model.h"
@interface Follow_FavoriteViewController ()
{
    NSArray* followFromDB;
    NSArray* favoriteFromDB;
    Follow* follow;

}
@end

@implementation Follow_FavoriteViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // first checks it there is internet connection
    if([CheckInternet checkInternet:self]){
    // initials and sets the "Follow" data into followFromDB array
    followFromDB = [[NSMutableArray alloc] init];
    [[Model instance] getFollowRecipesAsynch:^(NSArray * stArray){
        followFromDB = stArray;
        [self.tableView reloadData];
    }];
    // initials and sets the "Favorite" data into favoriteFromDB array
    favoriteFromDB= [[NSArray alloc] init];
    [[Model instance] getFavoriteRecipesAsynch:^(NSArray * stArray){
        favoriteFromDB = stArray;
        [self.tableView reloadData];
    }];
    follow=nil;
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
    self.tableView=tableView;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView=tableView;
    switch (self.segmentControl.selectedSegmentIndex) {
        // if we are in the follow tab
        case 0:
            return [followFromDB count];
        // if we are in the favorite tab
        case 1:
            return [favoriteFromDB count];
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tableView=tableView;
    Follow_favoriteTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Follow_favoriteCell" forIndexPath:indexPath];
    Recipe* recipe=nil;
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:{
            [cell.activityIndicator startAnimating];
            follow = [followFromDB objectAtIndex:indexPath.row];
            [[Model instance]getUserName:follow.beingFollowed block:^(NSString * name) {
                cell.exclusiveByUser.text=name;
                [cell.activityIndicator stopAnimating];
                cell.activityIndicator.hidden = YES;
            }];
            cell.exclusiveByUser.hidden=NO;
            cell.recipeName.hidden=YES;
            cell.imageView.hidden=YES;
            cell.byName.hidden=YES;
        }
            break;
        case 1:
            cell.recipeName.hidden=NO;
            cell.activityIndicator.hidden=NO;
            cell.imageView.hidden=NO;
            cell.byName.hidden=NO;
            cell.exclusiveByUser.hidden=YES;
            recipe = [favoriteFromDB objectAtIndex:indexPath.row];
            cell.recipeName.text = recipe.recipeName;
            [cell.activityIndicator startAnimating];
            cell.imageName = [NSString stringWithFormat:@"%@.png",recipe.recipeName];
            [[Model instance] getRecipeImage:recipe block:^(UIImage *image) {
                if (image != nil && [cell.imageName isEqualToString:recipe.imageName]) {
                    [cell.imageView setImage:image];
                    [cell.activityIndicator stopAnimating];
                    cell.activityIndicator.hidden = YES;
                }
            }];
            [[Model instance] getUserName:recipe.user block:^(NSString* userName){
                cell.byName.text=userName;
            }];
            break;
    }
    return cell;
}

- (IBAction)segmentChange:(UISegmentedControl *)sender {
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableView=tableView;
    //in case we are in the "Follow" tab
    if(self.segmentControl.selectedSegmentIndex==0){
        follow=[followFromDB objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"toFollowRecipes" sender:self];
    }
    else [self performSegueWithIdentifier:@"toDetailsRecipe" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Recipe* r=nil;
    //if we are in a recipe cell - we already have the recipe's information.
    if([segue.identifier isEqualToString:@"toDetailsRecipe"])
    {
        // sets the RecipeDetailsViewController as segue destination
        RecipeDetailsViewController* rdvc =segue.destinationViewController;
        switch (self.segmentControl.selectedSegmentIndex) {
            // in case we are in the "Follow" tab
            case 0:
                r= [followFromDB objectAtIndex:[self.tableView indexPathForSelectedRow].row];
                rdvc.myRecipe=r;
                break;
            //in case we are in the "Favorite" tab
            case 1:
                r= [favoriteFromDB objectAtIndex:[self.tableView indexPathForSelectedRow].row];
                rdvc.myRecipe=r;
                break;
            default:
                break;
        }
    //if we are in a user's cell - we need to ger all of his\her recipes data
    }else if ([segue.identifier isEqualToString:@"toFollowRecipes"]){
                RecipeFollowTableViewController* rfVC = segue.destinationViewController;
                rfVC.followedUser = follow.beingFollowed;
    }
}

@end
