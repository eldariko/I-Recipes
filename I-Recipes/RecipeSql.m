//
//  RecipeSql.m
//  Recipes
//
//  Created by Lital Zigron Talia Alaluf Eldar Yaakobi on 05/01/16.
//  Copyright © 2016 Lital Zigron Talia Alaluf Eldar Yaakobi. All rights reserved.
//

#import "RecipeSql.h"

@implementation RecipeSql

static NSString* RECIPE_TABLE = @"RECIPES";
static NSString* RECIPE_ID = @"RECIPE_ID";
static NSString* RECIPE_NAME = @"RECIPE_NAME";
static NSString* RECIPE_CATEGORY = @"CATEGORY";
static NSString* RECIPE_INGREDIENTS = @"INGREDIENTS";
static NSString* RECIPE_DIRECTIONS = @"DIRECTIONS";
static NSString* RECIPE_IMAGE_NAME = @"IMAGE_NAME";
static NSString* RECIPE_USER_ID = @"USER_ID";

+(BOOL)createTable:(sqlite3*)database{
    char* errormsg;
    NSString* sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ TEXT PRIMARY KEY,%@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT,%@ TEXT)",RECIPE_TABLE,RECIPE_ID,RECIPE_NAME,RECIPE_CATEGORY,RECIPE_INGREDIENTS,RECIPE_DIRECTIONS,RECIPE_IMAGE_NAME,RECIPE_USER_ID];
    int res = sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errormsg);
    if(res != SQLITE_OK){
        NSLog(@"ERROR: failed creating RECIPES table");
        return NO;
    }
    return YES;
}


+(void)addRecipe:(sqlite3*)database recipe:(Recipe*)recipe{
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@,%@,%@,%@,%@,%@,%@) values (?,?,?,?,?,?,?);",RECIPE_TABLE,RECIPE_ID,RECIPE_NAME,RECIPE_CATEGORY,RECIPE_INGREDIENTS,RECIPE_DIRECTIONS,RECIPE_IMAGE_NAME,RECIPE_USER_ID];
    if (sqlite3_prepare_v2(database,[query UTF8String],-1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [recipe.recipeId UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 2, [recipe.recipeName UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 3, [recipe.categoryName UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 4, [recipe.ingredients UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 5, [recipe.directions UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 6, [recipe.imageName UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 7, [recipe.user UTF8String],-1,NULL);
        if(sqlite3_step(statment) == SQLITE_DONE){
            return;
        }
    }
    
    NSLog(@"ERROR: addRecipe failed %s",sqlite3_errmsg(database));
}

+(NSArray*)getRecipes:(sqlite3*)database{
    NSMutableArray* data = [[NSMutableArray alloc] init];
    sqlite3_stmt *statment;
    if (sqlite3_prepare_v2(database,"SELECT * from RECIPES;", -1,&statment,nil) == SQLITE_OK){
        while(sqlite3_step(statment) == SQLITE_ROW){
            NSString* recipeId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
            NSString* recipeName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,1)];
            NSString* categoryName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,2)];
            NSString* ingredients = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,3)];
            NSString* directions = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,4)];
            NSString* imageName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,5)];
            NSString* user = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,6)];
            Recipe* recipe = [[Recipe alloc] init:recipeName ingredients:ingredients directions:directions imageName:imageName categoryName:categoryName user:user recipeId:recipeId];
            [data addObject:recipe];
        }
    }else{
        NSLog(@"ERROR: getRECIPES failed %s",sqlite3_errmsg(database));
        return nil;
    }
    return data;
}
+(NSArray*)getMyRecipes:(sqlite3*)database :(NSString*)user{
    NSMutableArray* data = [[NSMutableArray alloc] init];
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"SELECT * from %@ where %@ = ?;",RECIPE_TABLE,RECIPE_USER_ID];
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [user UTF8String],-1,NULL);
        while(sqlite3_step(statment) == SQLITE_ROW){
            NSString* recipeId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
            NSString* recipeName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,1)];
            NSString* categoryName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,2)];
            NSString* ingredients = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,3)];
            NSString* directions = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,4)];
            NSString* imageName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,5)];
            NSString* user = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,6)];
            Recipe* recipe = [[Recipe alloc] init:recipeName ingredients:ingredients directions:directions imageName:imageName categoryName:categoryName user:user recipeId:recipeId];
            [data addObject:recipe];
        }
    }else{
        NSLog(@"ERROR: getRECIPES failed %s",sqlite3_errmsg(database));
        return nil;
    }
    return data;
}
+(NSArray*)getRecipeCategory:(sqlite3*)database :(NSString*)category{
    NSMutableArray* data = [[NSMutableArray alloc] init];
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"SELECT * from %@ where %@ = ?;",RECIPE_TABLE,RECIPE_CATEGORY];
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [category UTF8String],-1,NULL);
        while(sqlite3_step(statment) == SQLITE_ROW){
            NSString* recipeId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
            NSString* recipeName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,1)];
            NSString* categoryName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,2)];
            NSString* ingredients = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,3)];
            NSString* directions = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,4)];
            NSString* imageName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,5)];
            NSString* user = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,6)];
            Recipe* recipe = [[Recipe alloc] init:recipeName ingredients:ingredients directions:directions imageName:imageName categoryName:categoryName user:user recipeId:recipeId];
            [data addObject:recipe];
        }
    }else{
        NSLog(@"ERROR: getRECIPES failed %s",sqlite3_errmsg(database));
        return nil;
    }
    return data;
}

+(NSString*)getRecipesLastUpdateDate:(sqlite3*)database{
    return [LastUpdateSql getLastUpdateDate:database forTable:RECIPE_TABLE];
}

+(void)setRecipesLastUpdateDate:(sqlite3*)database date:(NSString*)date{
    [LastUpdateSql setLastUpdateDate:database date:date forTable:RECIPE_TABLE];
}
// updates the SQL Recipe table
+(void)updateRecipes:(sqlite3*)database recipes:(NSArray*)recipes{
    for (Recipe* r in recipes) {
        [RecipeSql addRecipe:database recipe:r];
    }
}
@end
