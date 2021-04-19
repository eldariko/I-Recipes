//
//  RecipeDetailsViewController.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 28/12/15.
//  Copyright © 2015 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "RecipeDetailsViewController.h"

@interface RecipeDetailsViewController ()

@end

@implementation RecipeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([CheckInternet checkInternet:self])
    {
    self.user=[[Model instance] getCurrentUserId];
    self.tableView.hidden=YES;
    self.comment.delegate=self;
    self.recipeName.text=self.myRecipe.recipeName;
    self.ingredients.text=self.myRecipe.ingredients;
    self.directions.text=self.myRecipe.directions;
    [[Model instance] getUserName:self.myRecipe.user block:^(NSString* userName){
        self.chef.text=userName;
    }];
    [[Model instance] getRecipeImage:self.myRecipe block:^(UIImage *image) {
        [self.imageView setImage:image];
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
    }];
    commentsFromDB = [[NSMutableArray alloc] init];
    [[Model instance] getCommentsAsynch:self.myRecipe.recipeId :^(NSArray * stArray){
        commentsFromDB = stArray;
        if(commentsFromDB.count!=0){
            [self.tableView reloadData];
            self.tableView.hidden=NO;
        }
    }];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    [theTextField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return commentsFromDB.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    Comment* comment = [commentsFromDB objectAtIndex:indexPath.row];
    if([CheckInternet checkInternet:self])
    {
    [[Model instance] getUserName:comment.userId block:^(NSString* userName){
       cell.user.text=userName;
    }];
    cell.comment.text = comment.comment;
    }
    return cell;
}

//to mark the current recipe favorite by the current user
- (IBAction)favoriteBtn:(id)sender {
    self.user=[[Model instance] getCurrentUserId];
    Favorites* newFavorite=[[Favorites alloc] init:self.myRecipe.recipeId user:self.user];
    //checks if there is internet connection
    if([CheckInternet checkInternet:self]){
    //calls the addFavoriteAsynch function from the model
    [[Model instance]addFavoriteAsynch:newFavorite  block:^(BOOL flag){
        if(flag==NO){
            NSLog(@"Invalid Input- Add favorite");
        }

    }];
    }
}
// to have the current user follow after the recipe's writer
- (IBAction)followMe:(id)sender {
    Follow* newFollow=[[Follow alloc] init:self.user beingFollowed:self.myRecipe.user];
    //checks if there is internet connection
    if([CheckInternet checkInternet:self])
    {
    //calls the addFollowAsynch function from the model
    [[Model instance] addFollowAsynch:newFollow block:^(BOOL flag){
        if(flag==NO){
            NSLog(@"Invalid Input- Add follow");
        }
    }];
    }
}
// saves the new comment with the current user attached to the recipe.
- (IBAction)saveBtn:(id)sender {
    self.user=[[Model instance] getCurrentUserId];
    Comment* newComment=[[Comment alloc] init:self.myRecipe.recipeId comment:self.comment.text userId:self.user];
    if([CheckInternet checkInternet:self])
    {
    [[Model instance]addCommentAsynch:newComment  block:^(BOOL flag){
        if(flag==NO){
            NSLog(@"Invalid Input- Add comment");
        }
        [[Model instance] getCommentsAsynch:self.myRecipe.recipeId :^(NSArray * stArray){
            commentsFromDB = stArray;
            if(commentsFromDB.count!=0){
                [self.tableView reloadData];
                 self.tableView.hidden=NO;
            }
        }];
        [self.tableView reloadData];

    }];
    }
}
@end
