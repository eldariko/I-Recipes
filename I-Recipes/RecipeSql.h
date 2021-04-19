//
//  RecipeSql.h
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 05/01/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"
#import <sqlite3.h>
#import "RecipeSql.h"
#import "LastUpdateSql.h"
@interface RecipeSql : NSObject

+(BOOL)createTable:(sqlite3*)database; //creates the "Recipes" table in the SQL database
+(void)addRecipe:(sqlite3*)database recipe:(Recipe*)recipe; //add the received recipe* as a new recipe to SQL
+(NSArray*)getRecipes:(sqlite3*)database; //get all the saved recipes from SQL
+(NSArray*)getMyRecipes:(sqlite3*)database :(NSString*)user; //get all the current user's recipes from SQL
+(NSArray*)getRecipeCategory:(sqlite3*)database :(NSString*)category; //get all the recipes from the current category from SQL
+(void)setRecipesLastUpdateDate:(sqlite3*)database date:(NSString*)date; // calls the setLastUpdateDate from LastUpdateDate class
+(NSString*)getRecipesLastUpdateDate:(sqlite3*)database; //calls the getLastUpdateDate func from LastUpdateSql class
+(void)updateRecipes:(sqlite3*)database recipes:(NSArray*)recipes; //receives an array of recipes and calls the addRecipe func

@end
