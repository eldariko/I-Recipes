//
//  RecipeParse.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "RecipeParse.h"
#import <Parse/Parse.h>
#import "Recipe.h"
@implementation RecipeParse

//retrives the current user ID from Parse
-(NSString*)getCurrentUserId{
    PFUser *currentUser = [PFUser currentUser];
    return currentUser.objectId;
}

//add the received recipe* as a new recipe to Parse
-(void)addRecipe:(Recipe*)recipe{
    PFObject* obj = [PFObject objectWithClassName:@"Recipes"];
    // Recipe image
    obj[@"recipeName"] = recipe.recipeName;
    obj[@"ingredients"] = recipe.ingredients;
    obj[@"directions"] = recipe.directions;
    obj[@"imageName"] = recipe.recipeName;
    obj[@"categoryName"] = recipe.categoryName;
    obj[@"user"] = recipe.user;
    [obj save];
    recipe.recipeId = obj.objectId;
   
}
//get all the receipes from Parse which are match the received category
-(NSMutableArray*)getRecipeCategory:(NSString*)category{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Recipes"];
    [query whereKey:@"categoryName" equalTo:category];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
         Recipe* recipe = [[Recipe alloc] init:obj[@"recipeName"] ingredients:obj[@"ingredients"] directions:obj[@"directions"] imageName:obj[@"imageName"] categoryName:obj[@"categoryName"] user:obj[@"user"] recipeId:obj.objectId];
        [array addObject:recipe];
    }
    return array;
}

//get all the recipes from Parse that were shared by the current user
-(NSMutableArray*)getMyRecipes{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Recipes"];
    [query whereKey:@"user" equalTo:[self getCurrentUserId]];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
          Recipe* recipe = [[Recipe alloc] init:obj[@"recipeName"] ingredients:obj[@"ingredients"] directions:obj[@"directions"] imageName:obj[@"imageName"] categoryName:obj[@"categoryName"] user:obj[@"user"] recipeId:obj.objectId];
        [array addObject:recipe];
    }
    return array;
}

//get all the recipes from Parse
-(NSMutableArray*)getRecipes{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Recipes"];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
          Recipe* recipe = [[Recipe alloc] init:obj[@"recipeName"] ingredients:obj[@"ingredients"] directions:obj[@"directions"] imageName:obj[@"imageName"] categoryName:obj[@"categoryName"] user:obj[@"user"] recipeId:obj.objectId];
        [array addObject:recipe];
    }
    return array;
}

 //get all the recipes that were saved in Parse from a certain data (latest SQL update in Ephoc time)
-(NSArray*)getRecipesFromDate:(NSString*)date{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Recipes"];
    NSDate* dated = [NSDate dateWithTimeIntervalSince1970:[date doubleValue]];
    [query whereKey:@"updatedAt" greaterThanOrEqualTo:dated];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
        Recipe* recipe = [[Recipe alloc] init:obj[@"recipeName"] ingredients:obj[@"ingredients"] directions:obj[@"directions"] imageName:obj[@"imageName"] categoryName:obj[@"categoryName"] user:obj[@"user"] recipeId:obj.objectId];
        [array addObject:recipe];
    }
    return array;
}

@end
