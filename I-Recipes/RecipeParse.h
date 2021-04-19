//
//  RecipeParse.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 1/6/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
@interface RecipeParse : NSObject
-(NSString*)getCurrentUserId; //retrives the current user ID from Parse
-(void)addRecipe:(Recipe*)recipe; //add the received recipe* as a new recipe to Parse
-(NSMutableArray*)getRecipeCategory:(NSString*)category; //get all the receipes from Parse which are match the received category
-(NSMutableArray*)getMyRecipes; //get all the recipes from Parse that were shared by the current user
-(NSMutableArray*)getRecipes; //get all the recipes from Parse
-(NSArray*)getRecipesFromDate:(NSString*)date; //get all the recipes that were saved in Parse from a certain data (latest SQL update in Ephoc time)
@end
